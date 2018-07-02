//
//  UIColor+App.h
//  HHFramework
//
//  Created by chh on 2017/7/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)
/** 主题颜色 1b76d0*/
+ (UIColor *)themeColor;

#pragma mark - 背景色
//背景颜色
/** 主背景色-灰色 f2*/
+ (UIColor *)bgColorMain;
/** 背景白色 fff*/
+ (UIColor *)bgColorWhite;

#pragma mark - 分割线
/** 分隔线(浅) ec*/
+ (UIColor *)bgColorLine;
/** 分隔线(深) 4c*/
+ (UIColor *)bgColorLineDarkGray;

#pragma mark - 字体
//字体颜色
/** 黑色 333*/
+ (UIColor *)fontColorBlack;
/** 深灰 4c*/
+ (UIColor *)fontColorDarkGray;
/** 浅灰 999*/
+ (UIColor *)fontColorLightGray;
/** 直播间名字 */
+ (UIColor *)fontColorOrange;
/** 金额字体颜色 */
+ (UIColor *)fontColorMoneyGolden;
#pragma mark - 按钮
/** 按钮颜色 */
+ (UIColor *)buttonColorTheme;



#pragma mark - 方法
/** 十六进制颜色  eg:0xffffff*/
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
/** 十六进制颜色  eg:0xffffff, 1*/
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
/** 随机颜色 */
+ (UIColor*)randomColor;
@end
