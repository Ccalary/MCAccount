//
//  DateView.m
//  AccountBook
//
//  Created by caohouhong on 2018/6/19.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACDateView.h"
@interface ACDateView()
@property (nonatomic, strong) NSString *dateStr;
@end
@implementation ACDateView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 100, 25)];
    [cancel setTitle:@"cancel" forState:UIControlStateNormal];
    cancel.tag = 665;
    [cancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    [self addSubview:cancel];
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 5, 100, 25)];
    [sure setTitle:@"sure" forState:UIControlStateNormal];
    sure.tag = 666;
    [sure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    [self addSubview:sure];
    
    // 1.日期Picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30)];
    datePicker.backgroundColor = [UIColor whiteColor];
    // 1.1选择datePickr的显示风格
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 1.2查询所有可用的地区
    //NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    // 1.4监听datePickr的数值变化
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    // 2.3 将转换后的日期设置给日期选择控件
    [datePicker setDate:[NSDate date]];
    [self addSubview:datePicker];
}

- (void)dateChanged:(UIDatePicker *)picker{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    _dateStr = [formatter stringFromDate:picker.date];
}

- (void)buttonAction:(UIButton *)button {
    if (self.block){
        self.block( (button.tag == 666) ? self.dateStr : nil);
    }
}
@end
