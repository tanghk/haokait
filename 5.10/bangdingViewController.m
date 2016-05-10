//
//  bangdingViewController.m
//  555
//
//  Created by 浩宇李 on 16/1/16.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "bangdingViewController.h"
#import "TabbarViewController.h"
#import "AppDelegate.h"
#import "CoreArchive.h"
#import "UICommons.h"
#import "Masonry.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface bangdingViewController ()
{
      __block int timeout;
    UIWindow *lastwindou1;
    UIControl *zhedang1;
    UIView *xieyiview1;
    UIButton *_yanzheng1;
    NSString *_yanzhengma;
    NSString *jiumima;
    NSString *xinmima;
    UITextField *miamas;
    UILabel *_titleLabel;
    UITextField *yanzhengma;
    UITextField *zhanghao;
}
@property (nonatomic,strong) NSString *shoujihao;
@property (nonatomic,strong) NSString *yanzhengma;
@property (nonatomic,strong) NSString *mimashuru;
@property (nonatomic,strong) UITextField *xindemima;
@property (nonatomic,strong) UITextField *yaoqingyong;
@property (nonatomic,strong) NSString *yaomade;
@end

@implementation bangdingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.tabBarController.tabBar setClipsToBounds:YES];
    
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"6enroll17@2x.png"];
    
    self.tabBarController.tabBar.alpha =1;
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"绑定手机号";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(cheba5:)
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
    [imge_deng setImage:[UIImage imageNamed:@"zhuce_01.png"]];
    
    
    
    
    
#pragma mark - 账号输入框
    
    if (__kScreenHeight__ == 568) {
        zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.154*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        zhanghao.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        zhanghao.textColor = [UIColor blackColor];
        zhanghao.placeholder = @"请输入手机号";
        [zhanghao setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [zhanghao setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        zhanghao.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:zhanghao];
        [zhanghao addTarget:self action:@selector(zuzhanghaodeshuru:) forControlEvents:UIControlEventEditingChanged];
        
        zhanghao.keyboardType = UIKeyboardTypeNumberPad;
        
    }else if (__kScreenHeight__ >= 667)
    { zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.134*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        zhanghao.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        zhanghao.textColor = [UIColor blackColor];
        zhanghao.placeholder = @"请输入手机号";
        [zhanghao setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [zhanghao setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        zhanghao.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:zhanghao];
        [zhanghao addTarget:self action:@selector(zuzhanghaodeshuru:) forControlEvents:UIControlEventEditingChanged];
        
        zhanghao.keyboardType = UIKeyboardTypeNumberPad;
        
        
    }    else{
        zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.154*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        zhanghao.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        zhanghao.textColor = [UIColor blackColor];
        zhanghao.placeholder = @"请输入手机号";
        [zhanghao setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [zhanghao setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        zhanghao.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:zhanghao];
        [zhanghao addTarget:self action:@selector(zuzhanghaodeshuru:) forControlEvents:UIControlEventEditingChanged];
        
        zhanghao.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    
#pragma mark - 验证码输入框
    if (__kScreenHeight__ == 568) {
        yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.235*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        yanzhengma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        yanzhengma.textColor = [UIColor blackColor];
        yanzhengma.placeholder = @"请输入验证码";
        [yanzhengma setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [yanzhengma setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        yanzhengma.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:yanzhengma];
        [yanzhengma addTarget:self action:@selector(zuxiaobizaizi:) forControlEvents:UIControlEventEditingChanged];
        
    }else if(__kScreenHeight__ >= 667)
    {
        yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.215*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        yanzhengma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        yanzhengma.textColor = [UIColor blackColor];
        yanzhengma.placeholder = @"请输入验证码";
        [yanzhengma setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [yanzhengma setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        yanzhengma.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:yanzhengma];
        [yanzhengma addTarget:self action:@selector(zuxiaobizaizi:) forControlEvents:UIControlEventEditingChanged];
        
    }
    else{
        yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.235*__kScreenHeight__, 440*__kScreenWidth__/750, 50*__kScreenHeight__/1334)];
        
        yanzhengma.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        yanzhengma.textColor = [UIColor blackColor];
        yanzhengma.placeholder = @"请输入验证码";
        [yanzhengma setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [yanzhengma setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //        yanzhengma.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:yanzhengma];
        [yanzhengma addTarget:self action:@selector(zuxiaobizaizi:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    
#pragma mark - 验证码按钮
    
    if (__kScreenHeight__ == 568) {
        _yanzheng1 = [[UIButton alloc]initWithFrame:CGRectMake(543*__kScreenWidth__/750, 316*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 40*__kScreenHeight__/1334)];
        
        [_yanzheng1 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_yanzheng1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yanzheng1 addTarget:self action:@selector(yanzhengmade:) forControlEvents:UIControlEventTouchUpInside];
        _yanzheng1.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:_yanzheng1];
        
        
    }else if (__kScreenHeight__ == 667)
    {
        _yanzheng1 = [[UIButton alloc]initWithFrame:CGRectMake(547*__kScreenWidth__/750, 296*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 40*__kScreenHeight__/1334)];
        
        [_yanzheng1 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_yanzheng1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yanzheng1 addTarget:self action:@selector(yanzhengmade:) forControlEvents:UIControlEventTouchUpInside];
        _yanzheng1.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:_yanzheng1];
        
        
    }else
    {
        _yanzheng1 = [[UIButton alloc]initWithFrame:CGRectMake(545*__kScreenWidth__/750, 290*__kScreenHeight__/1334, 200*__kScreenWidth__/750, 40*__kScreenHeight__/1334)];
        
        [_yanzheng1 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_yanzheng1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yanzheng1 addTarget:self action:@selector(yanzhengmade:) forControlEvents:UIControlEventTouchUpInside];
        _yanzheng1.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:_yanzheng1];
        
    }
    
    
    
#pragma mark - 下一步
    
    if (__kScreenHeight__ == 568) {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.35*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(wanchengxiugai12:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (__kScreenHeight__ == 667)
    {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.35*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(wanchengxiugai12:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.35*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(wanchengxiugai12:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    

    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cheba5:(id)sender
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

-(void)wanchengxiugai12:(id)sender
{
    if ( _shoujihao !=nil && _yanzhengma!=nil) {
        
        
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
        
        
        
        [manager POST:@"http://debug.otouzi.com:8012/user/phoneBind"
           parameters:@{@"verify": _yanzhengma,
                        @"mobile": _shoujihao  }
         
              success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
                  
                  NSLog(@"%@",responseObject);
               
                  
                  
                  
                  NSMutableDictionary* objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  NSString *coun = [objc objectForKey:@"code"];
                  int unm1 = [coun intValue];
                  
                  if (unm1 == 500)
                  {
                      if (__kScreenHeight__ == 568) {
                          
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
                  {
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
                      
                  }
                  else if (unm1 == 4031)
                  {  if (__kScreenHeight__ == 568) {
                      
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
                  {
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
                      
                  }
                  else if (unm1 == 2100)
                  { if (__kScreenHeight__ == 568) {
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
                  {                       UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
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
                  else if (unm1 == 2102)
                  {
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
                  {
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
                  {
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
                  {  if (__kScreenHeight__ == 568) {
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
                  else if (unm1 == 2106)
                  { if (__kScreenHeight__ == 568) {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  {
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
                  { if (__kScreenHeight__ == 568) {
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
                  {
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
                  {
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
                  { if (__kScreenHeight__ == 568) {
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
                  {  if (__kScreenHeight__ == 568) {
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
                  {  if (__kScreenHeight__ == 568) {
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
                  {
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
                  {  if (__kScreenHeight__ == 568) {
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
                  { if (__kScreenHeight__ == 568) {
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

                  else if( unm1 == 200 ){
                      UILabel *tishi = [[UILabel alloc]initWithFrame:CGRectMake(300*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 150*__kScreenWidth__/750, 42*__kScreenHeight__/1334)];
                      tishi.textColor = [UIColor whiteColor];
                      tishi.text = @" 绑定手机成功";
                      tishi.layer.cornerRadius = 7;
                      tishi.clipsToBounds = YES;
                      tishi.font = [UIFont systemFontOfSize:11];
                      tishi.backgroundColor = [UIColor blackColor];
                      
                      [self.view addSubview:tishi];
                       [NSThread sleepForTimeInterval:1.0f];
                  AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                  TabbarViewController *tab = [[TabbarViewController alloc]init];
                  delete.window.rootViewController = tab;
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];//页面跳转
                  
                  CATransition *animation = [CATransition animation];
                  animation.duration = 0.5;
                  animation.timingFunction = UIViewAnimationCurveEaseInOut;
                  animation.type = @"pageCurl";
                  animation.type = kCATransitionPush;
                  animation.subtype = kCATransitionFromLeft;
                  [self.view.window.layer addAnimation:animation forKey:nil];
                  [self dismissViewControllerAnimated:NO completion:nil];

                      
                  }
                  
                  
                  
                  
              } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
                  
                  NSLog(@"%@",error);
                  
              }];
    }else if (_shoujihao == nil)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(100*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 550*__kScreenWidth__/750, 60*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入手机号";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor blackColor];
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
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(100*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 538*__kScreenWidth__/750, 42*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入手机号";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor blackColor];
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
    }else if (_yanzhengma == nil)
    {
        
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入手机验证码";
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
            meishurushouji.text = @"请输入手机验证码";
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

- (void)xiaobizaizi12:(UITextField *)textField
{
    _yanzhengma = textField.text;
    NSLog(@"验证码%@",_yanzhengma);
    
}

-(void)qingqiuyanzhengma
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
    
    
    
    [manager POST:@"http://debug.otouzi.com:8012/service/phoneUpdate/sendCode"
       parameters:@{ @"mobile": _shoujihao
                     }          // 新手机号
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"%@",responseObject);
              NSMutableDictionary* objc = [[NSMutableDictionary alloc] init];
              
              objc = responseObject;
              NSString *coun = [objc objectForKey:@"code"];
              int unm1 = [coun intValue];
              if (unm1 == 500)
              {
                  if (__kScreenHeight__ == 568) {
                      
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
              {
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
                  
              }
              else if (unm1 == 4031)
              {  if (__kScreenHeight__ == 568) {
                  
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
              {
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
                  
              }
              else if (unm1 == 2100)
              { if (__kScreenHeight__ == 568) {
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
              {                       UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(260*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 258*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
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
              else if (unm1 == 2102)
              {
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
              {
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
              {
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
              {  if (__kScreenHeight__ == 568) {
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
              else if (unm1 == 2106)
              { if (__kScreenHeight__ == 568) {
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
              {
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
              {
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
              {
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
              {
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
              {
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
              {
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
              {
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
              {
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
              {
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
              { if (__kScreenHeight__ == 568) {
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
              {
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
              {
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
              { if (__kScreenHeight__ == 568) {
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
              {  if (__kScreenHeight__ == 568) {
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
              {  if (__kScreenHeight__ == 568) {
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
              {
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
              {  if (__kScreenHeight__ == 568) {
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
              { if (__kScreenHeight__ == 568) {
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

                else if(unm1 == 200){
                  timeout =59; //倒计时时间
                  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                  dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                  dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                  dispatch_source_set_event_handler(_timer, ^{
                      if(timeout<=0){ //倒计时结束，关闭
                          dispatch_source_cancel(_timer);
                          dispatch_async(dispatch_get_main_queue(), ^{
                              //设置界面的按钮显示 根据自己需求设置
                              [_yanzheng1 setTitle:@"重新获取" forState:UIControlStateNormal];
                              _yanzheng1.userInteractionEnabled = YES;
                              
                          });
                          
                      }else{
                          
                          int seconds = timeout % 60;
                          NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                          dispatch_async(dispatch_get_main_queue(), ^{
                              //设置界面的按钮显示 根据自己需求设置
                              //NSLog(@"____%@",strTime);
                              [UIView beginAnimations:nil context:nil];
                              [UIView setAnimationDuration:1];
                              [_yanzheng1 setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                              if (__kScreenHeight__ == 568) {
                                  _yanzheng1.titleLabel.font = [UIFont systemFontOfSize: 11];
                              }
                              [UIView commitAnimations];
                              _yanzheng1.userInteractionEnabled = NO;
                          });
                          timeout--;
                      }
                  });
                  dispatch_resume(_timer);
              }
              
          } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
              
              
          }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)zuxiaobizaizi:(UITextField *)textField
{
    _yanzhengma = textField.text;
    NSLog(@"验证码%@",_yanzhengma);
    [[NSUserDefaults standardUserDefaults]setObject:_yanzhengma forKey:@"yanzhengma_01"];
}

- (void)zuzhanghaodeshuru:(UITextField *)textField

{
    _shoujihao = textField.text;
    NSLog(@"手机号%@",_shoujihao);
    [[NSUserDefaults standardUserDefaults]setObject:_shoujihao forKey:@"shoujihao_01"];
    
}
- (void)yanzhengmade:(id)sender
{
    if (_shoujihao != nil && _shoujihao.length>=1) {
        
        NSString * temp1 = [_shoujihao substringWithRange:NSMakeRange(0, 1)];
        NSLog(@"%@",temp1);
        if (_shoujihao.length == 11 && [temp1 isEqualToString:@"1"]) {
            
            
            [self qingqiuyanzhengma];
            
        }else{
            UIAlertView *alerterroe = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                                 message:@"输入手机号格式不正确！"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alerterroe show];
            
            timeout = 0;
        }
    }
    else
    {
        
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
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
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
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
    
    
}



@end
