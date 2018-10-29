//
//  SplashView.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/29.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "SplashView.h"
#import "UIImage+Utils.h"

@interface SplashView ()
@property (nonatomic) UIViewController *root;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *titleImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) NSTimer * dismissTimer;
@property (nonatomic, assign) NSTimeInterval remainingTime;
@end

@implementation SplashView

- (void)setupWithWindow:(UIWindow *)window {
    self.root = window.rootViewController;
    self.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}


- (void)setupSubViews{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, UIScreen.mainScreen.bounds.size.width - 30, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"我们的征途是星辰大海";
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 230, UIScreen.mainScreen.bounds.size.width - 30, (UIScreen.mainScreen.bounds.size.width - 30) * 2 / 3)];
    UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"work" ofType:@"jpg"]];
    [self.titleImgView setImage:image];
    [self addSubview:self.titleImgView];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width / 2 - 10, UIScreen.mainScreen.bounds.size.height - 120, 20, 20)];
    self.imgView.image = [UIImage svgImageNamed:@"Loading"];
    [self addSubview:self.imgView];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    [self.imgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 45, 60, 30, 20)];
    NSString * title = @"3s";
    self.skipButton.clipsToBounds = YES;
    self.skipButton.layer.cornerRadius = 10.f;
    self.skipButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.skipButton setTitle:title forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.skipButton addTarget:self action:@selector(skipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.skipButton];
}

- (void)show:(NSTimeInterval)duration {
    self.remainingTime = duration;
    [self.root.view addSubview:self];
    self.frame = self.root.view.frame;
    [self updateTimer];
}

- (void)dismissTimerFired:(NSTimer *)timer {
    if (self.remainingTime <= 1.0) {
        [self.dismissTimer invalidate];
        self.dismissTimer = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismiss:YES];
        });
    } else {
        self.remainingTime -= 1.0;
        [self updateTimer];
    }
}

- (void)updateTimer {
    NSString * title = [NSString stringWithFormat:@"%.0fs", round(self.remainingTime)];
    [self.skipButton setTitle:title forState:UIControlStateNormal];
    [self.skipButton setTitle:title forState:UIControlStateHighlighted];
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(dismissTimerFired:)
                                                       userInfo:nil
                                                        repeats:NO];
}

- (void)dismiss:(BOOL)animated {
    if (self.dismissTimer && [self.dismissTimer isValid]) {
        [self.dismissTimer invalidate];
        self.dismissTimer = nil;
    }
    if (animated) {
        [UIView animateWithDuration:0.7
                         animations:^{
                             self.alpha = 0.0;
                             self.transform = CGAffineTransformMakeScale(2.0, 2.0);
                         }
                         completion:^(BOOL finished) {
                             if (self.window.windowLevel == UIWindowLevelNormal) {
                                 [self removeFromSuperview];
                             }
                         }];
    } else {
        self.hidden = YES;
    }
}

- (void)skipButtonPressed:(id)sender {
    [self dismiss:YES];
}

@end
