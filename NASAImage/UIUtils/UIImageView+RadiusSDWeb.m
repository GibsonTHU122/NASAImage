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
        NSString *cacheurlStr = [url stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }else {
            [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolderStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [image imageCornerRadius:radius];
                    self.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr completion:nil];
                }
            }];
        }
    }
    else {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}

@end
