//
//  ACPopMenuView.h
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnBlock)(NSString *title);
@interface ACPopMenuView : UIView
@property (nonatomic, copy) btnBlock block;
- (void)pop;
@end
