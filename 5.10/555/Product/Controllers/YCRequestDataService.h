//
//  YCRequestDataService.h
//  FMDBdemo
//
//  Created by ChengxuZheng on 15/11/25.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import <AFNetworking.h>
#import <sqlite3.h>
#import "JSONKit.h"
static NSString *NetBaseURLString = @"http://debug.otouzi.com:8012/";
typedef void(^responseBlock)(id response);
typedef void(^NetStateBlock)(NSString *state);

@interface YCRequestDataService : AFHTTPSessionManager {
    FMDatabase *_db;        //数据库
    NSString *_tableName;   //表名
    
    NSString *_token;
}

@property (nonatomic, copy) NSString *netState;

/**
 * manager管理请求
 */
+ (instancetype)sharedManager;

/**
 * 网络判断
 */
- (void)currentNetState:(NetStateBlock)state;

/**
 * GET请求
 */
- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(responseBlock)response;

/**
 * POST请求
 */
- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(responseBlock)response;

/**
 * 时间戳转时间 - 年月日时分秒
 */
- (NSString *)timeintervalFormatYMDHMS:(NSNumber *)interval;



/**
 * 缓存JSON数据的数据库管家
 * 依赖库如下:
 * 系统类库 sqlite3
 * 第三方类库 FMDB,JSONKit
 */

/**
 * 使用方法
 * 初始化manager
 * 打开数据库
 * 缓存数据/访问缓存数据(数据类型:数据,字典)
 * 关闭数据库
 */


- (void)openDatabaseWithTableName:(NSString *)name;

- (void)closeDatabase;

- (void)cacheData:(id)data;

- (id)accessCacheData;

@end
