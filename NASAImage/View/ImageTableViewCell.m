//
//  ImageTableViewCell.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "UIImage+Utils.h"
#import "UIImageView+WebCache.h"

@interface ImageTableViewCell ()
@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupWithmodelA:(NASAImageModel *)modelA modelB:(NASAImageModel *)modelB rowindex:(NSInteger)idx{
    if (modelA) {
        [self.imageViewA sd_setImageWithURL:[NSURL URLWithString:modelA.imageURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                UIImage *radiusImage = [image imageCornerRadius:40.f];
                self.imageViewA.image = radiusImage;
                [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:modelA.imageURL completion:nil];
            }else {
                NSLog(@"获取图片失败");
            }
        }];
        self.imageViewA.tag = idx * 2;
        self.imageViewA.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImage:)];
        [self.imageViewA addGestureRecognizer:tap];
    }
    if (modelB) {
        [self.imageViewB sd_setImageWithURL:[NSURL URLWithString:modelB.imageURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                UIImage *radiusImage = [image imageCornerRadius:40.f];
                self.imageViewB.image = radiusImage;
                [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:modelB.imageURL completion:nil];
            }else {
                NSLog(@"获取图片失败");
            }
        }];
        self.imageViewB.tag = idx * 2 + 1;
        self.imageViewB.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImage:)];
        [self.imageViewB addGestureRecognizer:tap];
    }
}

- (void)openImage:(id)sender{
    UIView * view = ((UIGestureRecognizer *)sender).view;
    CGRect frame = [view convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    frame.origin.x = frame.origin.x / 2;
    frame.origin.y = frame.origin.y - 15;
    if ([self.delegate respondsToSelector:@selector(imageTableViewCell:didTapIndex:withCellFrame:)]) {
        [self.delegate imageTableViewCell:self didTapIndex:view.tag withCellFrame:frame];
    }
}

@end
