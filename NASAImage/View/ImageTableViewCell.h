//
//  ImageTableViewCell.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NASAImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ImageTableViewCell;

@protocol ImageTableViewCellDelegate <NSObject>
- (void)imageTableViewCell:(ImageTableViewCell *)cell didTapIndex:(NSInteger)idx withCellFrame:(CGRect)cellFrame;
@end

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewA;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewB;
- (void)setupWithmodelA:(NASAImageModel *)modelA modelB:(NASAImageModel *)modelB rowindex:(NSInteger)idx;
@property (nonatomic, weak) id<ImageTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
