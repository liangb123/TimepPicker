//
//  ViewController.m
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import "DetailVC.h"
#import "ViewController.h"
#import "SEEDPickerView.h"
#import "FirstViewController.h"
#import "SEEDDatePickerBaseManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

#pragma mark ------------------------------load view  ------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark ------------------------------ tableDele dataSource  ------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 8) {
        [self.navigationController pushViewController:[DetailVC new] animated:YES];
    }else{
        [self.navigationController pushViewController:[[FirstViewController alloc] initWithType:indexPath.row] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPathP{
    return 60;
}

#pragma mark ------------------------------ lazy ------------------------------
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"yyyy-MM-dd HH:mm:ss",@"yyyy-MM-dd HH:mm",@"yyyy-MM-dd HH",@"yyyy-MM-dd",@"MM-dd HH:mm",@"HH:mm",@"yyyy-MM",@"yyyy",@"举例  animal", nil];
    }
    return _dataSource;
}

#pragma mark ------------------------------ MemoryWarning ------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
