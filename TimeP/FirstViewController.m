//
//  FirstViewController.m
//  TimeP
//
//  Created by liangbing on 2019/9/11.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "FirstViewController.h"
#import "SEEDPickerView.h"
#import "SEEDDatePickerBaseManager.h"


@interface FirstViewController ()

@property (nonatomic, strong) SEEDPickerView *picker;
@property (nonatomic, assign) NSInteger type;

@end

@implementation FirstViewController

- (instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.picker = [[SEEDPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 500) withSelectBlock:^(id  _Nonnull model) {
        NSLog(@"%@",model);
    }];
    [self.view addSubview:self.picker];
    
    
//  便利写法
//  self.picker.dataSource = [SEEDDatePickerBaseManager initNormalDatePickerWithType:self.type];
    
    //自定义写法
    self.picker.dataSource = [[SEEDDatePickerBaseManager initWithType:self.type] creatDateArrayWithIszh:NO withminuteInterval:1 withMinDate:[NSDate date]];
    [self.picker jumptoSpecifiedData:[NSDate date]];
    
}

@end
