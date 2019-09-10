//
//  SEEDPickeAnimalModel.m
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "SEEDPickeAnimalModel.h"
#import "SEEDPickerAnimalConfig.h"

@implementation SEEDPickeAnimalModel

+ (SEEDPickeAnimalModel *)createModelWithConfig:(SEEDPickerAnimalConfig *)config{
    SEEDPickeAnimalModel *model = [SEEDPickeAnimalModel new];
    model.name = config.name;
    model.weight = config.weight;
    return model;
}

@end
