//
//  ImageTransitioningDelegate.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/27.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageTransitioningDelegate.h"
#import "UIImageView+WebCache.h"

@interface ImageTransitioningDelegate ()
@property(nonatomic, assign) CGRect BIGFrame;
@end

@implementation ImageTransitioningDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.BIGFrame = [self getBIGImageViewFrame];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresented){
        [self animationForPresentView:transitionContext];
    } else{
        [self animationForDismissView:transitionContext];
    }
}

- (void)animationForPresentView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:presentView];
    CGRect startRect =  self.cellFrame;
    CGRect endRect = self.BIGFrame;
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imgURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"获取图片失败");
        }
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = startRect;
    presentView.alpha = 0;
    transitionContext.containerView.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = endRect;
    }completion:^(BOOL finished) {
        presentView.alpha = 1.0;
        [imageView removeFromSuperview];
        transitionContext.containerView.backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
}

- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [dismissView removeFromSuperview];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imgURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"获取图片失败");
        }
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = self.BIGFrame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = self.cellFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (CGRect)getBIGImageViewFrame{
    if(iPhoneX) {
        return CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 238);
    }else {
        return CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 180);
    }
}

@end
