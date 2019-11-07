//
//  SEEDPickerHMManager.m
//  driver
//
//  Created by liangbing on 2019/7/29.
//  Copyright © 2019 LB. All rights reserved.
//

#import "SEEDPickerHMManager.h"
#import "SEEDPickerSectionItem.h"
#import "SEEDPickeDateModel.h"

@implementation SEEDPickerHMManager

- (NSMutableArray <SEEDPickerSectionItem *>*)creatDateArrayWithIszh:(BOOL)isZh
                                                 withminuteInterval:(NSInteger)minuteInterval
                                                        withMinDate:(NSDate*)mindate{
    
    NSMutableArray *dataSource = [NSMutableArray array];
    SEEDPickerDateConfig *config = [SEEDPickerDateConfig defaultConfig];
    //优先给iszh赋值
    config.isZh = isZh;
    config.type = self.type;
    config.mindate = mindate;
    config.minuteInterval = minuteInterval;
    
    SEEDPickerSectionItem *hourItem = [SEEDPickerSectionItem new];
    hourItem.config = config;
    [hourItem.dataArray addObjectsFromArray:config.hourArray];
    [dataSource addObject:hourItem];
    
    SEEDPickerSectionItem *minuteItem = [SEEDPickerSectionItem new];
    minuteItem.config = config;
    [minuteItem.dataArray addObjectsFromArray:config.minuteArray];
    [dataSource addObject:minuteItem];
    
    return dataSource;
    
}

//跳到指定位置
- (void)pickerView:(UIPickerView *)pickerView
selectSpecifiedData:(NSDate *)data
    withDataSource:(NSMutableArray<SEEDPickerSectionItem *> *)dateSource{
    
    SEEDPickerSectionItem *item = [dateSource objectAtIndex:0];
    SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
    NSComparisonResult result = [super compateWithOldDate:sourceConfig.mindate sourceDate:data];
    if (result == NSOrderedDescending) {
        data = sourceConfig.mindate;
    }
    
    SEEDPickerDateConfig *config = [SEEDPickerDateConfig createConfigWithDate:data withIszh:sourceConfig.isZh];
    [dateSource enumerateObjectsUsingBlock:^(SEEDPickerSectionItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEEDPickerDateConfig *currentConfig = (SEEDPickerDateConfig *) obj.config;
        switch (idx) {
            case 0:{
                NSInteger row = [obj.dataArray indexOfObject:config.hour];
                if (row < obj.dataArray.count) {
                    [pickerView selectRow:row inComponent:0 animated:NO];
                    currentConfig.hour = config.hour;
                }
            }
                break;
            case 1:{
                NSInteger row = [obj.dataArray indexOfObject:config.minute];
                if (row < obj.dataArray.count) {
                    [pickerView selectRow:row inComponent:1 animated:NO];
                    currentConfig.minute = config.minute;
                }
            }
                break;
        }
    }];
    SEEDPickeDateModel *model = [SEEDPickeDateModel createModelWithConfig:config];
    self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
}

//选中某行后
- (void)didSelectRow:(NSInteger)row
         inComponent:(NSInteger)component
            withItem:(SEEDPickerSectionItem*)item
      withDataSource:(NSMutableArray *)dateSource{
    
    if (item) {
        SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
        switch (component) {
            case 0:
            {
                NSString *hour = [item.dataArray objectAtIndex:row];
                sourceConfig.hour = hour;
            }
                break;
                
            case 1:
            {
                NSString *minute = [item.dataArray objectAtIndex:row];
                sourceConfig.minute = minute;
            }
                break;
        }
        if (sourceConfig.mindate) {
            [self compareMindateWithRow:row inComponent:component withItem:item withDataSource:dateSource];
        }
        //点击事件
        SEEDPickeDateModel *model = [SEEDPickeDateModel createModelWithConfig:sourceConfig];
        self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
    }
}

//在不指定具体SpecifiedData时，默认选中第一行数据
- (void)selectFirstLineValueWith:(NSMutableArray *)dateSource {
    
    SEEDPickerDateConfig *sourceConfig = [SEEDPickerDateConfig defaultConfig];
    SEEDPickerSectionItem *itemHour = [dateSource objectAtIndex:0];
    NSString *hour = [itemHour.dataArray objectAtIndex:0];
    sourceConfig.hour = hour;
    
    SEEDPickerSectionItem *itemMinute = [dateSource objectAtIndex:1];
    NSString *minute = [itemMinute.dataArray objectAtIndex:0];
    sourceConfig.minute = minute;
     
    SEEDPickeDateModel *model = [SEEDPickeDateModel createModelWithConfig:sourceConfig];
    self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
    
}


//比较两个时间 来决定是否可选
- (void)compareMindateWithRow:(NSInteger)row
                  inComponent:(NSInteger)component
                     withItem:(SEEDPickerSectionItem*)item
               withDataSource:(NSMutableArray *)dateSource{
    //获取新选择的时间
    NSDate *currentSelectDate = [super loadCurrentSelectDateWithItem:item];
    SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
    NSComparisonResult result = [super compateWithOldDate:sourceConfig.mindate sourceDate:currentSelectDate];
    if (result != NSOrderedAscending) {
        NSInteger redirectRow = 0;
        switch (component) {
            case 0:{
                redirectRow = [sourceConfig.hourArray indexOfObject:sourceConfig.minHour];
            }
                break;
            case 1:{
                redirectRow = [sourceConfig.minuteArray indexOfObject:sourceConfig.minMinute];
            }
                break;
        }
        //不允许选择
        if ([self.delegate respondsToSelector:@selector(redirectSelectWithWithRow:inComponent:)]){
            [self.delegate redirectSelectWithWithRow:redirectRow  inComponent:component];
        }
        //刷新数据 避免错乱
        [super refreshStorageDataWithItem:item];
    }
}

@synthesize delegate;

@end

