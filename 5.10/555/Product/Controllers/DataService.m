//
//  DataService.m
//  WXWeibo
//
//  Created by Zheng on 15/9/2.
//  Copyright (c) 2015年 Qingwu Zheng. All rights reserved.
//

#import "DataService.h"
#import <AFNetworking.h>
#import "NetworkState.h"
@implementation DataService
{
  }



+ (instancetype)sharedManager {
    static DataService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataService alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
     [self database];
    }
    return self;
}




+ (void)requestWithURL:(NSString *)urlStr
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
       completionBlock:(CompletionBlock)block {

  // 1.params参数
  if (params == nil) {
    params = [NSMutableDictionary dictionary];
  }
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];

    
    if (token == nil) {
        
     
        
    }else{
    
    
    
    
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    NSString *udid = [UIDevice currentDevice].model ;
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *session = [notFirstDic objectForKey:@"sb"];
    
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
  NSDate* currentDate = [NSDate date];
        
        

   NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]];  //转化为UNIX时间戳
        
        
 

    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
   
    
    
    if (timeExpire >= time||token==nil) {
      
        //重新请求access_token
        AFHTTPRequestOperationManager* manager =
        [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =
        [manager.responseSerializer.acceptableContentTypes
         setByAddingObject:@"text/html"];
     
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        //    [manager.requestSerializer setValue: forKey:]; 请求头
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{
                        @"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp" : timeSp,
                        @"app_session_token" : session
                        }
         
              success:^(AFHTTPRequestOperation* operation, id responseObject) {
                  
                  NSLog(@"产品列表%@", responseObject);
                  
                  NSMutableDictionary* objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
    [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"]
                   forKey:@"token"]; //存在本地沙盒
                  
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
       
    NSString *token= [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:session forHTTPHeaderField:@"Application-Session"];

              }
              failure:^(AFHTTPRequestOperation* operation, NSError* error){
                  
                  // NSLog(@"%@",error);
                  
              }];
    }
    else {
       NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
       
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"Application-Session"];

    }
    
  
    
//    if (token == nil) {
//    NSLog(@"Access_Token没有获取到");
//    return;
//  }
//



  //忽略大小写的比较
  //(1)GET请求
  NSComparisonResult result = [httpMethod caseInsensitiveCompare:@"get"];

    if (result == NSOrderedSame) {
    
    // 3.构造URL
    //@"http://192.168.1.14:8013/product/list";
    //(1)前缀
    NSString *url = [kBaseURL stringByAppendingString:urlStr];
    
        [manager GET:url
       parameters:params
     success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         //拿到请求结果,回调
         dispatch_async(dispatch_get_main_queue(), ^{
             block(responseObject);
         });
         

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        
        NSString *witch =   [[NSUserDefaults standardUserDefaults]objectForKey:@"witch"];
        
        
        if ([ witch isEqualToString:@"a"]||(![witch isKindOfClass:[NSString class]])) {
            
            
        }else{
            
            
            
            
            NSLog(@"请求错误：%@",error);

            
                NetworkState *state = [NetworkState sharedNetworkState];
            
                              [state showPromptWindow];
                NSLog(@"请求网络错误：%@",error.localizedDescription);

            
            
            
            
            
        }
        
    }];
    
  
    }
  //(2)POST请求
  result = [httpMethod caseInsensitiveCompare:@"post"];
  if (result == NSOrderedSame) {
    
    // 3.构造URL
    //@"https://api.weibo.com/2/statuses/home_timeline.json";
    //(1)前缀
    NSString *url = [kBaseURL stringByAppendingString:urlStr];
    
      //POST请求不需要参数拼接在URL后面
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //拿到请求结果,回调
        dispatch_async(dispatch_get_main_queue(), ^{
            block(responseObject);
        });

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
      
        
        
        NSString *witch =   [[NSUserDefaults standardUserDefaults]objectForKey:@"witch"];
        
        
            if ([ witch isEqualToString:@"a"]||(![witch isKindOfClass:[NSString class]])) {

        
            }else{
            
                
                
             
                NSLog(@"请求错误：%@",error);

                
                    NetworkState *state = [NetworkState sharedNetworkState];
                                [state showPromptWindow];
                    NSLog(@"请求网络错误：%@",error.localizedDescription);
                    
                    
                
            }
        
    
        
    }];
      

      }
    }
}

#pragma mark - 当前网络状态
- (void)currentNetState:(NetStateBlock)state {


    [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];

    __block NSString *netStatus;

    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netStatus = @"WWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netStatus = @"WIFI";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netStatus = @"NotReachable";
                break;
            default:
                break;
        }
        state(netStatus);
        NSLog(@"当前网络状态：%@",netStatus);

    }];


     [reachabilityManager startMonitoring];


}





/*----------------------本地数据缓存--------------------------*/
/**
 * 数据库文件路径
 */
- (NSString *)databasePath {
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Cache.sqlite"];
}

/**
 * 创建数据库文件
 */
- (void)database {
    _db = [FMDatabase databaseWithPath:[self databasePath]];
}

/**
 * 打开数据库
 * 获取表名
 */
- (void)openDatabaseWithTableName:(NSString *)name {
    _tableName = name;
    [_db open];
}

/**
 * 关闭数据库
 */
- (void)closeDatabase {
    [_db close];
}

/**
 * 删除旧数据
 * 缓存新数据
 * data类型为数组或字典
 */
- (void)cacheData:(id)data {
    //    if ([[[NSUserDefaults standardUserDefaults] objectForKey:_tableName] isEqualToString:@"TableYES"]) {
    //        NSString *dropSqlStr = [NSString stringWithFormat:@"DROP TABLE %@",_tableName];
    //        [_db executeUpdate:dropSqlStr];
    //        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TableState"];
    //    }
    
    if ([self isTableOK:_tableName]) {
        [_db open];
        NSLog(@"%@表存在",_tableName);
        NSString *dropSqlStr = [NSString stringWithFormat:@"DROP TABLE %@",_tableName];
        [_db executeUpdate:dropSqlStr];
        [_db close];
    }
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, jsonData text NOT NULL);",_tableName];
    [_db open];
    [_db executeUpdate:sqlStr];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"INSERT INTO %@ (jsonData) VALUES (?);",_tableName];
    [_db executeUpdate:path,dataStr];
    //    [[NSUserDefaults standardUserDefaults] setObject:@"TableYES" forKey:_tableName];
    
}

/**
 * 返回的数据类型(数据,字典)
 */
- (id)returnData {
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT jsonData FROM %@",_tableName];
    FMResultSet *set = [_db executeQuery:sqlStr];
    while ([set next]) {
        NSString *dataStr  = [set stringForColumn:@"jsonData"];
        return [dataStr objectFromJSONString];
    }
    return nil;
}

/**
 * 访问缓存数据
 */
- (id)accessCacheData {
    if ([[[self returnData] class] isSubclassOfClass:[NSArray class]]) {
        return (NSArray *)[self returnData];
    }
    if ([[[self returnData] class] isSubclassOfClass:[NSDictionary class]]) {
        return (NSDictionary *)[self returnData];
    }
    return nil;
}


/**
 * 判断表是否存在
 */
- (BOOL)isTableOK:(NSString *)tableName {
    //    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count == 0) {
            [_db close];
            return NO;
        } else {
            [_db close];
            return YES;
        }
    }
    [_db close];
    return NO;
}


@end
