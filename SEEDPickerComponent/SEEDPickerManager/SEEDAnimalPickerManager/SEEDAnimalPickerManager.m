//
//  SEEDAnimalPickerManager.m
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "SEEDAnimalPickerManager.h"
#import "SEEDPickerAnimalConfig.h"
#import "SEEDPickerSectionItem.h"
#import "SEEDPickeAnimalModel.h"

@implementation SEEDAnimalPickerManager

@synthesize delegate;

- (NSMutableArray <SEEDPickerSectionItem *>*)creatAnimalDataArray{
    
    NSMutableArray *dataSource = [NSMutableArray array];
    SEEDPickerAnimalConfig *config = [SEEDPickerAnimalConfig defaultConfig];
    
    SEEDPickerSectionItem *nameItem = [SEEDPickerSectionItem new];
    //优先给config赋值
    nameItem.config = config;
    [nameItem.dataArray addObjectsFromArray:config.nameArray];
    [dataSource addObject:nameItem];
   
    
    SEEDPickerSectionItem *weightItem = [SEEDPickerSectionItem new];
    weightItem.config = config;
    [weightItem.dataArray addObjectsFromArray:config.nameArray];
    [dataSource addObject:weightItem];
    
    return dataSource;
    
}

/** 跳转到指定数据 */
- (void)pickerView:(UIPickerView *)pickerView selectSpecifiedData:(SEEDPickeAnimalModel *)data withDataSource:(NSMutableArray<SEEDPickerSectionItem *> *)dateSource{
    
    SEEDPickerSectionItem *item = [dateSource objectAtIndex:0];
    SEEDPickerAnimalConfig *sourceConfig = (SEEDPickerAnimalConfig *)item.config;
    if (![sourceConfig.nameArray containsObject:data.name] && ![sourceConfig.weightArray containsObject:data.weight]) {
        NSLog(@"指定目标不在数据内，无法直接跳到该位置");
        return ;
    }
    
    SEEDPickerAnimalConfig *config = [SEEDPickerAnimalConfig createConfigWithModel:data];
    [dateSource enumerateObjectsUsingBlock:^(SEEDPickerSectionItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEEDPickerAnimalConfig *currentConfig = (SEEDPickerAnimalConfig *) obj.config;
        switch (idx) {
                case 0:{
                    NSInteger row = [obj.dataArray indexOfObject:config.name];
                    if (row < obj.dataArray.count) {
                        [pickerView selectRow:row inComponent:0 animated:NO];
                        currentConfig.name = config.name;
                    }
                }
                break;
                case 1:{
                    NSInteger row = [obj.dataArray indexOfObject:config.weight];
                    if (row < obj.dataArray.count) {
                        [pickerView selectRow:row inComponent:1 animated:NO];
                        currentConfig.weight = config.weight;
                    }
                }
                break;
        }
    }];
    SEEDPickeAnimalModel *model = [SEEDPickeAnimalModel createModelWithConfig:config];
    self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
}

/** 选中具体的*/
- (void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component withItem:(SEEDPickerSectionItem*)item withDataSource:(NSMutableArray *)dateSource{
    
//    if (item) {
//        SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
//        switch (component) {
//                case 0:{
//                    NSString *year = [item.dataArray objectAtIndex:row];
//                    sourceConfig.year = year;
//                    SEEDPickerSectionItem *dayItem = [dateSource objectAtIndex:2];
//                    [self refreshDayWithItem:item withTargetItem:dayItem];
//                }
//                break;
//                case 1:{
//                    NSString *month = [item.dataArray objectAtIndex:row];
//                    sourceConfig.month = month;
//                    SEEDPickerSectionItem *dayItem = [dateSource objectAtIndex:2];
//                    [self refreshDayWithItem:item withTargetItem:dayItem];
//                }
//                break;
//                case 2:{
//                    NSString *day = [item.dataArray objectAtIndex:row];
//                    sourceConfig.day = day;
//                }
//                break;
//                case 3:{
//                    NSString *hour = [item.dataArray objectAtIndex:row];
//                    sourceConfig.hour = hour;
//                }
//                break;
//                case 4:{
//                    NSString *minute = [item.dataArray objectAtIndex:row];
//                    sourceConfig.minute = minute;
//                }
//                break;
//                case 5:{
//                    NSString *second = [item.dataArray objectAtIndex:row];
//                    sourceConfig.second = second;
//                }
//                break;
//        }
//
//        if (sourceConfig.mindate) {
//            [self compareMindateWithRow:row inComponent:component withItem:item withDataSource:dateSource];
//        }
//
//        SEEDPickeDateModel *model = [SEEDPickeDateModel createModelWithConfig:sourceConfig];
//        //点击事件
//        self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
//    }
}

//比较两个时间 来决定是否可选
- (void)compareMindateWithRow:(NSInteger)row inComponent:(NSInteger)component withItem:(SEEDPickerSectionItem*)item withDataSource:(NSMutableArray *)dateSource{
//    SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
//    //获取新选择的时间
//    NSDate *currentSelectDate = [super loadCurrentSelectDateWithItem:item];
//    NSComparisonResult result = [super compateWithOldDate:sourceConfig.mindate sourceDate:currentSelectDate];
//    if (result != NSOrderedAscending) {
//        NSInteger redirectRow = 0;
//        switch (component) {
//                case 0:{
//                    redirectRow = [sourceConfig.yearArray indexOfObject:sourceConfig.minYear];
//                }
//                break;
//                case 1:{
//                    redirectRow = [sourceConfig.monthArray indexOfObject:sourceConfig.minMonth];
//                }
//                break;
//                case 2:{
//                    redirectRow = [sourceConfig.dayArray indexOfObject:sourceConfig.minDay];
//                }
//                break;
//                case 3:{
//                    redirectRow = [sourceConfig.hourArray indexOfObject:sourceConfig.minHour];
//                }
//                break;
//                case 4:{
//                    redirectRow = [sourceConfig.minuteArray indexOfObject:sourceConfig.minMinute];
//                }
//                break;
//                case 5:{
//                    redirectRow = [sourceConfig.secondArray indexOfObject:sourceConfig.minSecond];
//                }
//                break;
//        }
//        //不允许选择
//        if ([self.delegate respondsToSelector:@selector(redirectSelectWithWithRow:inComponent:)]){
//            [self.delegate redirectSelectWithWithRow:redirectRow  inComponent:component];
//        }
//        //刷新数据 避免错乱
//        [super refreshStorageDataWithItem:item];
//    }
}


- (void)refreshDayWithItem:(SEEDPickerSectionItem*)item withTargetItem:(SEEDPickerSectionItem *)targetItem{
    
//    NSMutableArray *arr = [NSMutableArray array];
//    SEEDPickerDateConfig *sourceConfig = (SEEDPickerDateConfig *)item.config;
//    for (int i = 1; i < [self getDayNumber:sourceConfig.year.integerValue month:sourceConfig.month.integerValue].integerValue + 1; i ++) {
//        sourceConfig.isZh?[arr addObject:[NSString stringWithFormat:@"%.2ld日",(long)i]]:[arr addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
//    }
//    
//    targetItem.dataArray = arr;
//    if ([self.delegate respondsToSelector:@selector(reloadDataWithComponent:withItem:)]) {
//        //这里需要注意一下 这个下标
//        [self.delegate reloadDataWithComponent:2 withItem:targetItem];
//    }
//    //刷新数据
//    [super afterSeletedRefreshDataWithItem:item targetItem:targetItem];
}

@end
