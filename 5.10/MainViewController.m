                                                                                                                                                                                                       //
//  MainViewController.m
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
/**
 * 　　　　　　　　┏┓　　　┏┓
 * 　　　　　　　┏┛┻━━━┛┻┓
 * 　　　　　　　┃　　　　　　　┃
 * 　　　　　　　┃　　　━　　　┃
 * 　　　　　　　┃　＞　　　＜　┃
 * 　　　　　　　┃　　　　　　　┃
 * 　　　　　　　┃...　⌒　...　┃
 * 　　　　　　　┃　　　　　　　┃
 * 　　　　　　　┗━┓　　　┏━┛
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┃   神兽保佑,代码无bug
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┃
 * 　　　　　　　　　┃　　　┗━━━┓
 * 　　　　　　　　　┃　　　　　　　┣┓
 * 　　　　　　　　　┃　　　　　　　┏┛
 * 　　　　　　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　　　　　　┃┫┫　┃┫┫
 * 　　　　　　　　　　┗┻┛　┗┻┛
 */
#import "lunboViewController.h"
#import "MainViewController.h"
#import "KLLoopImageView.h"
#import "AFNetworking.h"
#import "SDCycleScrollView.h"
#import "Reachability.h"
#import "VerifyPwdViewController.h"
#import "CLLockVC.h"
#import "xinshouViewController.h"
#import "zhucelibaoViewController.h"
#import "addViewController.h"
#import "anquanViewController.h"
#import "DataService.h"
#import "UICommons.h"
#import "UIViewExt.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "yaoqinghaoyouViewController.h"
#import "TabbarViewController.h"
#import "jihouyaoqingViewController.h"
#import "CommonProblemsViewController.h"
#import "RiskGuaranteeViewController.h"
#import "ggxqViewController.h"
#import "UITabBar+badge.h"
#import "HomePageNoticeController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface MainViewController ()<SDCycleScrollViewDelegate>
{
    UIImageView *huodong;
    UIImageView *yaoqing ;
    UIImageView *gonggao ;
    UIImageView *anquam;
    UIImageView *zhuce;
    UIImageView *xinshou;
    UIView *head;
    UITableView *table;
    UIScrollView *_bannerScrollView;
    UIPageControl *_pageControl;
    int _bannerCount;
    NSTimer *_timer;
    NSString *_newVesion;
     NSString *_version;//版本号
    UILabel *label1;
    UILabel *label2;
    NSInteger count; //请求更新数据的次数
    SDCycleScrollView *cycleScrollView2;
    
    
    NSString* _activityValue;
    NSString* _noticeValue;
    NSString * _lastActivitySandbox;//沙河
    NSString * _lastNoticeSandbox;//沙河
    
    
    BOOL noticeState; // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBtn"];
    BOOL   activitystate;  //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionButton"];
    
    NSString * _clickNoticeDate; //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
    NSString * _clickActionDate;  // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
    
    BOOL isExistenceNetwork;
    UIButton *_cancleButton;
    UIButton *_sureButton;
}
@property (nonatomic,strong)NSString *aixintouziren;
@property (nonatomic,strong)NSString *zhuzinonghu;
@property (nonatomic,strong)NSString *haiyoushei;
@property(nonatomic,strong)NSString *session;
@property(nonatomic,strong)NSString *token;
@end

@implementation MainViewController


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tuile" object:nil];
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //显示
  //  [self.tabBarController.tabBar showBadgeOnItemIndex:2];
 
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"6hPBannerLoding@2x.png"];
    [head addSubview:cycleScrollView2];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorDeepBlue;
    [self.view addSubview:navigationgView];
    
    UIImage *img = [UIImage imageNamed:@"homePage_01.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    
    [im setImage:img];
    
    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
    if (panduan == 200 ) {
    
  
    }else{
    
    
        if(__kScreenHeight__== 568)
        { UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(638*__kScreenWidth__/750, 80*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
            deiu.text = @"登录";
            deiu.font = [UIFont systemFontOfSize:14];
            deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
            //        [deiu setImage:[UIImage imageNamed:@"6homePageLogin@2x.png"] forState:UIControlStateNormal];
            [self.view addSubview:deiu];

            
        }else if (__kScreenHeight__ >= 667 )
        { UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(638*__kScreenWidth__/750, 59*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
            deiu.text = @"登录";
            deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
            //        [deiu setImage:[UIImage imageNamed:@"6homePageLogin@2x.png"] forState:UIControlStateNormal];
            [self.view addSubview:deiu];

            
        }
        else{
            UILabel *deiu = [[UILabel alloc]initWithFrame:CGRectMake(638*__kScreenWidth__/750, 80*__kScreenHeight__/1334, 88*__kScreenWidth__/750, 49*__kScreenHeight__/1334)];
            deiu.text = @"登录";
            deiu.font = [UIFont systemFontOfSize:14];
            deiu.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
            //        [deiu setImage:[UIImage imageNamed:@"6homePageLogin@2x.png"] forState:UIControlStateNormal];
            [self.view addSubview:deiu];
            
        }
        

    }
    
    
    UIButton *ii = [[UIButton alloc]initWithFrame:CGRectMake(610*__kScreenWidth__/750, 49*__kScreenHeight__/1334, 120*__kScreenWidth__/750, 79*__kScreenHeight__/1334)];
    ii.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ii];
    [ii addTarget:self action:@selector(uais:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [navigationgView addSubview:im];
    
    isExistenceNetwork = YES;
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
    
    
    return;
}

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shengchengzifu) name:@"tuile" object:nil];

    

    
}


- (void)viewDidLoad {
    [super viewDidLoad];

        

    [self shengchengzifu];
    
    count = 1;
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
    if (panduan == 200 ) {

        NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];
        if ([setType isEqualToString:@"1"]) {
           
            
            
            
            
            
            NSString *pwdType = [[NSUserDefaults standardUserDefaults]objectForKey:@"coreLockType"];
            
            
            if ([pwdType isEqualToString:@"1"]) {
                ;
            }else{
                
                
                if (self) {
                    
                    BOOL hasPwd = [CLLockVC hasPwd];
                    
                    if(!hasPwd){
                        
                        NSLog(@"你还没有设置密码，请先设置密码");
                    }else {
                        
                        
                        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
                            NSLog(@"忘记密码");
                        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                            NSLog(@"密码正确");
                            
                            NSString *type = @"1";
                            [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];//验证密码成功
                            [lockVC dismiss:1.0f];
                            
                            
                            
                        }];
                    }
                }
 
            
            
            }
            
            
    
        }else{
            
            
            BOOL hasPwd = [CLLockVC hasPwd];
            
            if (hasPwd == NO) {
                
                
                hasPwd = NO;
                
                
                if(hasPwd){
                    NSLog(@"已经设置过密码了，你可以验证或者修改密码");
                }
                else{
//                    NSLog(@"haimei");
//                    [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
//                        
//                        NSString *type = @"1";
//                        [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];
//                        NSLog(@"密码设置成功");
//                        [lockVC dismiss:0.5f];
//                     
//                        
//                        AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//                        TabbarViewController *tab = [[TabbarViewController alloc]init];
//                        delete.window.rootViewController = tab;
//                        
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
//                        
//                        
//                        
//                        NSString *setType = @"1";
//                        [[NSUserDefaults standardUserDefaults]setObject:setType forKey:@"SetLockType"];//设置手势密码
//                        
//                        
//                    }];
                }
                
            }
        }
        
  
        
        
        
    }else
    {
        
        
    }
    
    
    

 
        self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
    self.tabBarController.tabBar.hidden = NO;

    
    
    
    



    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, __kScreenWidth__, __kScreenHeight__)];
    [self.view addSubview:table];
   
    table.showsVerticalScrollIndicator = FALSE;
     head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
    table.tableHeaderView = head;
#pragma mark - 累计爱心投资人、累计助弄
    
    if (__kScreenHeight__ == 568)
    {
        UIImageView *imags = [[UIImageView alloc]initWithFrame:CGRectMake(0,325*__kScreenHeight__/1136, __kScreenWidth__, __kScreenHeight__*207/1136)];
        UIImage *tu = [UIImage imageNamed:@"homePage_04@2x.png"];
        [imags setImage:tu];
        
        [head addSubview:imags];
        
    }
    else if(__kScreenHeight__>= 667){
    UIImageView *imags = [[UIImageView alloc]initWithFrame:CGRectMake(0, (__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), __kScreenWidth__, __kScreenHeight__*243/1334)];
    UIImage *tu = [UIImage imageNamed:@"homePage_04@2x.png"];
    [imags setImage:tu];
    
        [head addSubview:imags];
    }else if (__kScreenHeight__ == 736)
    {
        UIImageView *imags = [[UIImageView alloc]initWithFrame:CGRectMake(0, (__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), __kScreenWidth__, __kScreenHeight__*243/1334)];
        UIImage *tu = [UIImage imageNamed:@"6homePage@3x_09.png"];
        [imags setImage:tu];
        
        [head addSubview:imags];
    }
    else{
        UIImageView *imags = [[UIImageView alloc]initWithFrame:CGRectMake(0,325*__kScreenHeight__/1136, __kScreenWidth__, __kScreenHeight__*207/1136)];
        UIImage *tu = [UIImage imageNamed:@"homePage_04@2x.png"];
        [imags setImage:tu];
        
        [head addSubview:imags];
    }

#pragma mark - #########   新手引导   #########
    
    
    if(__kScreenHeight__ == 568)
    {
        
        UIButton *xinshoubtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*21/640, 553*__kScreenHeight__/1136, 198*__kScreenWidth__/640,186*__kScreenHeight__/1136 )];

        xinshoubtn.backgroundColor = [UIColor clearColor];
   
       
        [head addSubview:xinshoubtn];
        [xinshoubtn addTarget:self action:@selector(xinshoutiuao:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(__kScreenHeight__ >= 667)
    {
        
      UIButton *xinshoubtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750, (24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), 234*__kScreenWidth__/750,219*__kScreenHeight__/1334 )];
        xinshoubtn.backgroundColor = [UIColor clearColor];
        
        
        [head addSubview:xinshoubtn];
    [xinshoubtn addTarget:self action:@selector(xinshoutiuao:) forControlEvents:UIControlEventTouchUpInside];
    }else if (__kScreenHeight__ == 736)
    {
        UIButton *xinshoubtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750, (24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), 234*__kScreenWidth__/750,219*__kScreenHeight__/1334 )];
        xinshoubtn.backgroundColor = [UIColor clearColor];
        
        
        
        [head addSubview:xinshoubtn];
        [xinshoubtn addTarget:self action:@selector(xinshoutiuao:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        UIButton *xinshoubtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*21/640, 553*__kScreenHeight__/1136, 198*__kScreenWidth__/640,186*__kScreenHeight__/1136 )];
        
        xinshoubtn.backgroundColor = [UIColor clearColor];
        
        
        [head addSubview:xinshoubtn];
        [xinshoubtn addTarget:self action:@selector(xinshoutiuao:) forControlEvents:UIControlEventTouchUpInside];

    }
#pragma mark - ##########  注册礼包   #########
    
    
    
    if (__kScreenHeight__ == 568)
    {
        UIButton *zhucebtn = [[UIButton alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        zhucebtn.backgroundColor = [UIColor clearColor];
        [head addSubview:zhucebtn];
        [zhucebtn addTarget:self action:@selector(zclb:) forControlEvents:UIControlEventTouchUpInside];

    }
    else if(__kScreenHeight__ >=667)
    {
        UIButton *zhucebtn = [[UIButton alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        zhucebtn.backgroundColor = [UIColor clearColor];
        
        [head addSubview:zhucebtn];
        [zhucebtn addTarget:self action:@selector(zclb:) forControlEvents:UIControlEventTouchUpInside];

    
    }
 
    else if (__kScreenHeight__ == 736)
    {
        UIButton *zhucebtn = [[UIButton alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        
         zhucebtn.backgroundColor = [UIColor clearColor];
        [head addSubview:zhucebtn];
        [zhucebtn addTarget:self action:@selector(zclb:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        UIButton *zhucebtn = [[UIButton alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        zhucebtn.backgroundColor = [UIColor clearColor];
        [head addSubview:zhucebtn];
        [zhucebtn addTarget:self action:@selector(zclb:) forControlEvents:UIControlEventTouchUpInside];
    }



    
    
    
#pragma mark -########  安全保障   ############
    
    
    
    if (__kScreenHeight__ == 568) {
        UIButton *anquambtn = [[UIButton alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];

        anquambtn.backgroundColor = [UIColor clearColor];
        [head addSubview:anquambtn];
        
        [anquambtn addTarget:self action:@selector(aq1:) forControlEvents:UIControlEventTouchUpInside];
    }else if(__kScreenHeight__ >= 667)
    {
      UIButton *anquambtn = [[UIButton alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
    
        anquambtn.backgroundColor = [UIColor clearColor];

        
    [head addSubview:anquambtn];
    
        [anquambtn addTarget:self action:@selector(aq1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    else if (__kScreenHeight__ == 736)
    {
        UIButton *anquambtn = [[UIButton alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        
         anquambtn.backgroundColor = [UIColor clearColor];
        
        [head addSubview:anquambtn];
        
        [anquambtn addTarget:self action:@selector(aq1:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else{
        UIButton *anquambtn = [[UIButton alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        anquambtn.backgroundColor = [UIColor clearColor];
        [head addSubview:anquambtn];
        
        [anquambtn addTarget:self action:@selector(aq1:) forControlEvents:UIControlEventTouchUpInside];

        
    }
#pragma mark - #######  公告中心  ###########
    
    if(__kScreenHeight__ == 568){
        UIButton *gonggaobtn = [[UIButton alloc]initWithFrame:CGRectMake(21*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
 
        gonggaobtn.backgroundColor = [UIColor clearColor];
        [head addSubview:gonggaobtn];
        
        
        [gonggaobtn addTarget:self action:@selector(gonggao:) forControlEvents:UIControlEventTouchUpInside];

    }else if (__kScreenHeight__ >= 667) {
        UIButton *gonggaobtn = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750,(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        gonggaobtn.backgroundColor = [UIColor clearColor];
        [head addSubview:gonggaobtn];
        
        
        [gonggaobtn addTarget:self action:@selector(gonggao:) forControlEvents:UIControlEventTouchUpInside];
    }else if (__kScreenHeight__ == 736)
    {
        UIButton *gonggaobtn = [[UIButton alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750,(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        
         gonggaobtn.backgroundColor = [UIColor clearColor];
        [head addSubview:gonggaobtn];
        
        
        [gonggaobtn addTarget:self action:@selector(gonggao:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        UIButton *gonggaobtn = [[UIButton alloc]initWithFrame:CGRectMake(21*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        
        gonggaobtn.backgroundColor = [UIColor clearColor];
        [head addSubview:gonggaobtn];
        
        
        [gonggaobtn addTarget:self action:@selector(gonggao:) forControlEvents:UIControlEventTouchUpInside];

    }
   
    
#pragma mark - #######  风险保障金   #########
    if(__kScreenHeight__ == 568){
        UIButton *yaoqingbtn = [[UIButton alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        yaoqingbtn.backgroundColor = [UIColor clearColor];
       
        
    
        [head addSubview:yaoqingbtn];
        [yaoqingbtn addTarget:self action:@selector(addhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(__kScreenHeight__ >=667){
        
    
    UIButton *yaoqingbtn = [[UIButton alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
    
    yaoqingbtn.backgroundColor = [UIColor clearColor];
        
    
    [head addSubview:yaoqingbtn];
    [yaoqingbtn addTarget:self action:@selector(addhaoyou:) forControlEvents:UIControlEventTouchUpInside];
}else if (__kScreenHeight__ == 736)
{
    UIButton *yaoqingbtn = [[UIButton alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
    
    
     yaoqingbtn.backgroundColor = [UIColor clearColor];
    
    [head addSubview:yaoqingbtn];
    [yaoqingbtn addTarget:self action:@selector(addhaoyou:) forControlEvents:UIControlEventTouchUpInside];
}else{
    UIButton *yaoqingbtn = [[UIButton alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
    
    yaoqingbtn.backgroundColor = [UIColor clearColor];
    
    
    
    [head addSubview:yaoqingbtn];
    [yaoqingbtn addTarget:self action:@selector(addhaoyou:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -##########  常见问题  #########
    if(__kScreenHeight__ == 568)
    {
        UIButton *huodongbtn = [[UIButton alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        huodongbtn.backgroundColor = [UIColor clearColor];
        
        [head addSubview:huodongbtn];
        
        [huodongbtn addTarget:self action:@selector(huodong:) forControlEvents:UIControlEventTouchUpInside];
    }else if(__kScreenHeight__ >=667)
    {
      UIButton *huodongbtn = [[UIButton alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
    huodongbtn.backgroundColor = [UIColor clearColor];
            [head addSubview:huodongbtn];
    
    [huodongbtn addTarget:self action:@selector(huodong:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (__kScreenHeight__ ==736)
    
    {
        UIButton *huodongbtn = [[UIButton alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
        
          huodongbtn.backgroundColor = [UIColor clearColor];
        [head addSubview:huodongbtn];
        
        [huodongbtn addTarget:self action:@selector(huodong:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else{
        UIButton *huodongbtn = [[UIButton alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
        
        huodongbtn.backgroundColor = [UIColor clearColor];
        
        [head addSubview:huodongbtn];
        
        [huodongbtn addTarget:self action:@selector(huodong:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
    
    UIColor *color = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    self.view.backgroundColor = color;
    
    

 
    
   
   
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
    NSString *indexs = [NSString stringWithFormat:@"%ld",index];
    [[NSUserDefaults standardUserDefaults]setObject:indexs forKey:@"dijizhanga"];
    lunboViewController *lunbo1 = [[lunboViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:lunbo1 animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)paomadeng
{
#pragma mark - 跑马登公告
    if(__kScreenHeight__==568)
    {
        UIButton *xiaoxizhong = [[UIButton alloc]initWithFrame:CGRectMake(0,271*__kScreenHeight__/1136 , __kScreenWidth__, 55*__kScreenHeight__/1136)];
        [head addSubview:xiaoxizhong];
        [xiaoxizhong addTarget:self action:@selector(xiaoxi:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(51*__kScreenWidth__/640,287*__kScreenHeight__/1136,589*__kScreenWidth__/640,26*__kScreenWidth__/1136)];
        
        label3.backgroundColor = [UIColor whiteColor];
        //    label1.adjustsFontSizeToFitWidth = YES;//字体大小适应label高度
        label3.font = [UIFont systemFontOfSize:10];
        label3.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"paomaname"];
        [head addSubview:label3];
           }
    else if(__kScreenHeight__ >=667)
    {
        UIButton *xiaoxizhong = [[UIButton alloc]initWithFrame:CGRectMake(0,318*__kScreenHeight__/1334 , __kScreenWidth__, 63*__kScreenHeight__/1334)];
        [head addSubview:xiaoxizhong];
        [xiaoxizhong addTarget:self action:@selector(xiaoxi:) forControlEvents:UIControlEventTouchUpInside];
        
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(33,(__kScreenHeight__*317/1334), __kScreenWidth__*3,__kScreenHeight__*63/1334)];
    label3.backgroundColor = [UIColor whiteColor];
    //    label1.adjustsFontSizeToFitWidth = YES;//字体大小适应label高度
    label3.font = [UIFont systemFontOfSize:12];
    label3.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"paomaname"];

    [head addSubview:label3];
    }
    else if (__kScreenHeight__==736)
    {
        UIButton *xiaoxizhong = [[UIButton alloc]initWithFrame:CGRectMake(0,318*__kScreenHeight__/1334 , __kScreenWidth__, 63*__kScreenHeight__/1334)];
        [head addSubview:xiaoxizhong];
        [xiaoxizhong addTarget:self action:@selector(xiaoxi:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(33,(__kScreenHeight__*317/1334), __kScreenWidth__*3,__kScreenHeight__*63/1334)];
        label3.backgroundColor = [UIColor whiteColor];
        //    label1.adjustsFontSizeToFitWidth = YES;//字体大小适应label高度
        label3.font = [UIFont systemFontOfSize:12];
        label3.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"paomaname"];
        
        [head addSubview:label3];
    }else{
        UIButton *xiaoxizhong = [[UIButton alloc]initWithFrame:CGRectMake(0,271*__kScreenHeight__/1136 , __kScreenWidth__, 55*__kScreenHeight__/1136)];
        [head addSubview:xiaoxizhong];
        [xiaoxizhong addTarget:self action:@selector(xiaoxi:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(51*__kScreenWidth__/640,287*__kScreenHeight__/1136,589*__kScreenWidth__/640,26*__kScreenWidth__/1136)];
        
        label3.backgroundColor = [UIColor whiteColor];
        //    label1.adjustsFontSizeToFitWidth = YES;//字体大小适应label高度
        label3.font = [UIFont systemFontOfSize:10];
        label3.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"paomaname"];
        [head addSubview:label3];
 
    }
    
   #pragma mark -铃铛图标
    
    if (__kScreenHeight__==568) {
        UIImage *im = [UIImage imageNamed:@"bellIcon@2x.png"];
        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/640,287*__kScreenHeight__/1136,16*__kScreenWidth__/640,17*__kScreenHeight__/1136)];
        
        imge.backgroundColor = [UIColor whiteColor];
        
        [imge setImage:im];
        [head addSubview:imge];
    }
    else if (__kScreenHeight__>= 667)
    {
        UIImage *im = [UIImage imageNamed:@"bellIcon@2x.png"];
        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(13,(__kScreenHeight__*317/1334)+9, 12, 12)];
        imge.backgroundColor = [UIColor whiteColor];
        
        [imge setImage:im];
        [head addSubview:imge];
        
    }
    else if(__kScreenHeight__ == 736)
    {
        UIImage *im = [UIImage imageNamed:@"6homePage@3x_06.png"];
        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(13,(__kScreenHeight__*317/1334)+9, 12, 12)];
        imge.backgroundColor = [UIColor whiteColor];
        
        [imge setImage:im];
        [head addSubview:imge];
    }else{
        UIImage *im = [UIImage imageNamed:@"bellIcon@2x.png"];
        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/640,287*__kScreenHeight__/1136,16*__kScreenWidth__/640,17*__kScreenHeight__/1136)];
        
        imge.backgroundColor = [UIColor whiteColor];
        
        [imge setImage:im];
        [head addSubview:imge];

    }
    
    
}


-(void)token1
{
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];

    NSString *udid = [UIDevice currentDevice].model ;
    NSLog(@"************唯一标识符%@",uuid);

  NSDate *localDate = [NSDate date]; //获取当前时间
//    
//    NSLog(@"当前时间%@",localDate);
 NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
//   
//    NSString *timeSp =[self changeDateToDateString:localDate];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
////
//    NSDate *date = [NSDate date];
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    
//    NSLog(@"%@", localeDate);
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];  //转化为UNIX时间戳
//    
//    
    
    
    
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    _session = sb;
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
  
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    

    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    
     //CFBundleVersion = "1.0.3";
    NSLog(@"plist文件夹：%@",infoDic);
    //NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];

    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"当前版本号：%@",currentVersion);
    [manager POST:@"http://debug.otouzi.com:8012/device/register"
    
       parameters:@{@"device_type": @"ios",
                    @"device_unique":uuid,
                    @"device_model": udid,
                    @"system_version": currentVersion,
                    @"request_timestamp": timeSp,
                    @"app_session_token":_session,
                    @"api_version":@"2"}
     
          success:^(AFHTTPRequestOperation * operation, id  responseObject) {
              
              
              NSLog(@"请求当前token：%@",responseObject);
              
              
              NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
              
              objc = responseObject;
              
              [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
              
              [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
              
              [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
              

              
              [[NSUserDefaults standardUserDefaults] synchronize];
          } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
              
              NSLog(@"输出错误%@",error);
              
          }];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"kaishiba" object:self];
   [self performSelector:@selector(shouye) withObject:nil afterDelay:0.5];
    
}

-(void)shouye

{
    
   [self performSelector:@selector(requestUserInformationData) withObject:nil afterDelay:0.5];

    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"token%@",sta);
    if (sta == nil) {
        
        UIImageView *iwi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__,347*__kScreenHeight__/1334 )];
        [iwi setImage:[UIImage imageNamed:@"6hPBannerLoding@2x.png"]];
        [head addSubview:iwi];
        
    }else{
        
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    
    
    //    [manager.requestSerializer setValue:@"true" forHTTPHeaderField:@"Debug"];
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
//    [manager.requestSerializer setValue:@"true" forHTTPHeaderField:@"Debug"];
    [manager.requestSerializer setValue:_session forHTTPHeaderField:@"Application-Session"];
    
    [manager GET:@"http://debug.otouzi.com:8012/index"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSDictionary *shouye = [[NSDictionary alloc] init];
             
             
             shouye = responseObject;
             NSString *panan = [shouye objectForKey:@"code"];
             int add = [panan intValue];
             if (add != 200) {
                 [self token1];
             }else{
             
             NSDictionary *shouyewangzhi = [[NSDictionary alloc]init];
             
             NSDictionary *datadic = [shouye objectForKey:@"data"];
//##################    遍历首页轮播数组   ###############
                 
             NSArray *bannerarr =[datadic objectForKey:@"banner"];
                 NSInteger bannercout = bannerarr.count;
                 NSMutableArray *url = [[NSMutableArray alloc]init];
                 NSMutableArray *dianji = [[NSMutableArray alloc]init];
                 for(int i=0;i<bannercout;i++)
              {
  
                  [url addObject:bannerarr[i][@"thumb"]];
                  [dianji addObject:bannerarr[i][@"href"]];
              }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:url forKey:@"banner"];
                 [[NSUserDefaults standardUserDefaults]setObject:dianji forKey:@"bannerwangzhi"];
                 
             shouyewangzhi = [bannerarr lastObject];

            
             
             NSDictionary *notisc = [datadic objectForKey:@"notice"];
             NSString *name1 = [notisc objectForKey:@"name"];
             NSString *xiangurl = [notisc objectForKey:@"href"];
             [[NSUserDefaults standardUserDefaults]setObject:xiangurl forKey:@"ggxqurl"];
             [[NSUserDefaults standardUserDefaults]setObject:name1 forKey:@"paomaname"];
             
             
             
             
             
             NSDictionary *shouyeshuju = [shouye objectForKey:@"data"];
             [[NSUserDefaults standardUserDefaults]setObject:shouyeshuju[@"statistics"][@"investment"]forKey:@"aixin"];
             
             NSDictionary *shouyelingyigeshuju = [shouye objectForKey:@"data"];
             [[NSUserDefaults standardUserDefaults]setObject:shouyelingyigeshuju[@"statistics"][@"user_count"]forKey:@"yonghu"];
             
            
            
             
             
             NSArray *menus = [datadic objectForKey:@"menu"];
             
             NSLog(@"%@",menus[3][@"name"]);
             
             //###########    打开的url   ############
             [[NSUserDefaults standardUserDefaults]setObject:menus[0][@"href"] forKey:@"xinshouurl"];
             
             [[NSUserDefaults standardUserDefaults]setObject:menus[1][@"href"] forKey:@"zhucelibao"];
             
             [[NSUserDefaults standardUserDefaults]setObject:menus[2][@"href"] forKey:@"anquanba"];
             
             [[NSUserDefaults standardUserDefaults]setObject:menus[4][@"href"] forKey:@"adda"];
             
             
             //##############   new 标  ###############

             [[NSUserDefaults standardUserDefaults]setObject:menus[0][@"ios"][@"x2"][@"thumb"] forKey:@"xinshoubiao1"];

             [[NSUserDefaults standardUserDefaults]setObject:menus[0][@"ios"][@"x3"][@"thumb"] forKey:@"xinshoubiao2"];
                
                     
                 
                 if (__kScreenHeight__ == 568) {
                    xinshou  = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*21/640, 553*__kScreenHeight__/1136, 198*__kScreenWidth__/640,186*__kScreenHeight__/1136 )];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"xinshoubiao1"];
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [xinshou setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                      [head addSubview:xinshou];
                 }else if (__kScreenHeight__ >= 667)
                 {
                      xinshou  = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750, (24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), 234*__kScreenWidth__/750,219*__kScreenHeight__/1334 )];

                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"xinshoubiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [xinshou setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:xinshou];

                     
                 }else if (__kScreenHeight__ == 736)
                 {
                     xinshou  = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750, (24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334), 234*__kScreenWidth__/750,219*__kScreenHeight__/1334 )];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"xinshoubiao2"];
                    
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [xinshou setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:xinshou];
                 }
                 
                 else{
                     xinshou  = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*21/640, 553*__kScreenHeight__/1136, 198*__kScreenWidth__/640,186*__kScreenHeight__/1136 )];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"xinshoubiao1"];
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [xinshou setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:xinshou];

                 }
                 [[NSUserDefaults standardUserDefaults]setObject:menus[1][@"ios"][@"x2"][@"thumb"] forKey:@"zhucebiao1"];
                 [[NSUserDefaults standardUserDefaults]setObject:menus[1][@"ios"][@"x3"][@"thumb"] forKey:@"zhucebiao2"];
                 
             
                     
               
                 if (__kScreenHeight__ == 568) {
                     
                    zhuce = [[UIImageView alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhucebiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [zhuce setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:zhuce];

                     
                 }else if (__kScreenHeight__ >=667)
                 {
                     zhuce = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhucebiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [zhuce setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:zhuce];
                 }else if (__kScreenHeight__ == 736)
                 {
                    zhuce = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhucebiao2"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [zhuce setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:zhuce];

                 }
                 else{
                     
                     zhuce = [[UIImageView alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhucebiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [zhuce setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:zhuce];
                     

                 }
             
                 [[NSUserDefaults standardUserDefaults]setObject:menus[2][@"ios"][@"x2"][@"thumb"] forKey:@"anquanbiao1"];
             
                 [[NSUserDefaults standardUserDefaults]setObject:menus[2][@"ios"][@"x3"][@"thumb"] forKey:@"anquanbiao2"];
           
                     
               
                 if (__kScreenHeight__ == 568) {
                     anquam = [[UIImageView alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"anquanbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [anquam setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:anquam];

                     
                 }else if (__kScreenHeight__ >= 667)
                 {
                    anquam = [[UIImageView alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];

                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"anquanbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [anquam setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:anquam];

                     
                 }else if (__kScreenHeight__ == 736)
                 {
                     anquam = [[UIImageView alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"anquanbiao2"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [anquam setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:anquam];

                 }
                 else{
                     anquam = [[UIImageView alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,553*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"anquanbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [anquam setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     [head addSubview:anquam];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:menus[3][@"ios"][@"x2"][@"thumb"] forKey:@"gonggaobiao1"];
             
                 [[NSUserDefaults standardUserDefaults]setObject:menus[3][@"ios"][@"x3"][@"thumb"] forKey:@"gonggaobiao2"];
                 
              
                     
                 
                 if (__kScreenHeight__ == 568) {
                     gonggao = [[UIImageView alloc]initWithFrame:CGRectMake(21*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"gonggaobiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [gonggao setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:gonggao];

                 }else if (__kScreenHeight__ >=667)
                 {
                     gonggao = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750,(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"gonggaobiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [gonggao setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:gonggao];

                 }else if (__kScreenHeight__ == 736)
                 {
                     gonggao = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*24/750,(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];

                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"gonggaobiao2"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [gonggao setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:gonggao];

                 }
                 else{
                     gonggao = [[UIImageView alloc]initWithFrame:CGRectMake(21*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"gonggaobiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [gonggao setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     [head addSubview:gonggao];

                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:menus[4][@"ios"][@"x2"][@"thumb"] forKey:@"addbiao1"];
                 [[NSUserDefaults standardUserDefaults]setObject:menus[4][@"contacts_invitation"] forKey:@"guizewangzhi"];
                 [[NSUserDefaults standardUserDefaults]setObject:menus[4][@"ios"][@"x3"][@"thumb"] forKey:@"addbiao2"];
                 
       
                     
                 
                 if (__kScreenHeight__ == 568) {
                     yaoqing = [[UIImageView alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"addbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [yaoqing setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     
                     [head addSubview:yaoqing];
                     
                 }else if (__kScreenHeight__ >=667)
                 {
                     yaoqing = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];

                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"addbiao1"];
                     NSLog(@"%@",tou);
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [yaoqing setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     
                     [head addSubview:yaoqing];

                     
                 }else if (__kScreenHeight__ == 736)
                 {
                     yaoqing = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"addbiao2"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [yaoqing setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     
                     [head addSubview:yaoqing];
                 }
                 else{
                     yaoqing = [[UIImageView alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"addbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [yaoqing setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     
                     [head addSubview:yaoqing];

                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:menus[5][@"ios"][@"x2"][@"thumb"] forKey:@"huodongbiao1"];
             
                 [[NSUserDefaults standardUserDefaults]setObject:menus[5][@"ios"][@"x3"][@"thumb"] forKey:@"huodongbiao2"];
                 
         
                     
                 
                 if (__kScreenHeight__ == 568) {
                     huodong = [[UIImageView alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"huodongbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [huodong setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     

                     [head addSubview:huodong];
                     

                     
                 }else if (__kScreenHeight__>= 667)
                 {
                     huodong = [[UIImageView alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"huodongbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [huodong setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     [head addSubview:huodong];
                     
                 }else if (__kScreenHeight__ == 736)
                 {
                     huodong = [[UIImageView alloc]initWithFrame:CGRectMake(((__kScreenWidth__*24/750)+(234*__kScreenWidth__/750))+(234*__kScreenWidth__/750),(24*__kScreenHeight__/1334)+(__kScreenHeight__*243/1334)+(__kScreenHeight__*63/1334)+(__kScreenHeight__*317/1334)+(219*__kScreenHeight__/1334),234*__kScreenWidth__/750,219*__kScreenHeight__/1334)];
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"huodongbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [huodong setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     [head addSubview:huodong];

                 }
                 else{
                     huodong = [[UIImageView alloc]initWithFrame:CGRectMake(418*__kScreenWidth__/640,739*__kScreenHeight__/1136,198*__kScreenWidth__/640,186*__kScreenHeight__/1136)];
                     
                     
                     NSString *tou =[[NSUserDefaults standardUserDefaults]objectForKey:@"huodongbiao1"];
                     
                     NSURL *url1 = [NSURL URLWithString:tou];
                     [huodong setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                     
                     
                     [head addSubview:huodong];

                 }
            
             
             }
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
    [self performSelector:@selector(lunbotu) withObject:nil afterDelay:0.5];
    [self paomadeng];
}
}

-(void)lunbotu
{
    
#pragma mark - 采用网络图片实现

    
    NSArray *url1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"banner"];
    
    [NSThread sleepForTimeInterval:0.5f];
    
    NSArray *imagesURLStrings = url1;
    
    
    //图片配文字
    //    NSArray *titles = @[@"",
    //                        @"",
    //                        @"",
    //                        @""
    //                        ];
    
    
    
    
    
    
#pragma mark -网络加载的图片轮播器
    
    if (__kScreenHeight__ == 568) {
        
    
    cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,__kScreenWidth__,__kScreenHeight__*271/1136) imageURLStringsGroup:nil];// 模拟网络延时情景
    
    
    
    
    cycleScrollView2.delegate = self;
    //    cycleScrollView2.titlesGroup = titles;//图片加入文字
    
    
    
    cycleScrollView2.dotColor = [UIColor whiteColor];// 自定义分页控件小圆标颜色
    
    
    
    cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;//分页控件位置
    
    
    cycleScrollView2.autoScrollTimeInterval = 3.0;//轮换时间
    
    
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"6hPBannerLoding@2x.png"];
        
    [head addSubview:cycleScrollView2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
        

    }else if (__kScreenHeight__ >= 667)
    {
        cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,__kScreenWidth__,__kScreenHeight__*317/1334) imageURLStringsGroup:nil];// 模拟网络延时情景
        
        
        
        
        cycleScrollView2.delegate = self;
        //    cycleScrollView2.titlesGroup = titles;//图片加入文字
        
        
        
        cycleScrollView2.dotColor = [UIColor whiteColor];// 自定义分页控件小圆标颜色
        
        
        
        cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;//分页控件位置
        
        
        cycleScrollView2.autoScrollTimeInterval = 3.0;//轮换时间
        
        
        cycleScrollView2.placeholderImage = [UIImage imageNamed:@"6hPBannerLoding@2x.png"];
        [head addSubview:cycleScrollView2];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
        

    }else if (__kScreenHeight__ == 736)
    {
        cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,__kScreenWidth__,__kScreenHeight__*317/1334) imageURLStringsGroup:nil];// 模拟网络延时情景
        
        
        
        
        cycleScrollView2.delegate = self;
        //    cycleScrollView2.titlesGroup = titles;//图片加入文字
        
        
        
        cycleScrollView2.dotColor = [UIColor whiteColor];// 自定义分页控件小圆标颜色
        
        
        
        cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;//分页控件位置
        
        
        cycleScrollView2.autoScrollTimeInterval = 3.0;//轮换时间
        
        
        cycleScrollView2.placeholderImage = [UIImage imageNamed:@"6hPBannerLoding@2x.png"];
        [head addSubview:cycleScrollView2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
    }
    else{
        cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,__kScreenWidth__,__kScreenHeight__*271/1136) imageURLStringsGroup:nil];// 模拟网络延时情景
        
        
        
        
        cycleScrollView2.delegate = self;
        //    cycleScrollView2.titlesGroup = titles;//图片加入文字
        
        
        
        cycleScrollView2.dotColor = [UIColor whiteColor];// 自定义分页控件小圆标颜色
        
        
        
        cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;//分页控件位置
        
        
        cycleScrollView2.autoScrollTimeInterval = 3.0;//轮换时间
        
        
        cycleScrollView2.placeholderImage = [UIImage imageNamed:@"6hPBannerLoding@2x.png"];
        
        [head addSubview:cycleScrollView2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
        

    }
    
    
    //  模拟加载延迟
    
    
    
    
    
    // 清除缓存
    //    [cycleScrollView2 clearCache];
    if (__kScreenHeight__==568) {
        
    
    NSString *guduzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"yonghu"];
    NSString *zhuzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"aixin"];
        if (!label1) {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 397*__kScreenHeight__/1136, __kScreenWidth__*0.5, 26*__kScreenHeight__/1136)];
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5,397*__kScreenHeight__/1136, __kScreenWidth__*0.5, 26*__kScreenHeight__/1136)];
            [head addSubview:label1];
            [head addSubview:label2];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            
            label2.font = [UIFont systemFontOfSize:14];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont systemFontOfSize:14];
            label2.textAlignment = NSTextAlignmentCenter;
            

        }
    
    label1.text = guduzi;
    label2.text = zhuzi;

        }
    else if (__kScreenHeight__>=667)
    {
        NSString *guduzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"yonghu"];
        NSString *zhuzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"aixin"];
        if (!label1) {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 461*__kScreenHeight__/1334, __kScreenWidth__*0.5, 38*__kScreenHeight__/1334)];
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5, 461*__kScreenHeight__/1334, __kScreenWidth__*0.5, 38*__kScreenHeight__/1334)];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            
            label2.font = [UIFont systemFontOfSize:20];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont systemFontOfSize:20];
            label2.textAlignment = NSTextAlignmentCenter;
            [head addSubview:label1];
            [head addSubview:label2];

        }
        
        label1.text = guduzi;
        label2.text = zhuzi;
    }else if(__kScreenHeight__ == 736)
    {
        NSString *guduzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"yonghu"];
        NSString *zhuzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"aixin"];
        if (!label1) {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 461*__kScreenHeight__/1334, __kScreenWidth__*0.5, 30*__kScreenHeight__/1334)];
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5, 461*__kScreenHeight__/1334, __kScreenWidth__*0.5, 30*__kScreenHeight__/1334)];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            
            label2.font = [UIFont systemFontOfSize:20];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont systemFontOfSize:20];
            label2.textAlignment = NSTextAlignmentCenter;
            [head addSubview:label1];
            [head addSubview:label2];
            
        }
        
        label1.text = guduzi;
        label2.text = zhuzi;
        
    }
    else{
        
        NSString *guduzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"yonghu"];
        NSString *zhuzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"aixin"];
        if (!label1) {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 397*__kScreenHeight__/1136, __kScreenWidth__*0.5, 26*__kScreenHeight__/1136)];
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5,397*__kScreenHeight__/1136, __kScreenWidth__*0.5, 26*__kScreenHeight__/1136)];
            [head addSubview:label1];
            [head addSubview:label2];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            
            label2.font = [UIFont systemFontOfSize:14];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont systemFontOfSize:14];
            label2.textAlignment = NSTextAlignmentCenter;
            
            
        }
        
        label1.text = guduzi;
        label2.text = zhuzi;
        

    }

    if (count == 1) {
        [self performSelector:@selector(requestUpdataInfo) withObject:nil afterDelay:0.5];
        
    }
}


-(void)shengchengzifu
{
    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    BOOL notFirst = [[notFirstDic objectForKey:@"notFirst"] boolValue];
    
    
  
    if (notFirst == YES) {
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        _session = sb;
        
        NSLog(@"@@@@@@@@@@%@",_session);
        

        
    } else {
        
        NSString *string = [[NSString alloc]init];
        for (int i = 0; i < 32; i++) {
            int number = arc4random() % 36;
            if (number < 10) {
                int figure = arc4random() % 10;
                NSString *tempString = [NSString stringWithFormat:@"%d", figure];
                string = [string stringByAppendingString:tempString];
            }else {
                int figure = (arc4random() % 26) + 97;
                char character = figure;
                NSString *tempString = [NSString stringWithFormat:@"%c", character];
                string = [string stringByAppendingString:tempString];
            }
        }
        
        NSLog(@"%@",string);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@YES forKey:@"notFirst"];
        
        [dic setObject:string forKey:@"sb"];
        
        [dic writeToFile:path atomically:YES];
        
        
    }
    
    
    NSString *tokensb = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (tokensb == nil) {
        
        [self performSelector:@selector(token1) withObject:nil afterDelay:0.5];
    }
    else {
         [self performSelector:@selector(shouye) withObject:nil afterDelay:0.5];
    }
    
    
}

-(void)delayMethod
{
    self.tabBarController.tabBar.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)gonggao:(id)sender
{
    HomePageNoticeController *gonggao = [[HomePageNoticeController alloc]init];
    gonggao.urlStr = _notice_url;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:gonggao animated:NO completion:nil];
}

-(void)huodong:(id)sender
{
    CommonProblemsViewController *actionCenterViewController = [[CommonProblemsViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:actionCenterViewController animated:NO completion:nil];
}

-(void)xinshoutiuao:(id)sender
{
    xinshouViewController *xinshoude = [[xinshouViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:xinshoude animated:NO completion:nil];
}
-(void)zclb:(id)sender
{
    zhucelibaoViewController *zclbde = [[zhucelibaoViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:zclbde animated:NO completion:nil];
}


-(void)aq1:(id)sender
{
    anquanViewController *anqun2 = [[anquanViewController alloc]init];
 
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:anqun2 animated:NO completion:nil];
    
    
}
-(void)addhaoyou:(id)sender
{
//    NSString *banduan4=  [[NSUserDefaults standardUserDefaults] objectForKey:@"haimeidenglune"];
//    int panduan4 = [banduan4 intValue];
//    NSString *banduan3=  [[NSUserDefaults standardUserDefaults] objectForKey:@"zhijietiao"];
//    int panduan3 = [banduan3 intValue];
//    
//    
//    if (panduan3 == 89) {
//        int a = [[[NSUserDefaults standardUserDefaults]objectForKey:@"wuyaoqing"] intValue];
//        NSLog(@"%d",a);
//        if (a == 0) {
//            jihouyaoqingViewController *jihou = [[jihouyaoqingViewController alloc]init];
//            
//            CATransition *animation = [CATransition animation];
//            animation.duration = 0.5;
//            animation.timingFunction = UIViewAnimationCurveEaseInOut;
//            animation.type = @"pageCurl";
//            animation.type = kCATransitionPush;
//            animation.subtype = kCATransitionFromRight;
//            [self.view.window.layer addAnimation:animation forKey:nil];
//            [self presentViewController:jihou animated:NO completion:nil];
//            
////        }else{
//            yaoqinghaoyouViewController *yaoqing = [[yaoqinghaoyouViewController alloc]init];
//            
//            CATransition *animation = [CATransition animation];
//            animation.duration = 0.5;
//            animation.timingFunction = UIViewAnimationCurveEaseInOut;
//            animation.type = @"pageCurl";
//            animation.type = kCATransitionPush;
//            animation.subtype = kCATransitionFromRight;
//            [self.view.window.layer addAnimation:animation forKey:nil];
//            [self presentViewController:yaoqing animated:NO completion:nil];
////        }
    
//    }else if (panduan4 == 90) {
//        AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//        TabbarViewController *tab = [[TabbarViewController alloc]init];
//        delete.window.rootViewController = tab;
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
//    }
//
    
    RiskGuaranteeViewController *add1 = [[RiskGuaranteeViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:add1 animated:NO completion:nil];
    
    
}


//#pragma mark - 请求检查更新信息
//- (void)requestUpdataInfo1{
//    NSString *version = [[NSUserDefaults standardUserDefaults]objectForKey:@"system_version"];
//    NSMutableDictionary *parammeters =
//    [[NSMutableDictionary alloc]initWithDictionary:
//     @{        @"platform": @"ios",
//               @"version": version,
//               
//               }];
//    
//    [DataService requestWithURL:@"/device/upgrade"
//                         params:parammeters httpMethod:@"post"
//                completionBlock:^(id result) {
//        NSLog(@"＃＃＃＃＃＃＃＃ 升级更新%@",result);
//        
//        NSDictionary * responseDic = result;
//        
//        
//        NSDictionary *dataDic = [responseDic objectForKey:@"data"];
//        BOOL upgrade = [responseDic objectForKey:@"upgrade"];
//        NSDictionary *currentDic = [responseDic objectForKey:@"current"];
//   
//        if (upgrade == 1) {
//         
//        NSDictionary *newDic = [dataDic objectForKey:@"new"];
//            _newVesion = [newDic objectForKey:@"version"];
//            
//            [[NSUserDefaults standardUserDefaults]setObject:_newVesion forKey:@"new"];
//            
//
//              NSLog(@"新版本%@",newDic);
//            SingleObject *sing = [SingleObject sharedObject];
//            
//            
//            sing.version = [newDic objectForKey:@"version"];
//            NSLog(@"新版本%@",sing.version );
//            sing.size = [newDic objectForKey:@"size"];
//            NSLog(@"新版本%@",sing.size);
//            sing.descriptions = [newDic objectForKey:@"description"];
//            NSLog(@"新版本%@",sing.descriptions);
//            [sing showView];
//
//        }
//   
//        
//        
//        
//    }];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        
//        
//    });
//    
//}
-(void)xiaoxi:(id)sender
{
    ggxqViewController *gonggao = [[ggxqViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:gonggao animated:NO completion:nil];

}


#pragma mark - 请求检查更新信息
- (void)requestUpdataInfo{
    
    
      count ++;
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
   // NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"当前版本号：%@",currentVersion);

    NSMutableDictionary *parammeters =
    [[NSMutableDictionary alloc]initWithDictionary:
     @{        @"platform": @"ios",
               @"version": currentVersion,
               
               }];
    [DataService requestWithURL:@"/device/upgrade"
                         params:parammeters
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    NSLog(@"＃＃＃＃＃＃＃＃ 升级更新%@",result);
                    
                    NSDictionary * responseDic = result;
                    NSString *codeValue =[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"code"]];
                    
                    if ([codeValue isEqualToString:@"200"]) {
                        
                        
                        
                        NSDictionary *dataDic = [responseDic objectForKey:@"data"];
                        //BOOL upgrade = [responseDic objectForKey:@"upgrade"];
                        // NSDictionary *currentDic = [responseDic objectForKey:@"current"];
                        
                        
                        
                        if ([[dataDic objectForKey:@"new"]isKindOfClass:[NSDictionary class]]) {
                            
                            
                            NSDictionary *newDic = [dataDic objectForKey:@"new"];
                            _newVesion = [newDic objectForKey:@"version"];
                            
                            [[NSUserDefaults standardUserDefaults]setObject:_newVesion forKey:@"new"];
                            
                            
                            NSLog(@"新版本%@",newDic);
                            [self showView];
                            
                            NSString * versionStr= [newDic objectForKey:@"version"];
                            _versionNumberLabel.text = [NSString stringWithFormat:@"版本号:%@",versionStr];
                            
                            
                            NSString *mbStr = [newDic objectForKey:@"size"];
                            _mbLabel.text = [NSString stringWithFormat:@"大小:%@",mbStr];
                            
                            _updataContent.text = [newDic objectForKey:@"description"];
                            

                            //_updataContent.text = @"1.新手福利打升级，注册立即送百元礼包和抽奖机会，100％中奖\n2.注册投资流程升级简化，一键投资，轻松或收益\n3.邀请好友齐获利，新增邀请原生功能，现金奖励上不封顶";
                            _updataContent.numberOfLines = 0;
                            _updataContent.font = [UIFont systemFontOfSize:24/2];
                            
                            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:_updataContent.text];
                            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                            [paragraphStyle setLineSpacing:32/3];
                            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_updataContent.text length])];
                            [_updataContent setAttributedText:attributedString];
                            [_updataContent sizeToFit];
               
                            _updataContent.frame = CGRectMake(48*kWidthScale, (82+16+24+28+24+28+24+20)*kHeightScale, _updataView.width- 48*kWidthScale*2, _updataContent.frame.size.height);
                            
                            
                            _sureButton.frame = CGRectMake((80+43)*kPlusScale+(_updataView.width-(80+80+43)*kPlusScale)/2,_updataContent.height+_updataContent.origin.y+60*kPlusHeightScale, (_updataView.width-(80+80+43)*kPlusScale)/2, 108*kPlusHeightScale);
                            _cancleButton.frame = CGRectMake(80*kPlusScale, _updataContent.height+_updataContent.origin.y+60*kPlusHeightScale, (_updataView.width-(80+80+43)*kPlusScale)/2 ,108*kPlusHeightScale);
                        
                            
                            
                            _updataView.frame = CGRectMake(199*kPlusScale, kNavigationBarHeight+260*kPlusHeightScale, kScreenWidth - (199+199)*kPlusScale, _updataContent.height+_updataContent.origin.y+60*kPlusHeightScale+60*kPlusHeightScale+108*kPlusHeightScale);
                            
                          
                            
                            
                            NSString *versionUpdataStr = [NSString stringWithFormat:@"沃投资%@全新上线",[newDic objectForKey:@"version"]];//@"V2.2.1全新上线";
                            _versionUpdataLabel.text = versionUpdataStr ;
                        }else{
                            
                            NSLog(@"没有新版本");
                            
                        }
                        
                        
                        
                    }else{
                        
                        
                        
                        
                        NSString *response = [responseDic objectForKey:@"data"];

                        
                        NSLog(@"%@",response);

                    }
                    
                    
                    
                    
                }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
    });
     [self performSelector:@selector(zhongxin12) withObject:nil afterDelay:0.5];
}
- (void)showView{
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    
    _updataView = [[UIView alloc]init];
    _updataView.frame = CGRectMake(199*kPlusScale, kNavigationBarHeight+260*kPlusHeightScale, kScreenWidth - (199+199)*kPlusScale, 1138*kPlusHeightScale);
    
    _updataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_updataView];
    
    //红色分割线
    //画线
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [_updataView  addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 211.0/255.0, 74.0/255.0, 89.0/255.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 80*kPlusScale,136*kPlusHeightScale );  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),_updataView.width -80*kPlusScale,136*kPlusHeightScale  );   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //视图标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(48*kWidthScale, 34*kHeightScale, kScreenWidth-48*2*kWidthScale, 30*kHeightScale);
    titleLabel.font = [UIFont systemFontOfSize:30/2];
    titleLabel.text = @"发现新版本";
    
    [_updataView addSubview:titleLabel];
    
    //版本号
    
    _versionNumberLabel = [[UILabel alloc]init];
    _versionNumberLabel.frame = CGRectMake(48*kWidthScale, (82+16)*kHeightScale,180*kWidthScale,24*kHeightScale);
    _versionNumberLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_updataView addSubview: _versionNumberLabel];
    
    
    //占内存大小
    _mbLabel = [[UILabel alloc]init];
    _mbLabel.frame = CGRectMake(_updataView.width-48*kWidthScale-135*kWidthScale,(82+16)*kHeightScale,135*kWidthScale, 24*kHeightScale);
    
    _mbLabel.font = [UIFont systemFontOfSize:24/2];
    //_mbLabel.layer.borderWidth = 1;
    [_updataView addSubview:_mbLabel];
    
    //更新内容标题
    
    UILabel *updataTextLabel = [[UILabel alloc]init];
    updataTextLabel.frame = CGRectMake(48*kWidthScale, (82+16+24+28)*kHeightScale, 150*kWidthScale, 24*kHeightScale);
    updataTextLabel.text = @"·更新内容";
    updataTextLabel.font = [UIFont systemFontOfSize:24/2];
    //updataTextLabel.layer.borderWidth = 1;
    
    [_updataView addSubview:updataTextLabel];
    
    
    //沃投资V2.2.1全新上线标题
    _versionUpdataLabel = [[UILabel alloc]init];
    _versionUpdataLabel.frame = CGRectMake(48*kWidthScale, (82+16+24+28+24+28)*kHeightScale, _updataView.width-48*2*kWidthScale, 24*kHeightScale);
    
    _versionUpdataLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_updataView addSubview:_versionUpdataLabel];
    
    
    //更新具体内容 －－服务器传回
    _updataContent = [[UILabel alloc]init];
    _updataContent.frame = CGRectMake(48*kWidthScale, (82+16+24+28+24+28+24+20)*kHeightScale, _updataView.width- 48*kWidthScale*2 , 547*kPlusHeightScale);
   
    //_updataContent.layer.borderWidth = 1;
    UIColor *contentColor = RGB(109, 109, 109, 1);
    //[self.view addSubview:cLabel];
    _updataContent.textColor = contentColor;
    
    [_updataView addSubview:_updataContent];
    
    //
    //忽略按钮
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
  
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    _cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = RGB(180, 180, 180, 1);
    [_cancleButton setBackgroundColor:cancleColor];
    _cancleButton.layer.cornerRadius = 3;
    [_cancleButton setTitle:@"忽略" forState:UIControlStateNormal];
    
    [_cancleButton addTarget:self
                     action:@selector(cancelUpdataAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_updataView addSubview:_cancleButton];
    
    //去更新按钮
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [_sureButton setTitle:@"更新" forState:UIControlStateNormal];
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    _sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = RGB(211, 74, 89, 1);
    _sureButton.layer.cornerRadius = 3;
    [_sureButton setBackgroundColor:sureColor];
    [_sureButton addTarget:self
                   action:@selector(sureUpdataAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [_updataView addSubview:_sureButton];
 
  
    
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    //在某个子视图上面插入一个视图
    //[self insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
    
    //在某个子视图下面插入一个视图
    
    
    [self.view insertSubview:_maskView belowSubview:_updataView];
    // [_lastWindow insertSubview:_maskView belowSubview:_updataView];
    //根据下标插入
    //[self insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>];
    

    
}

#pragma mark - 检查更新视图点击事件
//忽略更新
- (void)cancelUpdataAction:(UIButton*)sender{
    _updataView.hidden = YES;
    _maskView.hidden = YES;
    
    
}
#pragma mark -提供链接到appstore更新
- (void)sureUpdataAction:(UIButton *)sender{
    _maskView.hidden = YES;
    _updataView.hidden = YES;
    
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1099021145"]];
    
}

#pragma mark - 遮盖视图

- (void)maskViewAction:(UIControl *)sender{
    
    
    _maskView.hidden = YES;
    _updataView.hidden = YES;
    
    NSLog(@"隐藏视图点击事件");
    
}
-(void)zhongxin12
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
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    
    [manager GET:@"http://debug.otouzi.com:8012/user/center"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             
             
             
           
             
//             //############  实名认证  ############
//             
//             
//             
//             NSDictionary *huifuzhuangtai = [gerenzhongxin objectForKey:@"data"];
//             NSDictionary *huifuzhuangtai1= [huifuzhuangtai objectForKey:@"chinapnr"];
//             NSString *zhuangtai = [huifuzhuangtai1 objectForKey:@"open_account"];
//             
//             [[NSUserDefaults standardUserDefaults]setObject:zhuangtai forKey:@"huifuzhuangtai"];
             
             
             
             

             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
    
    
}
-(void)uais:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
}


- (void)requestUserInformationData{
    [DataService requestWithURL:@"/v2/user/information"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    NSDictionary *responceDic = result;
                    NSLog(@"----------userInformation----:%@",result);
                    NSNumber *code = [responceDic objectForKey:@"code"];
                    if ([code isEqualToNumber:@200]) {
                        
                        NSDictionary *data = [responceDic objectForKey:@"data"];
                        
                        NSDate* currentDate = [NSDate date];
                        NSLog(@"当前时间：%@",currentDate);
                        
                        
                        _notice_url = [data objectForKey:@"notice_url"];
                        
                        noticeState = [[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBool"]boolValue];
                        activitystate =[[[NSUserDefaults standardUserDefaults] objectForKey: @"clickActionBool"]boolValue];
                        
                        
                        _activityValue= [data objectForKey:@"activity"];//@"22";
                        _noticeValue = [data objectForKey:@"notice"];//@"20";//
                        
                        _lastActivitySandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastActivityTime"];
                        _lastNoticeSandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastNoticeTime"];
                        
                        NSLog(@"%@-----%@",_lastNoticeSandbox,_lastActivitySandbox);
                        if (![_lastNoticeSandbox isKindOfClass:[NSString class]]) {
                            _lastActivitySandbox = @"0";
                            _lastNoticeSandbox = @"0";
                            
                        }
                        
                        _clickNoticeDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
                        _clickActionDate =  [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
                        
                        
                        if (![_clickNoticeDate isKindOfClass:[NSString class]]) {
                            _clickNoticeDate = @"0";
                            
                        }
                        if (![_clickActionDate isKindOfClass:[NSString class]]) {
                            _clickActionDate  = @"0";
                            
                            
                        }
                        
                        //如果有最新的活动
                        if ([_activityValue floatValue]>[_lastActivitySandbox floatValue]||[_noticeValue floatValue]>[_lastNoticeSandbox floatValue]) {
                            [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                            [[NSUserDefaults standardUserDefaults]setObject:_activityValue forKey:@"lastActivityTime"];
                            [[NSUserDefaults standardUserDefaults]setObject:_noticeValue forKey:@"lastNoticeTime"];
                            
                             [[NSUserDefaults standardUserDefaults]setBool:NO forKey: @"clickActionBool"];
                            
                             [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"clickNoticeBool"];
                        }else if ([_activityValue floatValue]==[_lastActivitySandbox floatValue]||[_noticeValue floatValue]==[_lastNoticeSandbox floatValue])
                            
                        {
                            //
                            
                            
                            if ([_clickNoticeDate floatValue]>=[_noticeValue floatValue]&&[_clickActionDate floatValue]>=[_activityValue floatValue]) {
                                
                                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                
                                
                            }else{
                                if (noticeState ==YES && activitystate ==YES) {
                                    
                                    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                    
                                }else{
                                    
                                    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                                }
                                
                                
                                
                            }
                            
                            
                        }else
                            
                            
                            
                        {
                            
                            //隐藏
                            [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    else{
                        
                        
                        
                        NSLog(@"没有新消息");
                        
                        
                    }
                    
                }];
    
    
    
}


//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"时间%@", strDate);
//
//
//    NSString *dateString= [strDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//
//
//    //    NSDate *localDate = [NSDate date]; //获取当前时间
//    //    //
//    //    NSLog(@"当前时间%@",localDate);
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
//                                   @{
//                                     @"start_time" : dateString
//                                     }];
//
#pragma mark - 时间转字符串
- (NSString *) changeDateToDateString :(NSDate *) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh mm" options:0 locale:locale];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:locale];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



//是宽度不变，动态改变高度
- (float)widthForString:(NSString*)value
               fontSize:(float)fontSize
              andHeight:(float)height
{
    
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                             lineBreakMode:NSLineBreakByCharWrapping];
    
    return sizeToFit.width;
}
/*
 plist文件夹：{
 BuildMachineOSBuild = 14F27;
 CFBundleAllowMixedLocalizations = 1;
 CFBundleDevelopmentRegion = "zh_CN";
 CFBundleExecutable = "\U5c79\U77f3\U6c83\U6295\U8d44";
 CFBundleIcons =     {
 CFBundlePrimaryIcon =         {
 CFBundleIconFiles =             (
 AppIcon60x60
 );
 };
 };
 CFBundleIdentifier = "com.otouzi.developer";
 CFBundleInfoDictionaryVersion = "6.0";
 CFBundleInfoPlistURL = "Info.plist -- file:///var/mobile/Containers/Bundle/Application/FA66C50B-DC7C-4D46-B56D-E60468D16CB7/%E5%B1%B9%E7%9F%B3%E6%B2%83%E6%8A%95%E8%B5%84.app/";
 CFBundleLocalizations =     (
 "zh_CN"
 );
 CFBundleName = "\U5c79\U77f3\U6c83\U6295\U8d44";
 CFBundleNumericVersion = 0;
 CFBundlePackageType = APPL;
 CFBundleVersion = "1.0.3";
 CFBundleSignature = "????";
 CFBundleSupportedPlatforms =     (
 iPhoneOS
 );
 CFBundleURLTypes =     (
 {
 CFBundleTypeRole = Editor;
 CFBundleURLSchemes =             (
 wb3923696387
 );
 },
 {
 CFBundleTypeRole = Editor;
 CFBundleURLSchemes =             (
 QQ41DDF5EB
 );
 },
 {
 CFBundleTypeRole = Editor;
 CFBundleURLSchemes =             (
 wx4868b35061f87885
 );
 }
 );
 CFBundleVersion = "5.2.11";
 DTCompiler = "com.apple.compilers.llvm.clang.1_0";
 DTPlatformBuild = 13B137;
 DTPlatformName = iphoneos;
 DTPlatformVersion = "9.1";
 DTSDKBuild = 13B137;
 DTSDKName = "iphoneos9.1";
 DTXcode = 0711;
 DTXcodeBuild = 7B1005;
 LSApplicationCategoryType = "";
 LSApplicationQueriesSchemes =     (
 sinaweibo,
 sinaweibohd,
 sinaweibosso,
 sinaweibohdsso,
 weibosdk,
 "weibosdk2.5",
 mqqOpensdkSSoLogin,
 mqqopensdkapiV2,
 mqqopensdkapiV3,
 wtloginmqq2,
 mqq,
 mqqapi,
 mqzoneopensdk,
 mqzoneopensdkapi,
 mqzoneopensdkapi19,
 mqzoneopensdkapiV2,
 mqqOpensdkSSoLogin,
 mqqopensdkapiV2,
 mqqopensdkapiV3,
 wtloginmqq2,
 mqqwpa,
 mqzone,
 wechat,
 weixin
 );
 LSRequiresIPhoneOS = 1;
 MinimumOSVersion = "8.0";
 NSAppTransportSecurity =     {
 NSAllowsArbitraryLoads = 1;
 };
 UIDeviceFamily =     (
 1
 );
 UILaunchImages =     (
 {
 UILaunchImageName = "i5_00.png";
 UILaunchImageSize = "{320,568}";
 },
 {
 UILaunchImageMinimumOSVersion = "8.0";
 UILaunchImageName = "LaunchImage-800-667h";
 UILaunchImageOrientation = Portrait;
 UILaunchImageSize = "{375, 667}";
 }
 );
 UILaunchStoryboardName = LaunchScreen;
 UIRequiredDeviceCapabilities =     (
 arm64
 );
 UISupportedInterfaceOrientations =     (
 UIInterfaceOrientationPortrait,
 UIInterfaceOrientationPortraitUpsideDown,
 UIInterfaceOrientationPortraitUpsideDown
 );
 UIViewControllerBasedStatusBarAppearance = 0;
 }
 */
@end
