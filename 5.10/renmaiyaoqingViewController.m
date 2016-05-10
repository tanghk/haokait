//
//  renmaiyaoqingViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "renmaiyaoqingViewController.h"
#import "renmaiyaoqing.h"
#import "MJRefresh.h"
#import "guizeViewController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface renmaiyaoqingViewController ()
{
    UILabel *renshu;
}
@property (nonatomic, strong)renmaiyaoqing *jiaoyiban;
@end

@implementation renmaiyaoqingViewController
-(void)viewWillAppear:(BOOL)animated{
    pageCont = 1;
    freshState = NO;
    
    
    [self qingqiushu];
    [super viewWillAppear:animated];
    self.data = [NSMutableArray array];
    __weak renmaiyaoqingViewController* weakSelf = self;
    //下拉刷新的头视图
    self.jiaoyiban.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.data removeObjectsInArray:
//         self.data]; //下拉刷新将原有数据移除｜｜重新加载数据
        pageCont = 1;
        freshState = NO;
        [weakSelf qingqiushu];
    }];
    
    //上拉加载更多
    self.jiaoyiban.footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf qingqiushu];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _jiaoyiban = [[renmaiyaoqing alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 1270*__kScreenHeight__/1334)];
    [self.view addSubview:_jiaoyiban];
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 100*__kScreenHeight__/1334)];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 259*__kScreenHeight__/1334)];
    //背景图
    
    UIImageView *imtu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 259*__kScreenHeight__/1334)];
    [imtu setImage:[UIImage imageNamed:@"6YQJL@2X_02.png"]];
    
    [head addSubview:imtu];
    [foot addSubview:imtu];
    //人数lable
    
    renshu = [[UILabel alloc]initWithFrame:CGRectMake(0,  66*__kScreenHeight__/1334, __kScreenWidth__, 80*__kScreenHeight__/1334)];

    
    
    renshu.font = [UIFont systemFontOfSize:40];
    
    renshu.textAlignment = NSTextAlignmentCenter;
    
    
    renshu.textColor = [UIColor colorWithRed:243/255.0 green:210/255.0 blue:78/255.0 alpha:1];
    
    [head addSubview:renshu];
    
    UILabel *leijirenshu = [[UILabel alloc]initWithFrame:CGRectMake(0, 159*__kScreenHeight__/1334, __kScreenWidth__, 25*__kScreenHeight__/1334)];
    leijirenshu.text = @"累计邀请（人）";
    
    leijirenshu.textColor = [UIColor colorWithRed:243/255.0 green:210/255.0 blue:78/255.0 alpha:1];
    
    
    leijirenshu.font = [UIFont systemFontOfSize:17];
    leijirenshu.textAlignment = NSTextAlignmentCenter;
    
    [head addSubview:leijirenshu];
    _jiaoyiban.tableHeaderView = head;

    _jiaoyiban.tableFooterView = foot;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIColor *coloer = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.view.backgroundColor = coloer;
    
    
    UIImage *img = [UIImage imageNamed:@"6YQJL@2X_01.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];

    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(renmaiyaoqing:) forControlEvents:UIControlEventTouchUpInside];
    
    //活动规则按钮
    
    UIButton *huodongguize  = [[UIButton alloc]initWithFrame:CGRectMake(599*__kScreenWidth__/750, 53*__kScreenHeight__/1334, 127*__kScreenWidth__/750, 48*__kScreenHeight__/1334)];
    UIImage *huo = [UIImage imageNamed:@"6inviteFriends_16@2x.png"];
    [huodongguize setBackgroundImage:huo forState:UIControlStateNormal];
    [self.view addSubview:huodongguize];
    [huodongguize addTarget:self action:@selector(yaoqing:) forControlEvents:UIControlEventTouchUpInside];


        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)renmaiyaoqing:(id)sender
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

-(void)qingqiushu
{
    
    
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //常用的设置
    //小矩形的背景色
    //  HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //显示的文字
    // HUD.labelText = @"正在加载";
    [HUD show:YES];

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
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    
  NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    [manager POST:@"http://debug.otouzi.com:8012/user/invitedRecord"
       parameters:@{@"p": page,              // 基本分页
                    @"limit": @"10" }         // 记录数，默认 10}
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"%@",responseObject);
             
              NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
              gerenzhongxin = responseObject;
              

              NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
              
              
              
              NSMutableArray *yonghuming1= [yonghuming objectForKey:@"list"];

              
              for (NSDictionary *dataDic in yonghuming1) {
                  
                  renmaimodle *model1 =[[renmaimodle alloc]initWithDataDic:dataDic];
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
                  NSLog(@"############# %@",self.jiaoyiban.data
                        );
                  //结束下拉刷新
                  [self.jiaoyiban.header endRefreshing];
                  [self.jiaoyiban.footer endRefreshing];
                  
              });

              [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"totalRows"] forKey:@"renshu1"];
              NSString *pepole = [[NSUserDefaults standardUserDefaults]objectForKey:@"renshu1"];
              NSLog(@"%@",pepole);
              renshu.text = [NSString stringWithFormat:@"%@",pepole];
              
              
          } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
              
          }];
}

-(void)yaoqing:(id)sender
{
    guizeViewController *touziba = [[guizeViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:touziba animated:NO completion:nil];
    
    
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
