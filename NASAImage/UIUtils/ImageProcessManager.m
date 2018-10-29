//
//  ImageProcessManager.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/30.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageProcessManager.h"
#import "NASAImageModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Utils.h"


@interface ImageProcessManager ()
@property (nonatomic, strong) dispatch_queue_t q;
@end

@implementation ImageProcessManager

+ (instancetype)sharedInstance {
    static ImageProcessManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ImageProcessManager alloc] init];
        manager.processedURL = [[NSMutableDictionary alloc] init];
        manager.q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    });
    return manager;
}

- (BOOL)processedForURL:(NSString *)url {
    __block BOOL processed;
    dispatch_sync(self.q, ^{
        processed = ((NSNumber *) [self.processedURL valueForKey:url]).boolValue;
    });
    return processed;
}

- (void)setProcessedForURL:(NSString *)url {
    dispatch_barrier_async(self.q, ^{
        [self.processedURL setObject:@(1) forKey:url];
    });
}

- (void)preloadImagesWithModels:(NSArray *)models {
    for (int i = 0; i < models.count; i++) {
        NASAImageModel * model = [models objectAtIndex:i];
        if (model) {
            [self fetchRadiusImageWithUrl:model.imageURL radius:40.f];
        }
    }
}

- (void)fetchRadiusImageWithUrl:(NSString *)url radius:(CGFloat)radius {
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!error) {
            if (![[ImageProcessManager sharedInstance] processedForURL:url]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UIImage *smallimage = [UIImage compressImageWith:image];
                    UIImage *radiusImage = [smallimage imageCornerRadius:40.f];
                    [[ImageProcessManager sharedInstance] setProcessedForURL:url];
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:url completion:nil];
                });
            }
        }else {
            NSLog(@"获取图片失败");
        }
    }];
}
@end
