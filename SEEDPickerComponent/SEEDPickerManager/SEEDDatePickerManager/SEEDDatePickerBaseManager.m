//
//  SEEDDatePickerBaseManager.m
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import "SEEDDatePickerBaseManager.h"
#import "SEEDPickerSectionItem.h"

@interface SEEDDatePickerBaseManager()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SEEDDatePickerBaseManager

@synthesize type;
@synthesize delegate;

#pragma mark   ------   lazy    ------
- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        _dateFormatter = dateFormatter;
    }
    return _dateFormatter;
}

#pragma mark   ------   init && abstract function    ------

+ (instancetype)initWithType:(EHIDateComponentType)type{
    
    NSString *className;
    switch (type) {
        case EHIDateComponentTypeYMDHM:
            className = @"SEEDPickeYMDHMManager";
            break;
        case EHIDateComponentTypeYMDH:
            className = @"SEEDPickeYMDHManager";
            break;
        case EHIDateComponentTypeYMD:
            className = @"SEEDPickeYMDManager";
            break;
        case EHIDateComponentTypeYM:
            className = @"SEEDPickerYMManager";
            break;
        case EHIDateComponentTypeHM:
            className = @"SEEDPickerHMManager";
            break;
        case EHIDateComponentTypeMDHM:
            className = @"SEEDPickeMDHMManager";
            break;
        case EHIDateComponentTypeY:
            className = @"SEEDPickerYYYYManager";
            break;
        case EHIDateComponentTypeYMDHMS:
            className = @"SEEDPickeYMDHMSManager";
            break;
        default:
            className = @"SEEDDatePickerBaseManager";
            break;
    }
    
    Class class = NSClassFromString(className);
    SEEDDatePickerBaseManager *manager = [class new];
    manager.type = type;
    return manager;
}

//根据type 生成一个含有默认数据的选择器
+ (NSMutableArray<SEEDPickerSectionItem *>*)initNormalDatePickerWithType:(EHIDateComponentType)type{
    SEEDDatePickerBaseManager *  manage = [SEEDDatePickerBaseManager initWithType:type];
    return [manage creatDateArrayWithIszh:YES withminuteInterval:1 withMinDate:nil];
}

//生产不同的子类需要的数据源
- (NSMutableArray <SEEDPickerSectionItem *>*)creatDateArrayWithIszh:(BOOL)isZh
                                             withminuteInterval:(NSInteger)minuteInterval withMinDate:(NSDate*)mindate{
    NSLog(@"This is a abstract method, subclass must override.");
    return nil;
}

//选中具体的时间
- (void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component
            withItem:(SEEDPickerSectionItem*)item withDataSource:(NSMutableArray *)dateSource{
    NSLog(@"This is a abstract method, subclass must override.");
}

//跳转到指定数据
- (void)pickerView:(UIPickerView*)pickerView selectSpecifiedData:(id)date
    withDataSource:(NSMutableArray<SEEDPickerSectionItem*> *)dateSource{
    NSLog(@"This is a abstract method, subclass must override.");
}

#pragma mark   ------   tool function    ------

//拨动选择器后 刷新数据源  (目前是指定的时间 如需要其他格式 子类可重写改方法)
- (void)refreshStorageDataWithItem:(SEEDPickerSectionItem*)item{
    SEEDPickerDateConfig <SEEDPickerItemDelegate> *config = (SEEDPickerDateConfig <SEEDPickerItemDelegate>*)item.config;
    if (config.mindate) {
        config.year = config.minYear;
        config.month = config.minMonth;
        config.day = config.minDay;
        config.hour = config.minHour;
        config.minute = config.minMinute;
        config.second = config.minSecond;
    }
}

//选中之后 刷新数据 保持不同item中的数据同步 (子类可根据业务需求重写该方法，重新定义逻辑)
- (void)afterSeletedRefreshDataWithItem:(SEEDPickerSectionItem*)item targetItem:(SEEDPickerSectionItem*)targetItem{
    //刷新数据避免数据 解决数据不同步的问题
    //临界点
    SEEDPickerDateConfig <SEEDPickerItemDelegate>*config = (SEEDPickerDateConfig <SEEDPickerItemDelegate>*)item.config;
    SEEDPickerDateConfig <SEEDPickerItemDelegate>*targetConfig = (SEEDPickerDateConfig <SEEDPickerItemDelegate>*)item.config;
    if ((targetItem.dataArray.count == 28 || targetItem.dataArray.count == 29 || targetItem.dataArray.count == 30) && targetConfig.day.integerValue > targetItem.dataArray.count) {
        config.day = [NSString stringWithFormat:@"%lu",(unsigned long)targetItem.dataArray.count];
    }
}

//根据年份和月份 获取具体的天数
- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400)) && year != 0) {
        return @"29";
    }
    return [days objectAtIndex:(month - 1)];
}

// 获取当前选择的时间
- (NSDate *)loadCurrentSelectDateWithItem:(SEEDPickerSectionItem *)item{
    SEEDPickerDateConfig <SEEDPickerItemDelegate>*config = (SEEDPickerDateConfig <SEEDPickerItemDelegate>*)item.config;
    NSString *currentDateString = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",(long)config.year.integerValue,(long)config.month.integerValue,(long)config.day.integerValue,(long)config.hour.integerValue,(long)config.minute.integerValue,(long)config.second.integerValue];
    
    return [self.dateFormatter dateFromString:currentDateString];
}

//比较两次选择的结果
- (NSComparisonResult)compateWithOldDate:(NSDate*)oldDate sourceDate:(NSDate*)sourceDate{
    
    NSString *dateTime=[self.dateFormatter stringFromDate:oldDate];
    NSDate *currentDate = [self.dateFormatter dateFromString:dateTime];
    //你需要比较的时间
    NSString *needCompareDateStr = [self.dateFormatter stringFromDate:sourceDate];
    NSDate *needCompareDate = [self.dateFormatter dateFromString:needCompareDateStr];
    NSComparisonResult result = [currentDate compare:needCompareDate];
    
    if (result == NSOrderedDescending) {
        NSLog(@"currentDate  is in the future");
    }else if (result == NSOrderedAscending){
        NSLog(@"currentDate is in the past");
    }else {
        NSLog(@"Both dates are the same");
    }
    
    return result;
}


@end
