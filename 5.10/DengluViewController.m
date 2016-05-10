
//
//  DengluViewController.m
//  555
//
//  Created by 浩宇李 on 15/9/23.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
#import "BaseNavigationController.h"
#import "DengluViewController.h"

#import "MainViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "wangjimimaViewController.h"
#import "TabbarViewController.h"
#import "zhucedeViewController.h"
#import "CLLockVC.h"
#import "CoreArchive.h"
#import "MBProgressHUD.h"
#import "maitViewController.h"
#import "Masonry.h"
#import "UICommons.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)

@interface DengluViewController ()<MBProgressHUDDelegate>
{
    UILabel *_titleLabel;
    NSTimer *_timer;
    MBProgressHUD *HUD;
    int q;
     int stauts1;
    UITextField *mimashuru;
    UITextField *shuru;
}

@end

@implementation DengluViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"zhijietiao" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"haimeidenglune" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"meidenglune" object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)bushidenglu
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{ [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *myalert = [[UIAlertView alloc]
                                initWithTitle:NSLocalizedString(@"温馨提示", @"Network error")
                                message:NSLocalizedString(@"当前网络不可用！请检查网络状态", nil)
                                delegate:self
                                cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
                                otherButtonTitles:nil];
        
        [myalert show];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"yincang" object:self];
 
        return;
    }

    NSString *banduan4=  [[NSUserDefaults standardUserDefaults] objectForKey:@"haimeidenglune"];
    int panduan4 = [banduan4 intValue];
    NSString *banduan3=  [[NSUserDefaults standardUserDefaults] objectForKey:@"zhijietiao"];
    int panduan3 = [banduan3 intValue];
    
    
    if (panduan3 == 89) {
        
        MainViewController *my = [[MainViewController alloc]init];
        
        [self.navigationController pushViewController:my animated:YES];
        
    }else if (panduan4 == 90) {
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bushidenglu) name:@"meidenglune" object:nil];
                
    

    
  

    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    
    self.view.backgroundColor =[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];

  
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"登录";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(tiaozhuanshouye:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];

    
#pragma mark - 背景图
    
    UIImageView *imge_deng = [[UIImageView alloc]init];
    [self.view addSubview:imge_deng];
    [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height - 64);
        
    }];
    [imge_deng setImage:[UIImage imageNamed:@"denglu_.png"]];
    
    
#pragma mark - 用户输入框
    
    
    if (__kScreenHeight__ == 568) {
        
        shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.154*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        shuru.delegate = self;
        
        shuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        shuru.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        _shoujihao = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        shuru.textColor = [UIColor blackColor];
        shuru.placeholder = @"请输入手机号/用户名";
        [shuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        [shuru addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }else if (__kScreenHeight__ >= 667)
    {
        shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.134*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        shuru.delegate = self;
        
        shuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        shuru.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        _shoujihao = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        shuru.textColor = [UIColor blackColor];
        shuru.placeholder = @"请输入手机号/用户名";
        [shuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        [shuru addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }else{
        shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.154*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        shuru.delegate = self;
        
        shuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        shuru.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        _shoujihao = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
        shuru.textColor = [UIColor blackColor];
        shuru.placeholder = @"请输入手机号/用户名";
        [shuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        [shuru addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    
    
#pragma mark -密码输入框
    if (__kScreenHeight__ == 568) {
        mimashuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.235*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        mimashuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mimashuru.textColor = [UIColor blackColor];
        mimashuru.placeholder = @"请输入密码";
        [mimashuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        mimashuru.secureTextEntry = YES;
        
        [self.view addSubview:mimashuru];
        mimashuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [mimashuru addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        
        
    }else if (__kScreenHeight__ >= 667)
    {
        mimashuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.215*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        mimashuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mimashuru.textColor = [UIColor blackColor];
        mimashuru.placeholder = @"请输入密码";
        [mimashuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        mimashuru.secureTextEntry = YES;
        
        [self.view addSubview:mimashuru];
        mimashuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [mimashuru addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        
        
    }
    else{
        mimashuru = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.235*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        mimashuru.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mimashuru.textColor = [UIColor blackColor];
        mimashuru.placeholder = @"请输入密码";
        [mimashuru setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        mimashuru.secureTextEntry = YES;
        mimashuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        [self.view addSubview:mimashuru];
        
        
        [mimashuru addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
       
#pragma mark -登录按钮
    if (__kScreenHeight__ == 568) {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.41*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];

    }else if (__kScreenHeight__ == 667)
    {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.395*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];

    }else{
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.392*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    
#pragma mark -密码详情    
//    if (__kScreenHeight__ == 568) {
//        UIButton *xiaoyanjing = [[UIButton alloc]initWithFrame:CGRectMake(581*__kScreenWidth__/750, 600*__kScreenHeight__/1334, 47*__kScreenWidth__/750, 23*__kScreenHeight__/1334)];
//        UIImage *xiaoanniu = [UIImage imageNamed:@"6loginEye@2x.png"];
//        [xiaoyanjing setBackgroundImage:xiaoanniu forState:UIControlStateNormal];
//        [self.view addSubview:xiaoyanjing];
//        
//
//        UIButton *mingwen1 = [[UIButton alloc]initWithFrame:CGRectMake(541*__kScreenWidth__/750, 580*__kScreenHeight__/1334, 107*__kScreenWidth__/750, 73*__kScreenHeight__/1334)];
//        mingwen1.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:mingwen1];
//
//        [mingwen1 addTarget:self action:@selector(zuxianshimiama:) forControlEvents:UIControlEventTouchUpInside];
//    }else if (__kScreenHeight__ >= 667)
//    {
//        UIButton *xiaoyanjing = [[UIButton alloc]initWithFrame:CGRectMake(581*__kScreenWidth__/750, 615*__kScreenHeight__/1334, 47*__kScreenWidth__/750, 23*__kScreenHeight__/1334)];
//        UIImage *xiaoanniu = [UIImage imageNamed:@"6loginEye@2x.png"];
//        [xiaoyanjing setBackgroundImage:xiaoanniu forState:UIControlStateNormal];
//        [self.view addSubview:xiaoyanjing];
//       
//
//        UIButton *mingwen1 = [[UIButton alloc]initWithFrame:CGRectMake(541*__kScreenWidth__/750, 600*__kScreenHeight__/1334, 107*__kScreenWidth__/750, 73*__kScreenHeight__/1334)];
//        mingwen1.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:mingwen1];
//         [mingwen1 addTarget:self action:@selector(zuxianshimiama:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    
    
    
#pragma mark -忘记密码
    if (__kScreenHeight__ == 568) {
       
        
        
        UIButton *xiaode = [[UIButton alloc]initWithFrame:CGRectMake(0.783*__kScreenWidth__, 0.294*__kScreenHeight__, 200*__kScreenWidth__/640, 80*__kScreenHeight__/1136)];
        xiaode.backgroundColor=[UIColor clearColor];
        [self.view addSubview:xiaode];
        [xiaode addTarget:self action:@selector(wangji:) forControlEvents:UIControlEventTouchUpInside];
    
    }else if (__kScreenHeight__ == 667)
    {
        
    

        UIButton *xiaode = [[UIButton alloc]initWithFrame:CGRectMake(0.783*__kScreenWidth__, 0.294*__kScreenHeight__, 120*__kScreenWidth__/640, 63*__kScreenHeight__/1136)];
        xiaode.backgroundColor=[UIColor clearColor];
        [self.view addSubview:xiaode];
        [xiaode addTarget:self action:@selector(wangji:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        UIButton *xiaode = [[UIButton alloc]initWithFrame:CGRectMake(0.76*__kScreenWidth__, 0.28*__kScreenHeight__, 200*__kScreenWidth__/640, 80*__kScreenHeight__/1136)];
        xiaode.backgroundColor=[UIColor clearColor];
        [self.view addSubview:xiaode];
        [xiaode addTarget:self action:@selector(wangji:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    

    
    
#pragma mark -注册按钮
    
    if (__kScreenHeight__ == 568) {
       
       
        UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(658*__kScreenWidth__/750, 75*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
        deiu.text = @"注册";
        deiu.font = [UIFont systemFontOfSize:15];
        deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
        
        [self.view addSubview:deiu];
        
        
        UIButton *wuwuw = [[UIButton alloc]initWithFrame:CGRectMake(618*__kScreenWidth__/750, 40*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 90*__kScreenHeight__/1334)];
        
        
        wuwuw.backgroundColor = [UIColor clearColor];
        [self.view addSubview:wuwuw];
        [wuwuw addTarget:self action:@selector(zhuceye:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }else if (__kScreenHeight__ >= 667)
    {

        UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(658*__kScreenWidth__/750, 59*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
        deiu.text = @"注册";
        deiu.font = [UIFont systemFontOfSize:15];
        deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
        
        [self.view addSubview:deiu];
        
        
        UIButton *wuwuw = [[UIButton alloc]initWithFrame:CGRectMake(618*__kScreenWidth__/750, 40*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
       

        wuwuw.backgroundColor = [UIColor clearColor];
        [self.view addSubview:wuwuw];
        [wuwuw addTarget:self action:@selector(zhuceye:) forControlEvents:UIControlEventTouchUpInside];

    }else{
        UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(658*__kScreenWidth__/750, 75*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
        deiu.text = @"注册";
        deiu.font = [UIFont systemFontOfSize:15];
        deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
        
        [self.view addSubview:deiu];
        
        
        UIButton *wuwuw = [[UIButton alloc]initWithFrame:CGRectMake(618*__kScreenWidth__/750, 40*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 90*__kScreenHeight__/1334)];
        
        
        wuwuw.backgroundColor = [UIColor clearColor];
        [self.view addSubview:wuwuw];
        [wuwuw addTarget:self action:@selector(zhuceye:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
   }

-(void)tiaozhuanshouye:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
   AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    

    

}

-(void)chenggongl:(id)sender
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];

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
    }
    if (!isExistenceNetwork) {
        UIAlertView *myalert = [[UIAlertView alloc]
                                initWithTitle:NSLocalizedString(@"温馨提示", @"Network error")
                                message:NSLocalizedString(@"当前网络不可用！请检查网络状态", nil)
                                delegate:self
                                cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
                                otherButtonTitles:nil];
        
        [myalert show];
        
         [HUD hide:YES afterDelay:0.5];
        return;
    }

    
    
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];

    if (_shoujihao != nil && _mima !=nil)
    {
        
        
 
        

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
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if (timeExpire >= time || token == nil) {
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
            
            NSLog(@"%@",sb);
            
            
            
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
        [manager POST:@"http://debug.otouzi.com:8012/user/login"
         
           parameters:@{@"username": _shoujihao,//@"microsoft",
                        @"password": _mima//@"qwerty"
                        }
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  NSDictionary *objc1 = [[NSDictionary alloc] init];
                  
                  objc1 = responseObject;
                  NSLog(@"登录成功%@",responseObject);

                  
               
                  if ([[objc1 objectForKey:@"code"]isEqualToNumber:@200]) {
                      
                [[NSNotificationCenter defaultCenter]postNotificationName:@"investSucess" object:self];
                      NSDictionary *dataDic = [objc1 objectForKey:@"data"];
                      NSNumber*open_account = [dataDic objectForKey:@"open_account"];
                      NSLog(@"开通汇付的状态：%@",open_account);
                      /*
                       *开通汇付的状态存入沙盒路径
                       */
                      
                      [[NSUserDefaults standardUserDefaults]setObject:_shoujihao forKey:@"samenamede"];
                      
                      

                      [[NSUserDefaults standardUserDefaults] setObject:open_account forKey:@"open_account"];
                      
                      
                      [self dismissViewControllerAnimated:YES completion:^{
                          NSLog(@"弹出的登录界面收起");
                          
                          
                          if ([_statues isEqualToString:@"000"]) {//产品列表跳登录
                              
                              
                              [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
                              
                              
                          }else if([_statues isEqualToString:@"111"]){//新手标js交互
                              
                              
                              [[NSNotificationCenter defaultCenter]postNotificationName:@"newProductLoginSuccess" object:nil];
                              
                          }
                          
                          
                          
                          
                          
                          
                      }];
                      
                      
                  }
                  

                 
                  

                  
                  NSString *banduan= [responseObject objectForKey:@"code"];
                  NSLog(@"%@",banduan);
                  int unm1 = [banduan intValue];
                  if (unm1 == 200 ) {
                       [HUD hide:YES afterDelay:0.5];
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                      message:@"登陆成功"
                                                                     delegate:self
                                                            cancelButtonTitle:@"确定"
                                                            otherButtonTitles:nil];
                      

                      [self alertViewCancel:alert];
                    [[NSUserDefaults standardUserDefaults] setObject:@"200" forKey:@"code1"];//存在本地沙盒

            
                  }
                 else if (unm1 == 500)
                  {
                      if (__kScreenHeight__ == 568) {
                           [HUD hide:YES afterDelay:0.5];
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 390*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @" 服务器忙！请稍后再试！";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                           [HUD hide:YES afterDelay:0.5];
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 418*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @" 服务器忙！请稍后再试！";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                  }
                  else if(unm1 == 6003)
                  { if (__kScreenHeight__ == 568) {
                       [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"您已登录 ";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  { [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"您已登录";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      [self loginAction];
                      
                      
                  }
                  else if (unm1 == 4031)
                  {  if (__kScreenHeight__ == 568) {
                       [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 390*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @" 网络错误！请重新输入！";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  { [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 418*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @" 网络错误！请重新输入！";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      [self loginAction];
                      
                      
                  }
                  else if (unm1 == 2100)
                  { if (__kScreenHeight__ == 568) { [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请填写用户名";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  { [HUD hide:YES afterDelay:0.5];
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请填写用户名";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                  }
                  else if (unm1 == 2101)
                  {
                      if (__kScreenHeight__ == 568) { [HUD hide:YES afterDelay:0.5];
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名必须大于6位小于15位";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      { [HUD hide:YES afterDelay:0.5];
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名必须大于6位小于15位";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2102)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入密码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入密码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                      
                  }
                  else if (unm1 == 2103)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名或密码不正确";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名或密码不正确";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2104)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请填写手机号";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请填写手机号";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                      
                      
                  }
                  else if (unm1 == 2105)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"手机号格式不正确";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"手机号格式不正确";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                  }
                  else if (unm1== 2106)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"手机号已被注册";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"手机号已被注册";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  else if (unm1 == 2107)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"验证码申请频繁";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"验证码申请频繁";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2108)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请获取并填写手机验证码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请获取并填写手机验证码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2109)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"验证码不正确";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"验证码不正确";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2110)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名必须大于6位小于15位";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"用户名必须大于6位小于15位";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2111)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"邀请码不存在";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"邀请码不存在";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2113)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请先登录 ";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请先登录";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                  }
                  else if (unm1 == 2213)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"您已开通第三方托管";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"您已开通第三方托管";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2126)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"您还没有进行绑定手机";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"您还没有进行绑定手机";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2128)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"密码验证失败";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"密码验证失败";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                      
                  }
                  else if (unm1 == 2129)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请输入旧密码";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请输入旧密码";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  else if (unm1 == 2130)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(270*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 270*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入新密码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入新密码";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2131)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"新密码不能与旧密码一致";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"新密码不能与旧密码一致";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2332)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 510*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"新手机不能与旧密码一致";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(120*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 498*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"新手机不能与旧密码一致";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  else if (unm1 == 2333)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 390*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"当前手机已被使用";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 418*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"当前手机已被使用";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  else if (unm1 == 2334)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请输入旧手机号";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请输入旧手机号";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  else if (unm1 == 2335)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入新手机号";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"请输入新手机号";
                          meishurushouji.layer.cornerRadius = 7;
                          meishurushouji.clipsToBounds = YES;
                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
                          [UIView beginAnimations:nil context:nil];
                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                          [UIView setAnimationDuration:2.0];
                          [UIView setAnimationDelegate:self];
                          meishurushouji.alpha =0.0;
                          [UIView commitAnimations];//2秒后消失
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                          meishurushouji.textAlignment = UITextAlignmentCenter;
                      }
                      
                  }
                  else if (unm1 == 2336)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"旧手机号验证失败";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"旧手机号验证失败";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                  }
                  else if (unm1 == 2359)
                  { [HUD hide:YES afterDelay:0.5];
                      if (__kScreenHeight__ == 568) {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请获取手机验证码";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                      meishurushouji.font = [UIFont systemFontOfSize:13];
                  }else if (__kScreenHeight__ >= 667)
                  {
                      UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                      meishurushouji.textColor = [UIColor whiteColor];
                      meishurushouji.text = @"请获取手机验证码";
                      meishurushouji.layer.cornerRadius = 7;
                      meishurushouji.clipsToBounds = YES;
                      meishurushouji.textAlignment = NSTextAlignmentCenter;
                      meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                      [self.view addSubview:meishurushouji];
                      [UIView beginAnimations:nil context:nil];
                      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                      [UIView setAnimationDuration:2.0];
                      [UIView setAnimationDelegate:self];
                      meishurushouji.alpha =0.0;
                      [UIView commitAnimations];//2秒后消失
                      meishurushouji.font = [UIFont systemFontOfSize:15];
                      meishurushouji.textAlignment = UITextAlignmentCenter;
                  }
                      
                      
                  }
                  
                  
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        
                 
        
     
        
        
    }else
    { [HUD hide:YES afterDelay:0.5];
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"用户名或密码不完整";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.textAlignment = UITextAlignmentCenter;
            
            meishurushouji.font = [UIFont systemFontOfSize:13];
        }else if (__kScreenHeight__ >= 667)
        {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"用户名或密码不完整";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.font = [UIFont systemFontOfSize:15];
            meishurushouji.textAlignment = UITextAlignmentCenter;
        }
    }


    

}
- (void)textField:(UITextField *)textField
{
    _mima = textField.text;
        NSLog(@"###%@",_mima);
    
}

- (void)textFieldEditChanged:(UITextField *)textField

{
    
    _shoujihao = textField.text;
        NSLog(@"textfield text %@",_shoujihao);
    
}
-(void)alertViewCancel:(UIAlertView *)alertView
{
    
    
    
    [HUD hide:YES afterDelay:0.5];
      NSString *from = [[NSUserDefaults standardUserDefaults]objectForKey: @"fromCoreLock"];
    if ([from intValue] ==1) {
      
        
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"fromMain"];
        
        [self setCoreLock];
        
        
        
    }else{
     
             TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
        tabbarcontroller.selectedIndex =3;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbarcontroller;
        
        
        
        
    }
    

}

-(void)wangji:(id)sender
{
    wangjimimaViewController *wangji = [[wangjimimaViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];

    [self presentViewController:wangji animated:NO completion:nil];
}


-(void)zhuceye:(id)sender
{
    zhucedeViewController *zhuce = [[zhucedeViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
  
    [self presentViewController:zhuce animated:NO completion:nil];

}
-(void)setModel:(ListModel *)model{
    
    _model = model;
}

-(void)zuxianshimiama:(id)sender
{
    if (q%2 == 0) {
         mimashuru.secureTextEntry = NO;
        q++;
    }else{
         mimashuru.secureTextEntry = YES;
        q++;
    }
   
    
}
- (void)loginAction {
    [[NSUserDefaults standardUserDefaults ]removeObjectForKey:@"duandingkuaijie"];
      [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"newbiewc"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"biaohaoka"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"morenkahao"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba1"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba2"];

    /*
     *退出后将手势密码
     */
    
    //取出本地密码
    NSString *pwdLocal = [CoreArchive strForKey:@"CoreLockPWDKey"];
    
    NSLog(@"本地密码%@",pwdLocal );
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:nil forKey:@"CoreLockPWDKey"];
    
    //立即同步
    [defaults synchronize];
    
    
    NSString*pd = [[NSUserDefaults standardUserDefaults]objectForKey:@"CoreLockPWDKey"];
    NSLog(@"移除手势密码%@",pd);
    
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"SetLockType" ];//将已经验证移除
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"open_account"];//移除是否开通汇付的判断
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    // NSString *session = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    
    [manager GET:@"http://debug.otouzi.com:8012/user/logout"
      parameters:@{}
     
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"huifuzhuangtai21"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tixianwebwangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"open_account"];//汇付状态
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"huifuzhuangtai"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kehuzhanghao"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bangkawangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chongzhiwangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"code1"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zhijietiao"];
             
             
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"chongzhihouzhanghujine"];
             
             

             [[NSNotificationCenter defaultCenter]postNotificationName:@"yincang" object:self];
             
             
             

             
         
             
             
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             
         }];
}

-(void)setCoreLock{
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if (hasPwd == NO) {
        
        
        hasPwd = NO;
        
        
        if(hasPwd){
            NSLog(@"已经设置过密码了，你可以验证或者修改密码");
        }
        else{
            NSLog(@"haimei");
            [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                
                NSString *type = @"1";
                [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];//验证手势密码
                NSLog(@"密码设置成功");
                [lockVC dismiss:0.5f];
                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"fromCoreLock"];
                
                NSString *setType = @"1";
                [[NSUserDefaults standardUserDefaults]setObject:setType forKey:@"SetLockType"];//设置手势密码
                
                
            }];
        }
        
    }
    
}

@end
