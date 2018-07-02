//
//  ACHomeViewController.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACHomeViewController.h"
#import "ACHomeTableViewCell.h"
#import "Record.h"
#import "DataBase.h"
#import "ACAccountHelper.h"
#import "ACPopMenuView.h"
#import "QFDatePickerView.h"

@interface ACHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *selectStr;
@property (nonatomic, strong) UILabel *nothingLabel;
@end

@implementation ACHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectStr = @"All";
    self.dataArray = [NSMutableArray array];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewRecord) name:@"addNewRecordNotice" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Screen" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    self.nothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight/2.0 - 15, ScreenWidth, 30)];
    self.nothingLabel.textColor = [UIColor lightGrayColor];
    self.nothingLabel.text = @"Nothing Here!";
    self.nothingLabel.hidden = YES;
    self.nothingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nothingLabel];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
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
//走了左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){//删除操作
        Record *record = self.dataArray[indexPath.row];
        [[DataBase sharedDataBase] deleteRecord:record];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        //删除某行并配有动画
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//更改左滑后的字体显示
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果系统是英文，会显示delete,这里可以改成自己想显示的内容
    return @"delete";
}

- (void)requestData {
    [LCProgressHUD showLoading:@"loading..."];
    NSMutableArray *mArray = [[DataBase sharedDataBase] getRecordWithDate:self.selectStr];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[mArray copy]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });
    self.nothingLabel.hidden = (self.dataArray.count == 0) ? NO : YES;
    [self.tableView reloadData];
}

- (void)rightBarAction {
    ACPopMenuView *popView = [[ACPopMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    __weak typeof (self) weakSelf = self;
    popView.block = ^(NSString *title) {
        if ([title isEqualToString:@"All"]){
            weakSelf.selectStr = @"All";
            [self requestData];
        }else if ([title isEqualToString:@"Year"]){
            [weakSelf showYearDatePick];
        }else {
            [weakSelf showMonthDatePick];
        }
    };
    [popView pop];
}

- (void)showYearDatePick {
    __weak typeof (self) weakSelf = self;
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initYearPickerViewWithResponse:^(NSString *str) {
        weakSelf.selectStr = str;
        [weakSelf requestData];
    }];
    [datePickerView show];
}

- (void)showMonthDatePick {
    __weak typeof (self) weakSelf = self;
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
        weakSelf.selectStr = str;
        [weakSelf requestData];
    }];
    [datePickerView show];
}

- (void)addNewRecord {
    self.selectStr = @"All";
    [self requestData];
}

@end
