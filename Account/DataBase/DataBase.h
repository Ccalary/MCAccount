//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Record;


@interface DataBase : NSObject

@property (nonatomic, strong) Record *record;

+ (instancetype)sharedDataBase;

#pragma mark - Record
- (void)addRecord:(Record *)record;
- (void)deleteRecord:(Record *)record;
- (NSMutableArray *)getAllRecord;
- (NSMutableArray *)getRecordWithType:(NSString *)type;
// 日期查找
- (NSMutableArray *)getRecordWithDate:(NSString *)dateStr;
// 日期种类查找
- (NSMutableArray *)getRecordWithDate:(NSString *)dateStr andType:(NSString *)typeStr;
@end
