//
//  ImageProcessManager.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/30.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageProcessManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *processedURL;
+ (instancetype)sharedInstance;
- (BOOL)processedForURL:(NSString *)url;
- (void)setProcessedForURL:(NSString *)url;
- (void)preloadImagesWithModels:(NSArray *)models;
- (void)fetchRadiusImageWithUrl:(NSString *)url radius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
