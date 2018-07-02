
//
//  ACPopMenuView.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACPopMenuView.h"

@implementation ACPopMenuView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-100, TopFullHeight+5, 95, 105)];
    holdView.backgroundColor = [UIColor whiteColor];
    holdView.layer.cornerRadius = 5.0;
    [self addSubview:holdView];
    // 形状绘制
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [holdView.layer addSublayer:shapeLayer];
    //绘制背景区域
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(holdView.frame.size.width/3*2, - 5)];
    [bezierPath addLineToPoint:CGPointMake(holdView.frame.size.width/3*2 + 5,0)];
    [bezierPath addLineToPoint:CGPointMake(holdView.frame.size.width/3*2 - 5,0)];
    shapeLayer.path = bezierPath.CGPath;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35, holdView.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [holdView addSubview:line];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 70, holdView.frame.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [holdView addSubview:line1];
    
    UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapAction)];
    [self addGestureRecognizer:atap];
    
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, holdView.frame.size.width, 35)];
    [btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn0 setTitle:@"All" forState:UIControlStateNormal];
    [btn0 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:btn0];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 35, holdView.frame.size.width, 35)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"Year" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, holdView.frame.size.width, 35)];
    [btn2 setTitle:@"Month" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:btn2];
}

- (void)pop{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)aTapAction {
    [self dismiss];
}

- (void)btnAction:(UIButton *)button {
    [self dismiss];
    if (self.block){
        self.block(button.currentTitle);
    }
}
@end
