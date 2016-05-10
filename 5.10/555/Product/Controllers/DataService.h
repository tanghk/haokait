//
//  DataService.h
//  WXWeibo
//
//  Created by Zheng on 15/9/2.
//  Copyright (c) 2015年 Qingwu Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import <AFNetworking.h>
#import "JSONKit.h"
#define kBaseURL @"http://debug.otouzi.com:8012"

typedef void (^CompletionBlock)(id result);
typedef void(^error) (id error);
typedef void(^NetStateBlock)(NSString *state);

@interface DataService : NSObject{


    FMDatabase *_db;        //数据库
    NSString *_tableName;   //表名

}
@property (nonatomic, copy) NSString *netState;
@property(nonatomic ,strong)NSString *token;
/**
 *  自定义网络请求
 *
 *  @param urlStr     URL接口字符串
 *  @param params     请求参数
 *  @param httpMethod 请求方式
 *  @param block      请求成功之后的回调block
 */
+ (void)requestWithURL:(NSString *)urlStr
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
       completionBlock:(CompletionBlock)block;


/**
 * 网络判断
 */
-(void)currentNetState:(NetStateBlock)state;
/**
 * manager管理请求
 */
+ (instancetype)sharedManager;



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
