//
//  NASAImageModel.h
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NASAImageModel : NSObject
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;
@end

NS_ASSUME_NONNULL_END
