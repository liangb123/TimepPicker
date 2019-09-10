//
//  SEEDPickerDateConfig.h
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDPickerBasicProtocol.h"

@interface SEEDPickerDateConfig : NSObject<NSCopying, NSMutableCopying,SEEDPickerItemDelegate>

/** 是否显示中文 优先
 'YES' eg: 2018年-01月-01日
 'NO'  eg: 2018-01-01
 */
@property (nonatomic, assign) BOOL isZh;
//实例的类型
@property (nonatomic, assign) EHIDateComponentType type;
/** 分钟数的间隔 */
@property (nonatomic, assign) NSInteger minuteInterval;
/** 年份数组 */
@property (nonatomic, strong) NSMutableArray *yearArray;
/** 月份数组 */
@property (nonatomic, strong) NSMutableArray *monthArray;
/** 日数组 */
@property (nonatomic, strong) NSMutableArray *dayArray;
/** 时数组 */
@property (nonatomic, strong) NSMutableArray *hourArray;
/** 分数组 */
@property (nonatomic, strong) NSMutableArray *minuteArray;
/** 秒数组 */
@property (nonatomic, strong) NSMutableArray *secondArray;
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

/** 可选择的最小时间 及其具体拆分 */
@property (nonatomic, strong) NSDate *mindate;
@property (nonatomic, copy) NSString *minYear;
@property (nonatomic, copy) NSString *minMonth;
@property (nonatomic, copy) NSString *minDay;
@property (nonatomic, copy) NSString *minHour;
@property (nonatomic, copy) NSString *minMinute;
@property (nonatomic, copy) NSString *minSecond;

/** 生成一个含有默认属性的config */
+ (SEEDPickerDateConfig *)defaultConfig;

/** 根据时间信息生成config */
+ (SEEDPickerDateConfig *)cteateFonfigWithDate:(NSDate *)date withIszh:(BOOL)isZh;

@end

