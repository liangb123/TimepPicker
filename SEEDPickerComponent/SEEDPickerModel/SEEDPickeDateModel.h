//
//  SEEDPickeDateModel.h
//  driver
//
//  Created by liangbing on 2019/6/18.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SEEDPickerDateConfig;

NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickeDateModel : NSObject
/** 选中年 */
@property (nonatomic, copy) NSString *year;
/** 选中月 */
@property (nonatomic, copy) NSString *month;
/** 选中天 */
@property (nonatomic, copy) NSString *day;
/** 选中时 */
@property (nonatomic, copy) NSString *hour;
/** 选中分 */
@property (nonatomic, copy) NSString *minute;
/** 选中秒 */
@property (nonatomic, copy) NSString *second;

//根据配置文件 生成对应的model
+ (SEEDPickeDateModel *)createModelWithConfig:(SEEDPickerDateConfig*)config;

@end

NS_ASSUME_NONNULL_END
