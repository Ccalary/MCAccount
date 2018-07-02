//
//  DataBase.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "DataBase.h"

#import "FMDB.h"

#import "Record.h"

static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}

@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    NSString *recordSql = @"CREATE TABLE 'record' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'r_id' VARCHAR(255), 'dateStr' VARCHAR(255), 'typeStr' VARCHAR(255), 'money' VARCHAR(255), 'infoStr' VARCHAR(255))";
    
    [_db executeUpdate:recordSql];
    
    [_db close];
}
#pragma mark - Record
- (void)addRecord:(Record *)record{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM record "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"r_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"r_id"] integerValue] ) ;
        }
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO record (r_id,dateStr,typeStr,money,infoStr) VALUES (?,?,?,?,?)",
     maxID,record.dateStr,record.typeStr,record.money,record.infoStr];
    
    [_db close];
}

- (NSMutableArray *)getAllRecord{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM record ORDER BY dateStr DESC"];
    
    while ([res next]) {
        Record *record = [[Record alloc] init];
        record.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        record.dateStr = [res stringForColumn:@"dateStr"];
        record.typeStr = [res stringForColumn:@"typeStr"];
        record.money = [res stringForColumn:@"money"];
        record.infoStr = [res stringForColumn:@"infoStr"];
        [dataArray addObject:record];
    }
    [_db close];
    
    return dataArray;
}

- (void)deleteRecord:(Record *)record{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM record WHERE r_id = ?",record.r_id];
    [_db close];
}

- (NSMutableArray *)getRecordWithType:(NSString *)type{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM record WHERE typeStr = ?",type];
    
    while ([res next]) {
        Record *record = [[Record alloc] init];
        record.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        record.dateStr = [res stringForColumn:@"dateStr"];
        record.typeStr = [res stringForColumn:@"typeStr"];
        record.money = [res stringForColumn:@"money"];
        record.infoStr = [res stringForColumn:@"infoStr"];
        [dataArray addObject:record];
    }
    [_db close];
    
    return dataArray;
}

- (NSMutableArray *)getRecordWithDate:(NSString *)dateStr{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    FMResultSet *res;
    if ([dateStr isEqualToString:@"All"]){
        res = [_db executeQuery:@"SELECT * FROM record ORDER BY dateStr DESC"];
    }else {
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM record WHERE dateStr like '%%%@%%';",dateStr];
        res = [_db executeQuery:sql];
    }
    
    while ([res next]) {
        Record *record = [[Record alloc] init];
        record.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        record.dateStr = [res stringForColumn:@"dateStr"];
        record.typeStr = [res stringForColumn:@"typeStr"];
        record.money = [res stringForColumn:@"money"];
        record.infoStr = [res stringForColumn:@"infoStr"];
        [dataArray addObject:record];
    }
    [_db close];
    
    return dataArray;
}

- (NSMutableArray *)getRecordWithDate:(NSString *)dateStr andType:(NSString *)typeStr{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM record WHERE typeStr = ? ",typeStr];
    
    while ([res next]) {
        Record *record = [[Record alloc] init];
        if (![[res stringForColumn:@"dateStr"] containsString:dateStr]){
            continue;
        }
        record.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        record.dateStr = [res stringForColumn:@"dateStr"];
        record.typeStr = [res stringForColumn:@"typeStr"];
        record.money = [res stringForColumn:@"money"];
        record.infoStr = [res stringForColumn:@"infoStr"];
        [dataArray addObject:record];
    }
    [_db close];
    
    return dataArray;
}

@end
