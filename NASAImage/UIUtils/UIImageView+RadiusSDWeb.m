//
//  UIImageView+RadiusSDWeb.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "UIImageView+RadiusSDWeb.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Utils.h"

@implementation UIImageView (RadiusSDWeb)

- (void)setRadiusImageWithUrl:(NSString *)url placeHolder:(NSString *)placeHolderStr radius:(CGFloat)radius {
    if (radius != 0.0) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UIImage *smallimage = [UIImage compressImageWith:image];
                    UIImage *radiusImage = [smallimage imageCornerRadius:40.f];
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:url completion:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = radiusImage;
                    });
                });
            }else {
                NSLog(@"获取图片失败");
            }
        }];
    }
    else {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}


@end
