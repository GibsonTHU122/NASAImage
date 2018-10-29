//
//  UIImageView+RadiusSDWeb.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (RadiusSDWeb)
- (void)setRadiusImageWithUrl:(NSString *)url placeHolder:(NSString *)placeHolderStr radius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
