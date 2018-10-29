//
//  UIImage+Utils.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "UIImage+Utils.h"
#import "SVGKImage.h"

@implementation UIImage (Utils)

+ (UIImage *)svgImageNamed:(NSString *)name{
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    return svgImage.UIImage;
}

- (UIImage*)imageCornerRadius:(CGFloat)radius{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -self.size.height);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path closePath];
    CGContextSaveGState(context);
    [path addClip];
    CGContextDrawImage(context, rect, self.CGImage);
    CGContextRestoreGState(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
