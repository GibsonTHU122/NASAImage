//
//  ImageTransitioningDelegate.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/27.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iPhoneX ((ABS(MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) / MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) - 812 / 375.0) < 0.01) || (ABS(MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) / MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) - 896 / 414.0) < 0.01))


NS_ASSUME_NONNULL_BEGIN

@interface ImageTransitioningDelegate : NSObject  <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) BOOL isPresented;
@property(nonatomic, assign) CGRect cellFrame;
@property(nonatomic, copy) NSString *imgURL;
@end

NS_ASSUME_NONNULL_END
