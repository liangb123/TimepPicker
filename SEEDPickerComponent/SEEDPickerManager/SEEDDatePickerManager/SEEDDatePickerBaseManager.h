//
//  SEEDDatePickerBaseManager.h
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDPickerDateConfig.h"
#import "SEEDPickerBasicProtocol.h"
@class SEEDPickerSectionItem;

@interface SEEDDatePickerBaseManager : NSObject<SEEDPickerManagerBasicDelegate>

//实例的类型
@property (nonatomic, assign) EHIDateComponentType type;

#pragma mark   ------   init && abstract function    ------
/**
 根据枚举值返回不同的子类

 @param type  根场景对应的枚举值
 @return      mangner子类
 */
+ (instancetype)initWithType:(EHIDateComponentType)type;


/**
 根据type 生成一个含有默认数据的选择器

 @param type  根场景对应的枚举值
 @return      时间数据源
 */
+ (NSMutableArray<SEEDPickerSectionItem *>*)initNormalDatePickerWithType:(EHIDateComponentType)type;


/**
 生产不同的子类需要的数据源

 @param isZh             是否显示中文年月日
 @param minuteInterval   分钟的间隔
 @param mindate          可滑动的最小时间(格式遵循 @"yyyy-MM-dd HH:mm:ss") (不需要则传 nil)

 @return     时间数据源 
 */
- (NSMutableArray <SEEDPickerSectionItem *>*)creatDateArrayWithIszh:(BOOL)isZh
                                             withminuteInterval:(NSInteger)minuteInterval
                                                    withMinDate:(NSDate*)mindate;



#pragma mark   ------   tool function    ------

/**
 拨动选择器后 刷新数据源

 @param item       数据源
 */
- (void)refreshStorageDataWithItem:(SEEDPickerSectionItem*)item;


/**
 选中之后 刷新数据 保持不同item中的数据同步
 
 @param item       当前需要变动数据
 @param targetItem 变动来源数据
 */
- (void)afterSeletedRefreshDataWithItem:(SEEDPickerSectionItem*)item
                             targetItem:(SEEDPickerSectionItem*)targetItem;


/**
 根据年份和月份 获取具体的天数

 @param year  年份信息
 @param month 月份信息
 @return      该月份具体有多少天
 */
- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month;


/**
 获取当前选择的时间
 
 @param item 数据源
 @return     currentSelectDate
 */
- (NSDate *)loadCurrentSelectDateWithItem:(SEEDPickerSectionItem *)item;

/**
 比较两次选择的结果

 @param oldDate     上次的时间
 @param sourceDate  新选择的时间
 @return            比较的结果
 */
- (NSComparisonResult)compateWithOldDate:(NSDate*)oldDate
                              sourceDate:(NSDate*)sourceDate;

@end

