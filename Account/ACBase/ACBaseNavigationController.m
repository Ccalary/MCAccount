//
//  ACBaseNavigationController.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACBaseNavigationController.h"

@interface ACBaseNavigationController ()

@end

@implementation ACBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO; //设置了之后自动下沉64
    self.navigationBar.tintColor = [UIColor whiteColor]; // 左右颜色
    // 中间title颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.barTintColor = [UIColor themeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_30"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    
}

- (void)backAction{
    [self popViewControllerAnimated:YES];
}

@end
