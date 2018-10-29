//
//  ImageModelManager.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NASAImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageModelManager : NSObject
- (instancetype)initWithRSSURL:(NSString *)url;
- (NSArray *)getImageModels;
@end

NS_ASSUME_NONNULL_END
