//
//  SplashView.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashView : UIView
- (void)setupWithWindow:(UIWindow *)window;
- (void)show:(NSTimeInterval)duration;
@end

NS_ASSUME_NONNULL_END
