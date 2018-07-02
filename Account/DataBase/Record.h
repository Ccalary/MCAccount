//
//  Record.h
//  AccountBook
//
//  Created by caohouhong on 2018/6/20.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject
@property (nonatomic, strong) NSNumber *r_id;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *infoStr;
@end
