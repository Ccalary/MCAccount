//
//  HomeTableViewCell.m
//  AccountBook
//
//  Created by caohouhong on 2018/6/20.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACHomeTableViewCell.h"
@interface ACHomeTableViewCell()
@property (nonatomic, strong) UILabel *typeLabel, *infoLabel, *moneyLabel, *dateLabel;
@end
@implementation ACHomeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

- (void)initView {
    _typeLabel = [self createLabel];
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.backgroundColor = [UIColor randomColor];
    _typeLabel.layer.cornerRadius = 25;
    _typeLabel.layer.masksToBounds = YES;
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(50);
    }];
    
    _infoLabel = [self createLabel];
    _infoLabel.textAlignment = NSTextAlignmentLeft;
    _infoLabel.textColor = [UIColor fontColorDarkGray];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(8);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(ScreenWidth/2.0);
    }];
    
    _moneyLabel = [self createLabel];
    _moneyLabel.font = [UIFont systemFontOfSize:18];
    _moneyLabel.textColor = [UIColor fontColorOrange];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.mas_equalTo(self.contentView).offset(10);
    }];
    
    _dateLabel = [self createLabel];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textColor = [UIColor fontColorLightGray];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
    
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    return label;
}

- (void)setRecord:(Record *)record {
    _typeLabel.backgroundColor = [UIColor randomColor];
    if (record.typeStr.length > 0){
       _typeLabel.text = [record.typeStr substringToIndex:1];
    }

    _infoLabel.text = record.infoStr;
    _moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[record.money doubleValue]];
    _dateLabel.text = record.dateStr;
}

@end
