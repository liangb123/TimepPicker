//
//  SEEDPickerYMManager.m
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 LB. All rights reserved.
//

#import "SEEDPickerYMManager.h"
#import "SEEDPickerSectionItem.h"
#import "SEEDPickeDateModel.h"

/** yyyy-mm  */
@implementation SEEDPickerYMManager

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

    SEEDPickerSectionItem *yearItem = [SEEDPickerSectionItem new];
    //优先给config赋值
    yearItem.config = config;
    [yearItem.dataArray addObjectsFromArray:config.yearArray];
    [dataSource addObject:yearItem];

    SEEDPickerSectionItem *monthItem = [SEEDPickerSectionItem new];
    monthItem.config = config;
    [monthItem.dataArray addObjectsFromArray:config.monthArray];
    [dataSource addObject:monthItem];

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
        SEEDPickerDateConfig *subConfig = (SEEDPickerDateConfig *)obj.config;
        switch (idx) {
            case 0:{
                NSInteger row = [obj.dataArray indexOfObject:config.year];
                if (row < obj.dataArray.count) {
                    [pickerView selectRow:row inComponent:0 animated:NO];
                    subConfig.year = config.year;
                }
            }
                break;
            case 1:{
                NSInteger row = [obj.dataArray indexOfObject:config.month];
                if (row < obj.dataArray.count) {
                    [pickerView selectRow:row inComponent:1 animated:NO];
                    subConfig.month = config.month;
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
                NSString *year = [item.dataArray objectAtIndex:row];
                sourceConfig.year = year;
            }
                break;

            case 1:
            {
                NSString *month = [item.dataArray objectAtIndex:row];
                sourceConfig.month = month;
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
    SEEDPickerSectionItem *itemYear = [dateSource objectAtIndex:0];
    NSString *year = [itemYear.dataArray objectAtIndex:0];
    sourceConfig.year = year;
    
    SEEDPickerSectionItem *itemMonth = [dateSource objectAtIndex:1];
    NSString *month = [itemMonth.dataArray objectAtIndex:0];
    sourceConfig.month = month;
    
    SEEDPickeDateModel *model = [SEEDPickeDateModel createModelWithConfig:sourceConfig];
    self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
    
}


//比较两个时间 来决定是否可选
- (void)compareMindateWithRow:(NSInteger)row inComponent:(NSInteger)component
                     withItem:(SEEDPickerSectionItem*)item
               withDataSource:(NSMutableArray *)dateSource{
    SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
    //获取新选择的时间
    NSDate *currentSelectDate = [super loadCurrentSelectDateWithItem:item];
    NSComparisonResult result = [super compateWithOldDate:sourceConfig.mindate sourceDate:currentSelectDate];
    if (result != NSOrderedAscending) {
        NSInteger redirectRow = 0;
        switch (component) {
            case 0:{
                redirectRow = [sourceConfig.yearArray indexOfObject:sourceConfig.minYear];
            }
                break;
            case 1:{
                redirectRow = [sourceConfig.monthArray indexOfObject:sourceConfig.minMonth];
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


