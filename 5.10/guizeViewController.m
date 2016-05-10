//
//  guizeViewController.m
//  555
//
//  Created by 李浩宇 on 16/1/7.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "guizeViewController.h"

@interface guizeViewController ()
{
    NSString *sta;
}
@property (nonatomic,strong)NSString *WANGZHI;
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation guizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"6OpenRemiTit3@2x.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];
    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(cheba1:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate* currentDate = [NSDate date];
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    
    if (timeExpire >= time) {
        //重新请求access_token
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSString *udid = [UIDevice currentDevice].model ;
        NSLog(@"************唯一标识符%@",uuid);
        
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp": timeSp,
                        // @" backage_md5": @"1234678998765412374185296395175",
                        
                        @"app_session_token":sb}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    }
    else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        sta = token;
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    
    
    
    
    [manager GET:@"http://debug.otouzi.com:8012/user/center"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             
             NSLog(@"%@",responseObject);
             
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             dic = responseObject;

             
             _WANGZHI = [[NSUserDefaults standardUserDefaults]objectForKey:@"guizewangzhi"];
             
             NSLog(@"%@",_WANGZHI);
             
             UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64,self.view.bounds.size.width,__kScreenHeight__-64)];
             NSURL *url = [NSURL URLWithString:_WANGZHI];
             
             NSURLRequest *request = [NSURLRequest requestWithURL:url];
             
             NSMutableURLRequest *mutableRequest = [request mutableCopy];
             
             NSString *value = [NSString stringWithFormat:@"%@",sta];
             NSString *value1 = [NSString stringWithFormat:@"%@",sb];
             NSString *value2 = [NSString stringWithFormat:@"BROWSER"];
             [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
             [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
             [mutableRequest addValue:value2 forHTTPHeaderField:@"T-User-Agent"];
             //3.把值覆给request
             request = [mutableRequest copy];
             
             //4.查看请求头
             NSLog(@"%@", request.allHTTPHeaderFields);
             
             
             
             
             [_webView loadRequest:request];
             [self.view addSubview:_webView];
             
             
             //             NSString *jsCode = [NSString stringWithFormat:@"alert(1);"];
             //             [_webView stringByEvaluatingJavaScriptFromString:jsCode];
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             NSLog(@"%@",error);
         }];
    
    
    
    UIColor *coloer = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.view.backgroundColor = coloer;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cheba1:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
