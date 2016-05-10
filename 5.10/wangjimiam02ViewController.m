//
//  wangjimiam02ViewController.m
//  555
//
//  Created by 李浩宇 on 16/4/5.
//  Copyright © 2016年 李浩宇. All rights reserved.
//
#import "AFNetworking.h"
#import "wangjimiam02ViewController.h"
#import "wangjimimaViewController.h"
#import "Masonry.h"
#import "SevenSwitch.h"
#import "UICommons.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"

@interface wangjimiam02ViewController ()
{
     int q;
    UILabel *_titleLabel;
      UITextField *zhanghao;
}

@property (nonatomic,strong) NSString *shoujihao;
@end

@implementation wangjimiam02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    q = 1;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tabBarController.tabBar.backgroundColor =   [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"找回密码";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(cheba:)
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
    [imge_deng setImage:[UIImage imageNamed:@"forget_mi02.png"]];

    
#pragma mark - 登录密码
    
    if (__kScreenHeight__ == 568) {
        zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.154*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        
        zhanghao.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
        
        zhanghao.textColor = [UIColor blackColor];
        zhanghao.placeholder = @"请输您的登录密码";
        [zhanghao setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [zhanghao setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
                zhanghao.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:zhanghao];
        [zhanghao addTarget:self action:@selector(zuzhanghaodeshuru:) forControlEvents:UIControlEventEditingChanged];
//        zhanghao.secureTextEntry = YES;
        
        
    }else if (__kScreenHeight__ >= 667)
    { zhanghao = [[UITextField alloc]initWithFrame:CGRectMake(0.053*__kScreenWidth__, 0.134*__kScreenHeight__, 0.894*__kScreenWidth__, 50*__kScreenHeight__/1334)];
        
        zhanghao.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//内容上下对齐
//        zhanghao.secureTextEntry = YES;
        zhanghao.textColor = [UIColor blackColor];
        zhanghao.placeholder = @"请输入您的登录密码";
        [zhanghao setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [zhanghao setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
                zhanghao.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        //    shuru.textAlignment =  UITextAlignmentCenter;//光标居中
        [self.view addSubview:zhanghao];
        [zhanghao addTarget:self action:@selector(zuzhanghaodeshuru:) forControlEvents:UIControlEventEditingChanged];
        
        
        
        
    }
    
#pragma mark - 密码详情开关
    if (__kScreenHeight__ == 568) {
        SevenSwitch *mySwitch3 = [[SevenSwitch alloc] init];
        [self.view addSubview:mySwitch3];
        [mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0.771*__kScreenWidth__);
            make.top.mas_offset(0.15*__kScreenHeight__);
            make.width.mas_offset(0.155*__kScreenWidth__);
            make.height.mas_offset(0.04*__kScreenHeight__);
        }];
        mySwitch3.on = YES;
        mySwitch3.offImage = [UIImage imageNamed:@"abc_02.png"];
        mySwitch3.onImage = [UIImage imageNamed:@"abc_01.png"];
        [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
        mySwitch3.thumbTintColor = [UIColor whiteColor];//小圆
        mySwitch3.activeColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//转换过程
        mySwitch3.inactiveColor = [UIColor whiteColor];//关
        mySwitch3.onTintColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//开
        mySwitch3.borderColor = [UIColor lightGrayColor];//整背景
        mySwitch3.shadowColor = [UIColor clearColor];//半透明
        
    }else{
        SevenSwitch *mySwitch3 = [[SevenSwitch alloc] init];
        [self.view addSubview:mySwitch3];
        [mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0.771*__kScreenWidth__);
            make.top.mas_offset(0.133*__kScreenHeight__);
            make.width.mas_offset(0.18*__kScreenWidth__);
            make.height.mas_offset(0.04*__kScreenHeight__);
        }];
        mySwitch3.on = YES;
        mySwitch3.offImage = [UIImage imageNamed:@"abc_02.png"];
        mySwitch3.onImage = [UIImage imageNamed:@"abc_01.png"];
        [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
        mySwitch3.thumbTintColor = [UIColor whiteColor];//小圆
        mySwitch3.activeColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//转换过程
        mySwitch3.inactiveColor = [UIColor whiteColor];//关
        mySwitch3.onTintColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//开
        mySwitch3.borderColor = [UIColor lightGrayColor];//整背景
        mySwitch3.shadowColor = [UIColor clearColor];//半透明
        
    }
    
    
#pragma mark - 确定
    
    if (__kScreenHeight__ == 568) {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.262*__kScreenHeight__, __kScreenWidth__, 0.11*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(zhucewanchengshaka:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (__kScreenHeight__ == 667)
    {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.262*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(zhucewanchengshaka:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.262*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(zhucewanchengshaka:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cheba:(id)sender
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
- (void)zuzhanghaodeshuru:(UITextField *)textField

{
    _shoujihao = textField.text;
    NSLog(@"新密码 %@",_shoujihao);
    
}
- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    
    if (q%2 == 0) {
        zhanghao.secureTextEntry = NO;
        q ++;
    }
    else{
        zhanghao.secureTextEntry = YES;
        q++;
    }
    
    
}
-(void)zhucewanchengshaka:(id)sender
{
    if (_shoujihao!= nil&& _shoujihao.length <= 16 && _shoujihao.length >= 6 ) {
        
        
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
        
    
        NSString *phonenumber= [[NSUserDefaults standardUserDefaults]objectForKey:@"shoujihao_02"];
        
        
        NSString *numberyan = [[NSUserDefaults standardUserDefaults]objectForKey:@"yanzhengma_02"];
        
        
        [manager POST:@"http://debug.otouzi.com:8012/user/passwordReset"
           parameters:@{ @"mobile": phonenumber,
                         @"password": _shoujihao,
                         @"verify": numberyan
                         }
         
              success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
                  
                  
                  NSMutableDictionary* objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  NSLog(@"%@",objc);
                  NSString *cun = [objc objectForKey:@"code"];
                  int unm1 = [cun intValue];
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

                  else if (unm1 == 200)
                  {
                      if (__kScreenHeight__ == 568) {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(200*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 350*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"密码修改成功";
                          meishurushouji.layer.cornerRadius = 7;
//                          meishurushouji.clipsToBounds = YES;
//                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
//                          [UIView beginAnimations:nil context:nil];
//                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//                          [UIView setAnimationDuration:2.0];
//                          [UIView setAnimationDelegate:self];
//                          meishurushouji.alpha =0.0;
//                          [UIView commitAnimations];//2秒后消失
                            meishurushouji.textAlignment = UITextAlignmentCenter;
                           [zhanghao resignFirstResponder];
                          meishurushouji.font = [UIFont systemFontOfSize:13];
                      }else if (__kScreenHeight__ >= 667)
                      {
                          UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
                          meishurushouji.textColor = [UIColor whiteColor];
                          meishurushouji.text = @"密码修改成功";
                          meishurushouji.layer.cornerRadius = 7;
//                          meishurushouji.clipsToBounds = YES;
//                          meishurushouji.textAlignment = NSTextAlignmentCenter;
                          meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
                          [self.view addSubview:meishurushouji];
//                          [UIView beginAnimations:nil context:nil];
//                          [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//                          [UIView setAnimationDuration:2.0];
//                          [UIView setAnimationDelegate:self];
//                          meishurushouji.alpha =0.0;
//                          [UIView commitAnimations];//2秒后消失
                           [zhanghao resignFirstResponder];
                          meishurushouji.font = [UIFont systemFontOfSize:15];
                            meishurushouji.textAlignment = UITextAlignmentCenter;
                      }

                      
                    [self performSelector:@selector(usus) withObject:nil afterDelay:1.0f];
                      
                      
                  }
                  
                  
                  
              } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
                  
                  NSLog(@"%@",error);
                  
              }];
    }
    
    else if(_shoujihao == nil)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入登录密码";
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
            meishurushouji.text = @"请输入登录密码";
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
        
    }else if( _shoujihao.length < 6)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"同户名必须大于6位";
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
            meishurushouji.text = @"用户名必须大于6位";
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
    
    else if(_shoujihao.length>=16){
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"用户名必须大于15位";
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
            meishurushouji.text = @"用户名必须大于15位";
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
-(void)usus{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"code1"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"samenamede"];
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
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];//页面跳转
    //

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
