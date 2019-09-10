//
//  SEEDPickeDateModel.m
//  driver
//
//  Created by liangbing on 2019/6/18.
//  Copyright © 2019 1hai. All rights reserved.
//

#import "SEEDPickeDateModel.h"
#import "SEEDPickerDateConfig.h"

@implementation SEEDPickeDateModel

+ (SEEDPickeDateModel *)createModelWithConfig:(SEEDPickerDateConfig*)config{
    SEEDPickeDateModel *model = [SEEDPickeDateModel new];
    model.year = config.year;
    model.month = config.month;
    model.day = config.day;
    model.hour = config.hour;
    model.minute = config.minute;
    model.second = config.second;
    return model;
}

@end
