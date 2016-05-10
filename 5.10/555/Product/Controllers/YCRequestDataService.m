//
//  YCRequestDataService.m
//  FMDBdemo
//
//  Created by ChengxuZheng on 15/11/25.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import "YCRequestDataService.h"
#import <AFNetworking.h>

@implementation YCRequestDataService

+ (instancetype)sharedManager {
    static YCRequestDataService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YCRequestDataService alloc] initWithBaseURL:[NSURL URLWithString:NetBaseURLString]];
    });
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self database];
    }
    return self;
}

#pragma mark - 当前网络类型
- (void)currentNetState:(NetStateBlock)state {
    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    __weak YCRequestDataService *weakSelf = self;
    [weakSelf.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _netState = @"WWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _netState = @"WiFi";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _netState = @"NotReachable";
                break;
            default:
                break;
        }
        state(_netState);
    }];
    [self.reachabilityManager startMonitoring];
}

#pragma mark - Get请求
- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(responseBlock)response {
  
      NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    if (token == nil) {
        ;
    }else{
    
    
    
    
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *udid = [UIDevice currentDevice].model ;
    
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *session = [notFirstDic objectForKey:@"sb"];
    
    
    NSDate *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate *currentDate = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]];  //转化为UNIX时间戳
        
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];

    //时间戳
    float timeExpire = [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
 
    if (timeExpire >= time||token==nil) {        //重新请求access_token
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        //    [manager.requestSerializer setValue: forKey:]; 请求头
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{  @"device_type": @"ios",
                          @"device_unique":uuid,
                          @"device_model": udid,
                          @"system_version": currentVersion,
                          @"request_timestamp" : timeSp,
                          @"app_session_token" : session
}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        
        
    }else {
        _token=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
    }

   // NSString *token=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:session forHTTPHeaderField:@"Application-Session"];
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",NetBaseURLString,api];
    
    [manager GET:url
      parameters:dic
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             //拿到请求结果,回调
             dispatch_async(dispatch_get_main_queue(), ^{
                 response(responseObject);
             });
             
             
         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             ;
         }];

    

    }

}

#pragma mark - Post请求
- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(responseBlock)response {
   
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];

    if (token ==nil) {
        
    }else{

        
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];

    NSString *udid = [UIDevice currentDevice].model ;

    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
  
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *session = [notFirstDic objectForKey:@"sb"];
    
    
    NSDate *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate *currentDate = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]];  //转化为UNIX时间戳
        
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    

    //时间戳
    float timeExpire = [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
     if (timeExpire >= time||token==nil) {
        //重新请求access_token
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        //    [manager.requestSerializer setValue: forKey:]; 请求头
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp" : timeSp,
                        @"app_session_token" : session
}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        
        
    }else {
        _token=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
    }

    //NSString *token=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:session forHTTPHeaderField:@"Application-Session"];
    NSString *url = [NSMutableString stringWithFormat:@"%@%@",NetBaseURLString,api];
    
   [manager GET:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       response(responseObject);
   } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
    

    
    
    
//    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",NetBaseURLString,api];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    [manager POST:fApi parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        response(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    }
}

#pragma mark - 时间戳转时间
/**
 * 年月日时分秒
 */
- (NSString *)timeintervalFormatYMDHMS:(NSNumber *)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd  hh:mm"];
    return [format stringFromDate:date];
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
    NSString *dropSqlStr = [NSString stringWithFormat:@"DROP TABLE %@",_tableName];
    [_db executeUpdate:dropSqlStr];
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, jsonData text NOT NULL);",_tableName];
    [_db executeUpdate:sqlStr];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"INSERT INTO %@ (jsonData) VALUES (?);",_tableName];
//    [_db executeUpdate:@"INSERT INTO %@ (jsonData) VALUES (?);",_tableName,dataStr];
    [_db executeUpdate:path,dataStr];
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



@end
