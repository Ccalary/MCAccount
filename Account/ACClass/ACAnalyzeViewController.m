//
//  ACAnalyzeViewController.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACAnalyzeViewController.h"
#import <PNChart/PNChart.h>
#import "DataBase.h"
#import "Record.h"
#import "ACAnalyzeTableViewCell.h"
#import "ACDataViewController.h"
#import "ACPopMenuView.h"
#import "QFDatePickerView.h"

@interface ACAnalyzeViewController ()<UITableViewDelegate, UITableViewDataSource, PNChartDelegate>
@property (nonatomic, strong) PNPieChart *pieChart;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) NSString *selectStr;
@end

@implementation ACAnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectStr = @"All";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)initView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Screen" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(ScreenWidth/3.0/2.0, 50, ScreenWidth/3.0*2, ScreenWidth/3.0*2) items:nil];
    _pieChart.descriptionTextColor = [UIColor whiteColor];
    _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    _pieChart.delegate = self;
    [_pieChart strokeChart];
    [self.view addSubview:_pieChart];
    
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.font = [UIFont systemFontOfSize:18];
    _totalLabel.textAlignment = NSTextAlignmentCenter;
    _totalLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_totalLabel];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.pieChart.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.totalLabel.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACAnalyzeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[ACAnalyzeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.cellArray[indexPath.row];
    cell.dic = dic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (void)requestData {
    NSMutableArray *mArray = [NSMutableArray array];
    NSMutableArray *itemArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    _cellArray = [NSMutableArray array];
    double totalMoney = 0.0;
    NSArray *typeArray = @[@"Normal",@"Transport",@"Message",@"Shopping",@"Medical",@"Food",@"Travel",@"Book",@"Others"];
    if ([self.selectStr isEqualToString:@"All"]){
        for (int i = 0; i < typeArray.count; i++) {
            NSMutableArray *array = [[DataBase sharedDataBase] getRecordWithType:typeArray[i]];
            [mArray addObject:array];
        }
    }else {
        for (int i = 0; i < typeArray.count; i++) {
            NSMutableArray *array = [[DataBase sharedDataBase] getRecordWithDate:self.selectStr andType:typeArray[i]];
            [mArray addObject:array];
        }
    }

    for (int i = 0; i < mArray.count; i++){
        NSArray *array = mArray[i];
        double money = 0.0;
        NSString *typeStr;
        if (array.count <= 0) continue;
        for (int j = 0; j < array.count; j++){
            Record *record = array[j];
            money += [record.money doubleValue];
            typeStr = record.typeStr;
            totalMoney += [record.money doubleValue];
        }
        [_cellArray addObject:@{@"type":typeStr,@"money":[NSString stringWithFormat:@"%.2f",money]}];
        [itemArray addObject:[PNPieChartDataItem dataItemWithValue:money color:[UIColor randomColor] description:typeStr]];
        [_dataArray addObject:array];
    }
  
    [_pieChart updateChartData:itemArray];
    [_pieChart strokeChart];
    [self.tableView reloadData];
    
    if (itemArray.count == 0 && self.cellArray.count == 0){
        _totalLabel.text = @"Nothing Here!";
    }else {
        if (totalMoney > 0){
            _totalLabel.text = [NSString stringWithFormat:@"Total：%.2f(dollers)",totalMoney];
        }
    }
}

- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex {
    ACDataViewController *vc = [[ACDataViewController alloc] init];
    vc.dataArray = self.dataArray[pieIndex];
    [self.navigationController pushViewController:vc animated:YES];
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

@end
