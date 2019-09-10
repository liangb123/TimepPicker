//
//  SEEDPickerAnimalConfig.h
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDPickerBasicProtocol.h"
@class SEEDPickeAnimalModel;

NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickerAnimalConfig : NSObject<NSCopying, NSMutableCopying,SEEDPickerItemDelegate>

/** 名字组 */
@property (nonatomic, strong) NSMutableArray *nameArray;
/** 体重组 */
@property (nonatomic, strong) NSMutableArray *weightArray;
/** 名字 */
@property (nonatomic, copy  ) NSString *name;
/** 体重 */
@property (nonatomic, copy  ) NSString *weight;

/** 便利类构造器 */
+ (SEEDPickerAnimalConfig *)defaultConfig;
+ (SEEDPickerAnimalConfig *)createConfigWithModel:(SEEDPickeAnimalModel *)model;

@end

NS_ASSUME_NONNULL_END
