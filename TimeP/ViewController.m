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


@interface ViewController ()
@property (nonatomic, strong) SEEDPickerView *picker;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker = [[SEEDPickerView alloc] initWithFrame:self.view.frame withSelectBlock:^(id  _Nonnull model) {
        
    }];
    
    [self.view addSubview:self.picker];
    self.picker.dataSource = [SEEDDatePickerBaseManager initNormalDatePickerWithType:EHIDateComponentTypeYMDHMS];
}


@end
