//
//  Created by lc on 15/4/14.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "LCProgressHUD.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE    14.0f
#define MESSAGE_SIZE 16.0f

#define kToastDuration 1.0f

@implementation LCProgressHUD

+ (instancetype)sharedHUD {

    static LCProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        hud = [[LCProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    });
    return hud;
}

+ (void)showStatus:(LCProgressHUDStatus)status text:(NSString *)text {
    [self showStatus:status text:text inKeyWindow:NO];
}

+ (void)showMessage:(NSString *)text{
    [self showMessage:text inKeyWindow:YES];
}

+ (void)showStatus:(LCProgressHUDStatus)status text:(NSString *)text inKeyWindow:(BOOL)inKey{
    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud showAnimated:YES];
    [hud setShowNow:YES];
    //View的颜色
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //style -blur 不透明 －solidColor 透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //HUD内部颜色
    //    hud.contentColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.0];
    hud.contentColor = [UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoom;
    
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    CGFloat offsetHeight = 0;
    if (inKey){
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        offsetHeight = 0;
    }else{
        [[self currentView] addSubview:hud];//添加到当前View
        //因为全局的ViewController中的View都下沉
        offsetHeight = -([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)/2.0;
    }
    CGRect frame = hud.frame;
    frame.origin.y = offsetHeight;
    frame.origin.x = 0;
    hud.frame = frame;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LCProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case LCProgressHUDStatusSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"hud_success@2x.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            hud.customView = sucView;
            [hud hideAnimated:YES afterDelay:kToastDuration];
        }
            break;
            
        case LCProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"hud_error@2x.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            hud.customView = errView;
            [hud hideAnimated:YES afterDelay:kToastDuration];
        }
            break;
            
        case LCProgressHUDStatusWaitting: {
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case LCProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            hud.customView = infoView;
            [hud hideAnimated:YES afterDelay:kToastDuration];
        }
            break;
            
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text inKeyWindow:(BOOL)inKey{

    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud showAnimated:YES];
    [hud setShowNow:YES];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //style -blur 不透明 －solidColor 透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.animationType = MBProgressHUDAnimationZoom;
//    hud.contentColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.0];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:MESSAGE_SIZE];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    CGFloat offsetHeight = 0;
    if (inKey){
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        offsetHeight = 0;
    }else{
        [[self currentView] addSubview:hud];//添加到当前View
        //因为全局的ViewController中的View都下沉
        offsetHeight = -([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)/2.0;
    }
    CGRect frame = hud.frame;
    frame.origin.y = offsetHeight;
    frame.origin.x = 0;
    hud.frame = frame;
    
    [hud hideAnimated:YES afterDelay:kToastDuration];
}

+ (void)showInfoMsg:(NSString *)text {

    [self showStatus:LCProgressHUDStatusInfo text:text];
}

+ (void)showFailure:(NSString *)text {

    [self showStatus:LCProgressHUDStatusError text:text];
}

+ (void)showKeyWindowFailure:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusError text:text inKeyWindow:YES];
}

+ (void)showSuccess:(NSString *)text {

    [self showStatus:LCProgressHUDStatusSuccess text:text];
}

+ (void)showKeyWindowSuccess:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusSuccess text:text inKeyWindow:YES];
}


+ (void)showLoading:(NSString *)text {

    [self showStatus:LCProgressHUDStatusWaitting text:text];
}

+ (void)showKeyWindowLoading:(NSString *)text {
     [self showStatus:LCProgressHUDStatusWaitting text:text inKeyWindow:YES];
}

+ (void)hide {
    
    [[LCProgressHUD sharedHUD] hideAnimated:YES afterDelay:0.1];
}

+ (UIView *)currentView{
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        controller = [(UITabBarController *)controller selectedViewController];
    }
  
    if([controller isKindOfClass:[UINavigationController class]]) {
        controller = [(UINavigationController *)controller visibleViewController];
    }
    if (!controller) {
        return [UIApplication sharedApplication].keyWindow;
    }
    return controller.view;
}
@end
