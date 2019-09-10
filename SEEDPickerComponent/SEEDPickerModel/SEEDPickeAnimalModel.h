//
//  SEEDPickeAnimalModel.h
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SEEDPickerAnimalConfig;
NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickeAnimalModel : NSObject
/** 选中名字 */
@property (nonatomic, copy) NSString *name;
/** 选中体重 */
@property (nonatomic, copy) NSString *weight;

//根据配置信息 生成对应的model
+ (SEEDPickeAnimalModel *)createModelWithConfig:(SEEDPickerAnimalConfig*)config;

@end

NS_ASSUME_NONNULL_END
