//
//  UIImage+Utils.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultRadius 40.f

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)
+ (UIImage *)svgImageNamed:(NSString *)name;
- (UIImage *)imageCornerRadius:(CGFloat)radius;
+ (UIImage *)compressImageWith:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
