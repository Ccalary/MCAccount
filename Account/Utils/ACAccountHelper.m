//
//  ACAccountHelper.m
//  Account
//
//  Created by caohouhong on 2018/7/2.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ACAccountHelper.h"
#import "Record.h"
#import "DataBase.h"

@implementation ACAccountHelper
+ (BOOL)getIsLoadLoacalData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLoad = [defaults objectForKey:@"isLoadData"];
    return isLoad;
}

+ (void)setIsLoadLoacalData:(BOOL)isLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isLoad forKey:@"isLoadData"];
    [defaults synchronize];
}

+ (void)loadData {
    Record *record1 = [[Record alloc] init];
    record1.r_id = @(0);
    record1.money = @"700";
    record1.typeStr = @"Shopping";
    record1.infoStr = @"iPhone";
    record1.dateStr = @"2018.06.18";
    
    Record *record2 = [[Record alloc] init];
    record2.r_id = @(1);
    record2.money = @"60";
    record2.typeStr = @"Food";
    record2.infoStr = @"KFC";
    record2.dateStr = @"2018.04.10";
    
    Record *record3 = [[Record alloc] init];
    record3.r_id = @(2);
    record3.money = @"50";
    record3.typeStr = @"Transport";
    record3.infoStr = @"metro card";
    record3.dateStr = @"2018.06.12";
    
    Record *record4 = [[Record alloc] init];
    record4.r_id = @(3);
    record4.money = @"40";
    record4.typeStr = @"Message";
    record4.infoStr = @"charge telephone fees";
    record4.dateStr = @"2018.05.12";
    
    Record *record5 = [[Record alloc] init];
    record5.r_id = @(4);
    record5.money = @"35.2";
    record5.typeStr = @"Book";
    record5.infoStr = @"C++ Prime";
    record5.dateStr = @"2018.06.18";
    
    Record *record6 = [[Record alloc] init];
    record6.r_id = @(5);
    record6.money = @"105";
    record6.typeStr = @"Others";
    record6.infoStr = @"games";
    record6.dateStr = @"2018.05.19";
    
    [[DataBase sharedDataBase] addRecord:record1];
    [[DataBase sharedDataBase] addRecord:record2];
    [[DataBase sharedDataBase] addRecord:record3];
    [[DataBase sharedDataBase] addRecord:record4];
    [[DataBase sharedDataBase] addRecord:record5];
    [[DataBase sharedDataBase] addRecord:record6];
    
    [self setIsLoadLoacalData:YES];
}
@end
