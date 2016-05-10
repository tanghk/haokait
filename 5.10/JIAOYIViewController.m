//
//  JIAOYIViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "JIAOYIViewController.h"
#import "jiaoyitable.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "UICommons.h"
#import "Masonry.h"
@interface JIAOYIViewController ()
{
    UILabel *_titleLabel;
     NSMutableArray *Mar;
}
@property (nonatomic, strong)jiaoyitable *jiaoyiban;
@end

@implementation JIAOYIViewController
-(void)viewWillAppear:(BOOL)animated{
    
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            NSLog(@"正在使用wifi网络");
            break;
    }if (!isExistenceNetwork) {
        UIAlertView *myalert = [[UIAlertView alloc]
                                initWithTitle:NSLocalizedString(@"温馨提示", @"Network error")
                                message:NSLocalizedString(@"当前网络不可用！请检查网络状态", nil)
                                delegate:self
                                cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
                                otherButtonTitles:nil];
        
        [myalert show];
        [HUD hide:YES afterDelay:0.5];
    }

    pageCont = 1;
    freshState = NO;
    

    [self request];
    
    [super viewWillAppear:animated];
    self.data = [NSMutableArray array];
    __weak JIAOYIViewController* weakSelf = self;
    //下拉刷新的头视图
    self.jiaoyiban.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.data removeObjectsInArray:
//         self.data]; //下拉刷新将原有数据移除｜｜重新加载数据
        pageCont = 1;
        freshState = NO;
        [weakSelf request];
    }];
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    self.view.backgroundColor = kcolorGrayNew;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//状态栏白色字体

    _jiaoyiban = [[jiaoyitable alloc]initWithFrame:CGRectMake(0, 44.5, __kScreenWidth__,__kScreenHeight__-100*__kScreenHeight__/1334-0.5)];
    [self.view addSubview:_jiaoyiban];
     _jiaoyiban.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 100*__kScreenHeight__/1334)];
    if (__kScreenHeight__ == 568) {
          head.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"dandu"]];
    }else{
          head.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"6traRec3.png"]];
    }
  
    
    UIImageView *shuai = [[UIImageView alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 22*__kScreenHeight__/1334, 172*__kScreenWidth__/750, 52*__kScreenHeight__/1334)];

    [head addSubview:shuai];
    
    UILabel *desi = [[UILabel alloc]initWithFrame:CGRectMake(410*__kScreenWidth__/750, 38*__kScreenHeight__/1334,100*__kScreenWidth__/750 ,27*__kScreenHeight__/1334 )];

    desi.font = [UIFont systemFontOfSize:14];
    [head addSubview:desi];
    _jiaoyiban.tableHeaderView = head;
    
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"交易记录";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(jiaoyijulufanhui:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];

    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =kColorNaviLine ;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationgView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];

    //穿透效果
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)jiaoyijulufanhui:(id)sender
{
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体

    [self.navigationController popViewControllerAnimated:YES];
}


//-(void)qing
//{
//    NSString *path =
//    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
//    //读取文件
//    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
//    
//    NSString *sb = [notFirstDic objectForKey:@"sb"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    
//    NSDate* lastDate =
//    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
//    NSDate* currentDate = [NSDate date];
//    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
//    
//    //时间戳
//    float timeExpire =
//    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
//    
//    if (timeExpire >= time) {
//        //重新请求access_token
//        
//        AFHTTPRequestOperationManager* manager =
//        [AFHTTPRequestOperationManager manager];
//        
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes =
//        [manager.responseSerializer.acceptableContentTypes
//         setByAddingObject:@"text/html"];
//        NSString *version = [[NSUserDefaults standardUserDefaults]objectForKey:@"system_version"];
//        
//        //    [manager.requestSerializer setValue: forKey:]; 请求头
//        
//        [manager POST:@"http://debug.otouzi.com:8012/device/register"
//         
//           parameters:@{
//                        @"device_type" : @"ios",
//                        @"device_unique" : @"tanghk",
//                        @"device_model" : @"1008611121",
//                        @"system_version" : version,
//                        @"request_timestamp" : currentDate,
//                        
//                        @"app_session_token" : sb
//                        }
//         
//              success:^(AFHTTPRequestOperation* operation, id responseObject) {
//                  
//                  NSLog(@"产品列表%@", responseObject);
//                  
//                  NSMutableDictionary* objc = [[NSMutableDictionary alloc] init];
//                  
//                  objc = responseObject;
//                  
//                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"]
//                                                            forKey:@"token"]; //存在本地沙盒
//                  
//                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
//                  
//                  NSString *token= [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//                  
//                  
//                  
//                  [[NSUserDefaults standardUserDefaults] synchronize];
//                  
//                  [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
//                  [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
//                  
//              }
//              failure:^(AFHTTPRequestOperation* operation, NSError* error){
//                  
//                  // NSLog(@"%@",error);
//                  
//              }];
//    }
//    else {
//        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//        
//        
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
//        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
//        
//    }
//    
//
//    [manager GET:@"http://debug.otouzi.com:8012/user/trades"
//      parameters:@{  @"p": @"1",                                         // 分页ID
//                     @"limit": @"6"
//                   }
//         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//             
//             
//             NSLog(@"%@",responseObject);
//             
//             
//             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
//             gerenzhongxin = responseObject;
//             
//             NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
//             NSMutableArray *yonghuming1= [yonghuming objectForKey:@"list"];
//             Mar = yonghuming1;
//             for (NSDictionary *dataDic in yonghuming1) {
//                 
//                 jiaoyimodel *model1 =[[jiaoyimodel alloc]initWithDataDic:dataDic];
//                 
//                 [self.data addObject:model1];
//                 self.jiaoyiban.data = self.data;
//                 
//             }
//             //刷新表视图，回到主线程
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 
//                 [self.jiaoyiban reloadData];
//                 
//                 NSLog(@"############# %@",self.jiaoyiban.data
//                       );
//
//             });
//
//           
//
//         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//             
//         }];
//}

-(void)request
{
//    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.delegate = self;
    //常用的设置
    //小矩形的背景色
    //  HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //显示的文字
    // HUD.labelText = @"正在加载";
//    [HUD show:YES];
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
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
        
        
      
        
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
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    
   NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    [manager POST:@"http://debug.otouzi.com:8012/V2/user/trades"
      parameters:@{ @"p": page,                                         // 分页ID
                    @"limit": @"10"
                    }
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             
             
             
             NSLog(@"交易记录请求第几页数据：%@",page);
             NSLog(@"%@",responseObject);
             
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
             NSMutableArray *yonghuming1= [yonghuming objectForKey:@"list"];
             Mar = yonghuming1;
             
             
             
            
             
             
             for (NSDictionary *dataDic in yonghuming1) {
                 
                
                 jiaoyimodel *model1 =[[jiaoyimodel alloc]initWithDataDic:dataDic];
                 if (freshState == NO) {
                     
                     [self.data removeAllObjects];
                     
                     freshState = YES;
                 }

                 [self.data addObject:model1];
               
                     self.jiaoyiban.data = self.data;


                 
             }
             //刷新表视图，回到主线程
             dispatch_async(dispatch_get_main_queue(), ^{
                  pageCont++;
                 [self.jiaoyiban reloadData];
                 
         
                 
                  [HUD hide:YES afterDelay:0.5];
                 
                 __weak JIAOYIViewController* weakSelf = self;
                 
                 //上拉加载更多
                 self.jiaoyiban.footer =
                 [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                     [weakSelf request];
                 }];

                 
                NSLog(@"############# %@",self.jiaoyiban.data
                       );
                 //结束下拉刷新
                 [self.jiaoyiban.header endRefreshing];
                 [self.jiaoyiban.footer endRefreshing];
                 
                 
                 
                 
                 
                 
                 if (self.data.count==0) {
                     
                     
                     [_jiaoyiban removeFromSuperview];
                     _jiaoyiban =nil;
                     
                     
                     UILabel *noInvest = [UILabel new];
                     
                     noInvest.text = @"暂无交易记录!";
                     noInvest.font = Font(18);
                     noInvest.textColor = RGB(145, 145, 145, 1);
                     
                     [self.view addSubview:noInvest];
                     
                     [noInvest mas_makeConstraints:^(MASConstraintMaker *make) {
                         make.centerX.equalTo(self.view.mas_centerX);
                         make.centerY.equalTo(self.view.mas_centerY).offset(-kScreenContentHeight/4+18);
                         
                     }];
                     
                     
                     
                     
                 }else if (self.data.count <10 )
                 { if (yonghuming1.count == 0) {
                     [self.jiaoyiban.mj_footer endRefreshingWithNoMoreData];
                     
                     
                 }else{
                      [self.jiaoyiban.mj_footer endRefreshingWithNoMoreData];
                 }
                 }

             });
             
//             }
             
         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             
         }];
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
