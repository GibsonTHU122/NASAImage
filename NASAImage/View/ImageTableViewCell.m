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
#import "UIImageView+RadiusSDWeb.h"

@interface ImageTableViewCell ()
@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupWithmodelA:(NASAImageModel *)modelA modelB:(NASAImageModel *)modelB rowindex:(NSInteger)idx{
    [self setupImageView:self.imageViewA withModel:modelA index:idx * 2];
    [self setupImageView:self.imageViewB withModel:modelB index:(idx * 2 + 1)];
}

- (void)setupImageView:(UIImageView *)imageView withModel:(NASAImageModel *)model index:(NSInteger)idx{
    if (model) {
        [imageView setRadiusImageWithUrl:model.imageURL placeHolder:@"placeHolder" radius:DefaultRadius];
        imageView.tag = idx;
        imageView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImage:)];
        [imageView addGestureRecognizer:tap];
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
