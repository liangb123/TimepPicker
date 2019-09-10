//
//  ViewController.m
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "ViewController.h"
#import "SEEDPickerView.h"
#import "SEEDDatePickerBaseManager.h"
#import "SEEDPickeMDHMManager.h"
#import "SEEDAnimalPickerManager.h"
#import "SEEDPickeAnimalModel.h"

@interface ViewController ()

@property (nonatomic, strong) SEEDPickerView *picker;
@property (nonatomic, strong) UITextField *nameT;
@property (nonatomic, strong) UITextField *weightT;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.nameT = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width / 2 - 20, 50)];
    self.nameT.placeholder = @"请输入名称";
    self.nameT.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.nameT];
    
    self.weightT = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 10, self.view.frame.size.width / 2 - 20, 50)];
    self.weightT.placeholder = @"请输入体重";
    self.weightT.borderStyle = UITextBorderStyleLine;
    self.weightT.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.weightT];
    
    UIButton *jumpBtn = [UIButton buttonWithType:0];
    jumpBtn.frame = CGRectMake(50, 110, self.view.frame.size.width - 100, 100);
    jumpBtn.backgroundColor = UIColor.redColor;
    [jumpBtn setTitle:@"跳转到指定位置" forState:0];
    [jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
    
    
    self.picker = [[SEEDPickerView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 500) withSelectBlock:^(id  _Nonnull model) {
        NSLog(@"%@",model);
    }];
    
    [self.view addSubview:self.picker];
    self.picker.dataSource = [[SEEDAnimalPickerManager alloc] creatAnimalDataArray];
    
}

- (void)jumpAction:(id)sender{
    
    SEEDPickeAnimalModel *model = [SEEDPickeAnimalModel new];
    model.name = self.nameT.text;
    model.weight = [NSString stringWithFormat:@"%@ Kg",self.weightT.text];
    [self.picker jumptoSpecifiedData:model];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (!CGRectContainsPoint(_nameT.frame, point) || !CGRectContainsPoint(_weightT.frame, point)){
        [self.view endEditing:YES];
    }
}
@end
