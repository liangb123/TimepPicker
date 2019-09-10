//
//  SEEDPickerBasicProtocol.h
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef DateBasicProtocol_h
#define DateBasicProtocol_h
#import "SEEDPickerDefines.h"

@class SEEDPickerSectionItem;

typedef void(^selectBlcok)(id date);


#pragma mark   ------   SEEDPickerViewDelegate    ------
/** PickerView 需要遵循这个协议 */
@protocol SEEDPickerViewDelegate <NSObject>

@property (nonatomic, copy) selectBlcok didSelectBlock;


/**
 同时含有月-天时， 改变月份后，刷新对应的天数

 @param component   选择所在的component
 @param item        数据源
 */
- (void)reloadDataWithComponent:(NSInteger)component withItem:(SEEDPickerSectionItem *)item;

/**
 错误或者违规选择后，重定向到之前的选择
 
 @param row         选择所在的row
 @param component   选择所在的component
 */
- (void)redirectSelectWithWithRow:(NSInteger)row inComponent:(NSInteger)component;

@end





#pragma mark   ------   SEEDPickerItemDelegate    ------
/** 所有PickerView对应的item 都需要遵循这个协议 */
@protocol SEEDPickerItemDelegate <NSObject>

/** Mannger对应的CLassname */
- (NSString *)loadManagerClassName;

@end






#pragma mark   ------   SEEDPickerManagerBasicDelegate    ------
/** 所有PickerView对应的manager 都需要遵循这个协议 */
@protocol SEEDPickerManagerBasicDelegate <NSObject>

//实例的类型
@property (nonatomic, assign) EHIDateComponentType type;

//操作时间选择器后将结果通知到VC
@property (nonatomic, weak  ) id<SEEDPickerViewDelegate> delegate;

@required

/**
 跳转到指定时间
 
 @param pickerView 选择器本体
 @param data       指定的数据
 @param dateSource 数据源
 */
- (void)pickerView:(UIPickerView*)pickerView selectSpecifiedData:(id)data
    withDataSource:(NSMutableArray<SEEDPickerSectionItem*> *)dateSource;

/**
 选中具体的时间
 
 @param row        具体选中的行
 @param component  选中的列
 @param item       选中的数据源
 @param dateSource 整体的数据源
 */
- (void)didSelectRow:(NSInteger)row
         inComponent:(NSInteger)component
            withItem:(SEEDPickerSectionItem*)item
      withDataSource:(NSMutableArray *)dateSource;


@optional


/**
 同时包含月-天   切换月份需要刷新天数

 @param item        数据源
 @param targetItem  当前操作的数据源
 */
- (void)refreshDayWithItem:(SEEDPickerSectionItem*)item
            withTargetItem:(SEEDPickerSectionItem *)targetItem;
@end


#endif /* DateBasicProtocol_h */
