//
//  SEEDPickerView.h
//  driver
//
//  Created by liangbing on 2019/6/12.
//  Copyright © 2019 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SEEDPickerSectionItem;

NS_ASSUME_NONNULL_BEGIN

@interface SEEDPickerView : UIView

/**  数据源 */
@property (nonatomic, strong) NSMutableArray<SEEDPickerSectionItem *> *dataSource;

/** 选中的block */
@property (nonatomic, strong) void(^selectBlock)(id  model);

/** 创建实例*/
- (instancetype)initWithFrame:(CGRect)frame withSelectBlock:(void(^)(id  model))selectBlock;

/* 直接定位到该数据 */
- (void)jumptoSpecifiedData:(id)redirectTargetData;

@end

NS_ASSUME_NONNULL_END
