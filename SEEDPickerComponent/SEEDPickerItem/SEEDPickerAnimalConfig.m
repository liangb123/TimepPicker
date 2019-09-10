//
//  SEEDPickerAnimalConfig.m
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "SEEDPickerAnimalConfig.h"
#import "SEEDPickeAnimalModel.h"

@implementation SEEDPickerAnimalConfig

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    SEEDPickerAnimalConfig *copy = [[SEEDPickerAnimalConfig allocWithZone:zone]init];
    copy.name = self.name;
    copy.nameArray = self.nameArray;
    copy.weightArray = self.weightArray;
    copy.weight = self.weight;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    SEEDPickerAnimalConfig *copy = [[SEEDPickerAnimalConfig allocWithZone:zone]init];
    copy.name = self.name;
    copy.nameArray = self.nameArray;
    copy.weightArray = self.weightArray;
    copy.weight = self.weight;
    return copy;
}

- (NSString *)loadManagerClassName{
    return @"SEEDAnimalPickerManager";
}

//init
+ (SEEDPickerAnimalConfig *)defaultConfig{
    SEEDPickerAnimalConfig *defaultConfig = [SEEDPickerAnimalConfig new];
    defaultConfig.name = defaultConfig.nameArray.firstObject;
    defaultConfig.weight = defaultConfig.weightArray.firstObject;
    return defaultConfig;
}

+ (SEEDPickerAnimalConfig *)createConfigWithModel:(SEEDPickeAnimalModel *)model{
    SEEDPickerAnimalConfig *config = [SEEDPickerAnimalConfig new];
    config.name = model.name;
    config.weight = model.weight;
    return config;
}

//lazy
- (NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSMutableArray arrayWithObjects:@"老鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"鸡",@"狗",@"猪",@"骆驼",@"狮子",@"大象",@"海马",@"河马",@"鲨鱼", nil];
    }
    return _nameArray;
}

- (NSMutableArray *)weightArray{
    if (!_weightArray) {
        _weightArray = [NSMutableArray array];
        for (NSInteger i = 1; i <= 200; i++) {
            [_weightArray addObject:[NSString stringWithFormat:@"%.2ldKG",(long)i]];
        }
    }
    return _weightArray;
}

@end
