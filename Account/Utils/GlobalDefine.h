//
//  GlobalDefine.h
//  TestDemo1
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

//大小尺寸（宽、高）
#define ScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                    [[UIScreen mainScreen] bounds].size.height
//statusBar高度
#define StatusBarHeight                 [UIApplication sharedApplication].statusBarFrame.size.height
//navBar高度
#define NavigationBarHeight             [[UINavigationController alloc] init].navigationBar.frame.size.height
//TabBar高度  iPhoneX 高度为83
#define TabBarHeight                    ((StatusBarHeight > 20.0f) ? 83.0f : 49.0f)
//nav顶部高度
#define TopFullHeight                   (StatusBarHeight + NavigationBarHeight)
//屏幕适配
#define UIRate                          ScreenWidth/375.0

//rgb颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1.0]

//rgbA颜色（带透明度）
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

//hex颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//hexA颜色(带透明度)
#define HEXACOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

//font
#define FONT_SYSTEM(x)               [UIFont systemFontOfSize:x]
#define FONT_SYSTEM_BOLD(a)          [UIFont boldSystemFontOfSize:a]

#define COLOR_BLACK                  HEXCOLOR(0x000000)
#define COLOR_WHITE                  HEXCOLOR(0xffffff)
#define COLOR_LIGHT_GRAY             HEXCOLOR(0x999999)
#define COLOR_DARK_GRAY              HEXCOLOR(0x666666)
#define COLOR_Background             HEXCOLOR(0xd2d2d2)


//Debug信息,用printf解决真机调试打印不出来的问题
#ifdef DEBUG
# define DLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
# define DLog(...);
#endif

#endif /* GlobalDefine_h */
