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
    [weightItem.dataArray addObjectsFromArray:config.weightArray];
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
    
    if (item) {
        SEEDPickerAnimalConfig *sourceConfig = (SEEDPickerAnimalConfig *)item.config;
        switch (component) {
                case 0:
            {
                NSString *name = [item.dataArray objectAtIndex:row];
                sourceConfig.name = name;
            }
                break;
                
                case 1:
            {
                NSString *weight = [item.dataArray objectAtIndex:row];
                sourceConfig.weight = weight;
            }
                break;
        }
        //点击事件
        SEEDPickeAnimalModel *model = [SEEDPickeAnimalModel createModelWithConfig:sourceConfig];
        self.delegate.didSelectBlock?self.delegate.didSelectBlock(model):nil;
    }
    
}

@end
