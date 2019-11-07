//
//  SEEDPickerView.m
//  driver
//
//  Created by liangbing on 2019/6/12.
//  Copyright © 2019 LB. All rights reserved.
//

#import "SEEDPickerView.h"
#import "SEEDPickerSectionItem.h"
#import "SEEDPickerBasicProtocol.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface SEEDPickerView () <UIPickerViewDataSource,UIPickerViewDelegate,SEEDPickerViewDelegate>

@property (nonatomic, strong) UIPickerView * pickview;
/** 重定向的数据 */
@property (nonatomic, strong) id redirectTargetData;

@end

@implementation SEEDPickerView

#pragma mark   init
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withSelectBlock:(void(^)(id model))selectBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.didSelectBlock = selectBlock;
        [self setupUI];
    }
    return self;
}

#pragma mark   setupUI
- (void)setupUI{
    /** pickerView */
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.frame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    [self addSubview:pickerView];
    _pickview = pickerView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pickview.frame = self.bounds;
}

#pragma mark  跳转到指定的数据
- (void)jumptoSpecifiedData:(id)redirectTargetData{
    self.redirectTargetData = redirectTargetData;
    if (self.dataSource && self.dataSource.count > 0) {
        SEEDPickerSectionItem *item = [self.dataSource objectAtIndex:0];
        id <SEEDPickerItemDelegate>itemConfig = item.config;
        id<SEEDPickerManagerBasicDelegate> manager = [[NSClassFromString([itemConfig loadManagerClassName]) alloc] init];
        if (manager.delegate != self) {
            manager.delegate = self;
        }
        [manager pickerView:self.pickview selectSpecifiedData:redirectTargetData withDataSource:self.dataSource];
    }
}

- (void)setDataSource:(NSMutableArray<SEEDPickerSectionItem *> *)dataSource{
    _dataSource = dataSource;
    [self.pickview reloadAllComponents];
    
    if (dataSource && dataSource.count > 0) {
        SEEDPickerSectionItem *item = [self.dataSource objectAtIndex:0];
        id <SEEDPickerItemDelegate>itemConfig = item.config;
        id<SEEDPickerManagerBasicDelegate> manager = [[NSClassFromString([itemConfig loadManagerClassName]) alloc] init];
        if (manager.delegate != self) {
            manager.delegate = self;
        }
        if (self.redirectTargetData) {
            [manager pickerView:self.pickview selectSpecifiedData:self.redirectTargetData withDataSource:dataSource];
        }else{
            //每次初始化 选中一个默认值。
            [manager selectFirstLineValueWith:dataSource];
        }
        
    }
}

- (void)setSelectBlock:(void (^)(id _Nonnull))selectBlock{
    _selectBlock = selectBlock;
    
    self.didSelectBlock = selectBlock;
}

#pragma mark - PickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataSource.count;
}

//自定义每个pickview的label
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:15];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    SEEDPickerSectionItem *item = [self.dataSource objectAtIndex:component];
    return item.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    SEEDPickerSectionItem *item = [self.dataSource objectAtIndex:component];
    return item.dataArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (SCREENWIDTH - 20)/self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
        
    SEEDPickerSectionItem *item = [self.dataSource objectAtIndex:component];
    id <SEEDPickerItemDelegate>itemConfig = item.config;
    if (component != self.dataSource.count) {
        id<SEEDPickerManagerBasicDelegate> manager = [[NSClassFromString([itemConfig loadManagerClassName]) alloc] init];
        if (manager.delegate != self) {
            manager.delegate = self;
        }
        [manager didSelectRow:row inComponent:component withItem:item withDataSource:self.dataSource];
    }
}

#pragma mark - SEEDPickerViewDelegate
//同时含有月-天时， 改变月份后，刷新对应的天数
- (void)reloadDataWithComponent:(NSInteger)component withItem:(SEEDPickerSectionItem *)item{
    [self.dataSource replaceObjectAtIndex:component withObject:item];
    [self.pickview reloadComponent:component];
}

//错误或者违规选择后，重定向到之前的选择
- (void)redirectSelectWithWithRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.pickview  selectRow:row inComponent:component animated:YES];
}

@synthesize didSelectBlock;

@end


