//
//  SEEDPickerDateConfig.m
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 LB. All rights reserved.
//

#import "SEEDPickerDateConfig.h"

@implementation SEEDPickerDateConfig

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    SEEDPickerDateConfig *copy = [[SEEDPickerDateConfig allocWithZone:zone]init];
    copy.isZh = self.isZh;
    copy.type = self.type;
    copy.yearArray = self.yearArray;
    copy.monthArray = self.monthArray;
    copy.dayArray = self.dayArray;
    copy.hourArray = self.hourArray;
    copy.minuteArray = self.minuteArray;
    copy.secondArray = self.secondArray;
    copy.year = self.year;
    copy.month = self.month;
    copy.day = self.day;
    copy.hour = self.hour;
    copy.minute = self.minute;
    copy.second = self.second;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    SEEDPickerDateConfig *copy = [[SEEDPickerDateConfig allocWithZone:zone]init];
    copy.isZh = self.isZh;
    copy.type = self.type;
    copy.yearArray = self.yearArray;
    copy.monthArray = self.monthArray;
    copy.dayArray = self.dayArray;
    copy.hourArray = self.hourArray;
    copy.minuteArray = self.minuteArray;
    copy.secondArray = self.secondArray;
    copy.year = self.year;
    copy.month = self.month;
    copy.day = self.day;
    copy.hour = self.hour;
    copy.minute = self.minute;
    copy.second = self.second;
    return copy;
}

- (NSString *)loadManagerClassName{
    NSString *className = @"";
    switch (self.type) {
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
    
    return className;
}

- (NSInteger)minuteInterval{
    if (!_minuteInterval) {
        return 1;
    }
    return _minuteInterval;
}

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 1900; i <= 2100; i++) {
            if (self.isZh) {
                [_yearArray addObject:[NSString stringWithFormat:@"%ld年",(long)i]];
            } else {
                [_yearArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
            }
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 12; i++) {
            if (self.isZh) {
                [_monthArray addObject:[NSString stringWithFormat:@"%.2ld月",(long)i]];
            } else {
                [_monthArray addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
            }
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 31; i++) {
            if (self.isZh) {
                [_dayArray addObject:[NSString stringWithFormat:@"%.2ld日",(long)i]];
            } else {
                [_dayArray addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
            }
        }
    }
    return _dayArray;
}

- (NSMutableArray *)hourArray {
    if (!_hourArray) {
        _hourArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 24; i++) {
            if (self.isZh) {
                [_hourArray addObject:[NSString stringWithFormat:@"%.2ld时",(long)i]];
            } else {
                [_hourArray addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
            }
        }
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray {
    if (!_minuteArray) {
        _minuteArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 60; i+=self.minuteInterval) {
            if (self.isZh) {
                [_minuteArray addObject:[NSString stringWithFormat:@"%.2ld分",(long)i]];
            } else {
                [_minuteArray addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
            }
        }
    }
    return _minuteArray;
}

- (NSMutableArray *)secondArray {
    if (!_secondArray) {
        _secondArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 60; i++) {
            if (self.isZh) {
                [_secondArray addObject:[NSString stringWithFormat:@"%.2ld秒",(long)i]];
            } else {
                [_secondArray addObject:[NSString stringWithFormat:@"%.2ld",(long)i]];
            }
        }
    }
    return _secondArray;
}

- (void)setMindate:(NSDate *)mindate{
    _mindate = mindate;
    
    if (mindate) {
        NSDateComponents *startComp = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:mindate];
        _minYear = self.isZh?[NSString stringWithFormat:@"%ld年",[startComp year]]:[NSString stringWithFormat:@"%.2ld",[startComp year]];
        _minMonth = self.isZh?[NSString stringWithFormat:@"%.2ld月",[startComp month]]:[NSString stringWithFormat:@"%.2ld",[startComp month]];
        _minDay = self.isZh?[NSString stringWithFormat:@"%.2ld日",[startComp day]]:[NSString stringWithFormat:@"%.2ld",[startComp day]];
        _minHour = self.isZh?[NSString stringWithFormat:@"%.2ld时",[startComp hour]]:[NSString stringWithFormat:@"%.2ld",[startComp hour]];
        _minMinute = self.isZh?[NSString stringWithFormat:@"%.2ld分",[startComp minute]]:[NSString stringWithFormat:@"%.2ld",[startComp minute]];
        _minSecond = self.isZh?[NSString stringWithFormat:@"%.2ld秒",[startComp second]]:[NSString stringWithFormat:@"%.2ld",[startComp second]];
        
        _year = _minYear;
        _month = _minMonth;
        _day = _minDay;
        _hour = _minHour;
        _minute = _minMinute;
        _second = _minSecond;
    }
}

/** 生成一个含有默认属性的config */
+ (SEEDPickerDateConfig *)defaultConfig{
    return  [SEEDPickerDateConfig createConfigWithDate:[NSDate date] withIszh:NO];
}

/** 生成一个含有时间信息的config */
+ (SEEDPickerDateConfig *)createConfigWithDate:(NSDate *)date withIszh:(BOOL)isZh{
    
    NSDateComponents *startComp = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    SEEDPickerDateConfig *config = [SEEDPickerDateConfig new];
    config.year = isZh?[NSString stringWithFormat:@"%ld年",[startComp year]]:[NSString stringWithFormat:@"%.2ld",[startComp year]];
    config.month = isZh?[NSString stringWithFormat:@"%.2ld月",[startComp month]]:[NSString stringWithFormat:@"%.2ld",[startComp month]];
    config.day = isZh?[NSString stringWithFormat:@"%.2ld日",[startComp day]]:[NSString stringWithFormat:@"%.2ld",[startComp day]];
    config.hour = isZh?[NSString stringWithFormat:@"%.2ld时",[startComp hour]]:[NSString stringWithFormat:@"%.2ld",[startComp hour]];
    config.minute = isZh?[NSString stringWithFormat:@"%.2ld分",[startComp minute]]:[NSString stringWithFormat:@"%.2ld",[startComp minute]];
    config.second = isZh?[NSString stringWithFormat:@"%.2ld秒",[startComp second]]:[NSString stringWithFormat:@"%.2ld",[startComp second]];
    config.minuteInterval = 1;
    config.mindate = nil;
    config.isZh = isZh;
    return config;
}

@end
