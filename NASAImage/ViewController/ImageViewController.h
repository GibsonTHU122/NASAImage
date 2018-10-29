//
//  ImageViewController.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NASAImageModel.h"
#import "ImageTransitioningDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (nonatomic, strong) NASAImageModel *imageModel;
@property (nonatomic, strong) ImageTransitioningDelegate *imageTransitioningDelegate;
@end

NS_ASSUME_NONNULL_END
