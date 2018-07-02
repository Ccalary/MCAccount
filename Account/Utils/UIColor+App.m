//
//  UIColor+App.m
//  HHFramework
//
//  Created by chh on 2017/7/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)
//MARK:- Theme
+ (UIColor *)themeColor{
    return [UIColor colorWithHex:0x2395ff];
}

//MARK:- Background
+ (UIColor *)bgColorMain{
    return [UIColor colorWithHex:0xf2f2f2];//灰色
}

+ (UIColor *)bgColorWhite{
    return [UIColor colorWithHex:0xffffff];
}

+ (UIColor *)bgColorLine{
    return [UIColor colorWithHex:0xececec];
}

+ (UIColor *)bgColorLineDarkGray{
    return [UIColor colorWithHex:0x4c4c4c];
}

//MARK:- Font
+ (UIColor *)fontColorBlack{
    return [UIColor colorWithHex:0x333333];
}

+ (UIColor *)fontColorDarkGray{
    return [UIColor colorWithHex:0x4c4c4c];
}

+ (UIColor *)fontColorLightGray{
    return [UIColor colorWithHex:0x999999];
}

+ (UIColor *)fontColorOrange{
    return [UIColor colorWithHex:0xffb83c];
}

+ (UIColor *)fontColorMoneyGolden{
    return [UIColor colorWithHex:0xff890b];
}

//MARK:- Button
+ (UIColor *)buttonColorTheme{
    return [UIColor colorWithHex:0xcccccc];
}


//MARK:- Method
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)*1.0f/255.0
                           green:(arc4random()%255)*1.0f/255.0
                            blue:(arc4random()%255)*1.0f/255.0 alpha:1.0];
}
@end
