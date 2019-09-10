//
//  SEEDPickerView.h
//  driver
//
//  Created by liangbing on 2019/6/12.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SEEDPickerSectionItem;

NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickerView : UIView
/**  数据源 */
@property (nonatomic, strong) NSMutableArray<SEEDPickerSectionItem *> *dataSource;

/** 选中的block */
@property (nonatomic, strong) void(^selectBlock)(id  model);

/* 直接定位到该数据 */
@property (nonatomic, strong) id redirectTargetData;

/** 创建实例*/
- (instancetype)initWithFrame:(CGRect)frame withSelectBlock:(void(^)(id  model))selectBlock;

@end

NS_ASSUME_NONNULL_END
