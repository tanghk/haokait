//
//  jihouyaoqingViewController.m
//  555
//
//  Created by 李浩宇 on 16/1/5.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "jihouyaoqingViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "guizeViewController.h"
@interface jihouyaoqingViewController ()

{
    UITableView *scrollview;
    NSString *yaoqing;
    
}

@end

@implementation jihouyaoqingViewController
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, __kScreenHeight__-64)];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 1458*__kScreenHeight__/1334)];
     scrollview.showsVerticalScrollIndicator=NO;
    scrollview.tableHeaderView = head;
    
    scrollview.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];

    [self.view addSubview:scrollview];
    
    UIImage *img = [UIImage imageNamed:@"6ActivateInvite1@2x.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];
    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(jihuo:) forControlEvents:UIControlEventTouchUpInside];
    
    //活动规则按钮
    
    UIButton *huodongguize  = [[UIButton alloc]initWithFrame:CGRectMake(599*__kScreenWidth__/750, 53*__kScreenHeight__/1334, 127*__kScreenWidth__/750, 48*__kScreenHeight__/1334)];
    UIImage *huo = [UIImage imageNamed:@"6inviteFriends_16@2x.png"];
    [huodongguize setBackgroundImage:huo forState:UIControlStateNormal];
    [self.view addSubview:huodongguize];
    [huodongguize addTarget:self action:@selector(yaoqing:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //简介
    
    UIImageView *jianjie = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 695*__kScreenHeight__/1334)];
    
    UIImage *imjie = [UIImage imageNamed:@"6inviteFriends_02@2x.png"];
    [jianjie setImage:imjie];
    
    
    [head addSubview:jianjie];
    
    //yellow
    
    UIImageView *yellow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 695*__kScreenHeight__/1334, __kScreenWidth__, 763*__kScreenHeight__/1334)];
    
    UIImage *imyellow = [UIImage imageNamed:@"6ActivateInvite3@2x.png"];
    [yellow setImage:imyellow];
    [head addSubview:yellow];

    
    
    //lable
    
    UILabel *labletext = [[UILabel  alloc]initWithFrame:CGRectMake(0, 758*__kScreenWidth__/750, __kScreenWidth__, 35*__kScreenHeight__/1334)];
    labletext.text = @"激活邀请码，享受0.2%额外年化收益";
    labletext.textColor = [UIColor whiteColor];
    labletext.textAlignment = NSTextAlignmentCenter;
    [head addSubview:labletext];
    
    //激活按钮
    UIButton *jihuo = [[UIButton alloc]initWithFrame:CGRectMake(556*__kScreenWidth__/750, 852*__kScreenHeight__/1334, 132*__kScreenWidth__/750, 58*__kScreenHeight__/1334)];
    [jihuo setImage:[UIImage imageNamed:@"6ActivateInvite4@2x.png"] forState:UIControlStateNormal];
    [head addSubview:jihuo];

    [jihuo addTarget:self action:@selector(jihuoan:) forControlEvents:UIControlEventTouchUpInside];
    
    //471 立即投资按钮 1353
    
    UIButton *liji = [[UIButton alloc]initWithFrame:CGRectMake(471*__kScreenWidth__/750, 1353*__kScreenHeight__/1334, 156*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
    [liji setImage:[UIImage imageNamed:@"6ActivateInvite5@2x.png"] forState:UIControlStateNormal];
    [head addSubview:liji];
    [liji addTarget:self action:@selector(lijitouzitiao:) forControlEvents:UIControlEventTouchUpInside];
    
    //220 852 邀请码输入框
    UITextField *yaoqingmashuru = [[UITextField alloc]initWithFrame:CGRectMake(240*__kScreenWidth__/750, 852*__kScreenHeight__/1334, 267*__kScreenWidth__/750, 60*__kScreenHeight__/1334)];
    [head addSubview:yaoqingmashuru];
    [yaoqingmashuru addTarget:self action:@selector(textFieldyao:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)textFieldyao:(UITextField *)textField
{
    yaoqing = textField.text;
    NSLog(@"###%@",yaoqing);
    
}
-(void)lijitouzitiao:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"quzhaunqian" object:self];
}
-(void)jihuoan:(id)sender
{
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
    [manager POST:@"http://debug.otouzi.com:8012/bindCode"
       parameters:@{@"recommend" : yaoqing }
                    success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
                        
                        NSLog(@"%@",responseObject);
                        
                    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
                        
                    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jihuo:(id)sender
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
