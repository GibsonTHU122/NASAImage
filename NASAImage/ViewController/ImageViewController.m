//
//  ImageViewController.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+RadiusSDWeb.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[UIColor blackColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}

- (void)setupSubViews{
    [self.imageView setRadiusImageWithUrl:self.imageModel.imageURL placeHolder:@"placeHolder" radius:DefaultRadius];
    self.titleLabel.text = self.imageModel.title;
    self.desLabel.text = self.imageModel.des;
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeImageVC)];
    self.bgView.userInteractionEnabled = YES;
    [self.bgView addGestureRecognizer:tap];
}

- (void)closeImageVC {
    self.imageTransitioningDelegate.isPresented = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
