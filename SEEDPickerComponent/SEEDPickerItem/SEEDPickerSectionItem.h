//
//  SEEDPickerSectionItem.h
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "SEEDPickerDateConfig.h"
#import "SEEDPickerBasicProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickerSectionItem : NSObject<NSCopying, NSMutableCopying>
/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** 配置信息 */
@property (nonatomic, strong) id<SEEDPickerItemDelegate> config;

@end

NS_ASSUME_NONNULL_END
