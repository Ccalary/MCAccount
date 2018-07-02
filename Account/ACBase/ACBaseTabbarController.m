//
//  ACBaseTabbarController.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACBaseTabbarController.h"
#import "ACHomeViewController.h"
#import "ACAddViewController.h"
#import "ACAnalyzeViewController.h"
#import "ACBaseNavigationController.h"

@interface ACBaseTabbarController ()

@end

@implementation ACBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor themeColor];
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    
    ACHomeViewController *homeVC = [[ACHomeViewController alloc] init];
    //    homeVC.tabBarItem.badgeValue = @"1";
    
    [self addChildrenViewController:homeVC andTitle:@"detail" andImageName:@"tab_form_n" andSelectImage:@"tab_form_s"];
    [self addChildrenViewController:[[ACAddViewController alloc] init] andTitle:@"add" andImageName:@"tab_add_n" andSelectImage:@"tab_add_s"];
    [self addChildrenViewController:[[ACAnalyzeViewController alloc] init] andTitle:@"statistics" andImageName:@"tab_data_n" andSelectImage:@"tab_data_s"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    ACBaseNavigationController *baseNav = [[ACBaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}
@end
