//
//  ACAnalyzeTableViewCell.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACAnalyzeTableViewCell.h"

@interface ACAnalyzeTableViewCell()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *moneyLabel;
@end
@implementation ACAnalyzeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.textColor = [UIColor fontColorDarkGray];
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).offset(-50);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    _dotView = [[UIView alloc] init];
    [self.contentView addSubview:_dotView];
    [_dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.moneyLabel.mas_left).offset(-2);
    }];
}

- (void)setDic:(NSDictionary *)dic {
    _dotView.backgroundColor = [UIColor randomColor];
    _moneyLabel.text = [NSString stringWithFormat:@"%@：%@",dic[@"type"],dic[@"money"]];
}

@end
