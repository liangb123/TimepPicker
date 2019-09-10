//
//  SEEDPickerSectionItem.m
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import "SEEDPickerSectionItem.h"

@interface SEEDPickerSectionItem ()

@end

@implementation SEEDPickerSectionItem

- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    SEEDPickerSectionItem *copy = [[SEEDPickerSectionItem allocWithZone:zone]init];
    copy.dataArray = self.dataArray;
    copy.config = self.config;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    SEEDPickerSectionItem *copy = [[SEEDPickerSectionItem allocWithZone:zone]init];
    copy.dataArray = self.dataArray;
    copy.config = self.config;
    return copy;
}

@end
