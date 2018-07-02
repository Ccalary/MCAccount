//
//  ACDataViewController.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACDataViewController.h"
#import "ACHomeTableViewCell.h"
#import "Record.h"

@interface ACDataViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ACDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Record *record = self.dataArray.firstObject;
    self.navigationItem.title = record.typeStr;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TopFullHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[ACHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.record = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
