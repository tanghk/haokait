//
//  gerenzhanghuViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/1.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
#import "CommonProblemsViewController.h"
#import "gerenzhanghuViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "xiugaidengluViewController.h"
#import "disafangViewController.h"
#import "shoujihaoViewController.h"
#import "CLLockVC.h"
#import "hdgzViewController.h"
#import "bangdingViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "CoreArchive.h"
#import "UICommons.h"
#import "SevenSwitch.h"

#import "guanyuViewController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface gerenzhanghuViewController ()
{
    UIWindow *lastwindou;
    UIControl *zhedang;
    UIView *xieyiview;
    UILabel *_titleLabel;
    int panduan;
    UIButton *_loginButton;
    UIButton *shoujihaoxiugai ;
}
@property(nonatomic, strong) NSData *fileData;
@property(nonatomic,strong )UIImageView *imgtou1;
@property (nonatomic,strong)UIImage *image;

@end

@implementation gerenzhanghuViewController

-(void)viewWillAppear:(BOOL)animated{
          NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];//设置手势密码
    if ([setType isEqualToString:@"1"]) {
        
        
        UIButton *shoushimima = [[UIButton alloc]initWithFrame:CGRectMake(0, 520*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
        
        
        [self.view addSubview:shoushimima];
        
        [shoushimima addTarget:self action:@selector(shoushixiugai:) forControlEvents:UIControlEventTouchUpInside];

        
        UIButton *help = [[UIButton alloc]initWithFrame:CGRectMake(0, 690*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
        [self.view addSubview:help];
        
        [help addTarget:self action:@selector(helpview:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *guan = [[UIButton alloc]initWithFrame:CGRectMake(0, 820*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
        [self.view addSubview:guan];
        
        
        [guan addTarget:self action:@selector(guanview:) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *imge_deng = [[UIImageView alloc]init];
        [self.view addSubview:imge_deng];
        [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(64.5);
            make.width.mas_equalTo(self.view.frame.size.width);
            make.height.mas_equalTo(self.view.frame.size.height - 64.5);
            
        }];
        [imge_deng setImage:[UIImage imageNamed:@"shezhi_main.png"]];
        
    }else{
        
        UIButton *help = [[UIButton alloc]initWithFrame:CGRectMake(0, 570*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
        [self.view addSubview:help];
        
        [help addTarget:self action:@selector(helpview:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *guan = [[UIButton alloc]initWithFrame:CGRectMake(0, 700*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
        [self.view addSubview:guan];
        
        
        [guan addTarget:self action:@selector(guanview:) forControlEvents:UIControlEventTouchUpInside];

        
        
        
        UIImageView *imge_deng = [[UIImageView alloc]init];
        [self.view addSubview:imge_deng];
        [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(64.5);
            make.width.mas_equalTo(self.view.frame.size.width);
            make.height.mas_equalTo(self.view.frame.size.height - 64.5);
            
        }];
        [imge_deng setImage:[UIImage imageNamed:@"shezhi_maingai.png"]];
        
    }
#pragma mark - 密码详情开关
    if (__kScreenHeight__ == 568) {
        SevenSwitch *mySwitch3 = [[SevenSwitch alloc] init];
        [self.view addSubview:mySwitch3];
        [mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0.771*__kScreenWidth__);
            make.top.mas_offset(0.439*__kScreenHeight__);
            make.width.mas_offset(0.15*__kScreenWidth__);
            make.height.mas_offset(0.04*__kScreenHeight__);
        }];
        
        
        
        NSString *setValue =    [[NSUserDefaults standardUserDefaults]objectForKey: @"SetLockType" ];
        
        
        
        if ([setValue intValue]==1) {
            
            mySwitch3.on = YES;
        }else{
            
            mySwitch3.on = NO;
            
        }
        
        
        [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
        mySwitch3.thumbTintColor = [UIColor whiteColor];//小圆
        mySwitch3.activeColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//转换过程
        mySwitch3.inactiveColor = [UIColor whiteColor];//关
        mySwitch3.onTintColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//开
        mySwitch3.borderColor = [UIColor lightGrayColor];//整背景
        mySwitch3.shadowColor = [UIColor clearColor];//半透明
        
    }else if(__kScreenHeight__ == 667){
        SevenSwitch *mySwitch3 = [[SevenSwitch alloc] init];
        [self.view addSubview:mySwitch3];
        [mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0.771*__kScreenWidth__);
            make.top.mas_offset(0.433*__kScreenHeight__);
            make.width.mas_offset(0.17*__kScreenWidth__);
            make.height.mas_offset(0.04*__kScreenHeight__);
        }];
        
        
        NSString *setValue =    [[NSUserDefaults standardUserDefaults]objectForKey: @"SetLockType" ];
        
        
        
        if ([setValue intValue]==1) {
            
            mySwitch3.on = YES;
        }else{
            
            mySwitch3.on = NO;
            
        }
        
        
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
            make.top.mas_offset(0.425*__kScreenHeight__);
            make.width.mas_offset(0.17*__kScreenWidth__);
            make.height.mas_offset(0.04*__kScreenHeight__);
        }];
        
        
        NSString *setValue =    [[NSUserDefaults standardUserDefaults]objectForKey: @"SetLockType" ];
        
        
        
        if ([setValue intValue]==1) {
            
            mySwitch3.on = YES;
        }else{
            
            mySwitch3.on = NO;
            
        }
        
        
        
        [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
        mySwitch3.thumbTintColor = [UIColor whiteColor];//小圆
        mySwitch3.activeColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//转换过程
        mySwitch3.inactiveColor = [UIColor whiteColor];//关
        mySwitch3.onTintColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];//开
        mySwitch3.borderColor = [UIColor lightGrayColor];//整背景
        mySwitch3.shadowColor = [UIColor clearColor];//半透明
        
    }
    
    
    
    
    
    
    


  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self zhongxin];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"设置";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(cheba1:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];


    
    
    


    
    
    
    
    
#pragma mark - 修改密码
    UIButton *xiugaidenglimima = [[UIButton alloc]initWithFrame:CGRectMake(0, 260*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
    
    
    [self.view addSubview:xiugaidenglimima];
    
    [xiugaidenglimima addTarget:self action:@selector(xiugaimima:) forControlEvents:UIControlEventTouchUpInside];
    
    

#pragma mark - 手机号修改
    shoujihaoxiugai= [[UIButton alloc]initWithFrame:CGRectMake(0, 130*__kScreenHeight__/1334+64, __kScreenWidth__, 120*__kScreenHeight__/1334)];
    
    [self.view addSubview:shoujihaoxiugai];
    
    
 

#pragma mark - 退出登录
    
    
    zhedang = [[UIControl alloc]
               initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
    
    zhedang.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    zhedang.hidden = YES;
    [zhedang addTarget:self
                action:@selector(maskViewAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    lastwindou = [UIApplication sharedApplication].windows.lastObject;
    
    
    xieyiview = [[UIView alloc]init];
    [lastwindou addSubview:xieyiview];
    
    [xieyiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.5*__kScreenHeight__-60);
        make.left.mas_offset(40);
        make.width.mas_offset(__kScreenWidth__-80);
        make.height.mas_offset(120);
    }];
    
    
    xieyiview.backgroundColor = [UIColor whiteColor];
    
    
    
    xieyiview.hidden = YES;
    
    [lastwindou insertSubview:zhedang belowSubview:xieyiview];
    
    if (__kScreenHeight__ == 568) {
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(20,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        
        [tongyi setImage:[UIImage imageNamed:@"qd.png"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        
        UIButton *tongyi2 = [[UIButton alloc]initWithFrame:CGRectMake(140,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi2 setImage:[UIImage imageNamed:@"6elBtn.png"]forState:UIControlStateNormal];
        [tongyi2 addTarget:self action:@selector(maskViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi2];
        
        
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth__-80, 40)];
        [xieyiview addSubview:xuzhis];
         xuzhis.textAlignment = UITextAlignmentCenter;
        xuzhis.text = @"您确定要退出么？";
        xuzhis.font = [UIFont systemFontOfSize:13];
        
    }else if(__kScreenHeight__ == 667){
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(20,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"qd"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        
        
        
        
        UIButton *tongyi2 = [[UIButton alloc]initWithFrame:CGRectMake(170,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi2 setImage:[UIImage imageNamed:@"6elBtn.png"]forState:UIControlStateNormal];
        [tongyi2 addTarget:self action:@selector(maskViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi2];
        
        
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth__-80, 40)];
        [xieyiview addSubview:xuzhis];
        xuzhis.textAlignment = UITextAlignmentCenter;
        xuzhis.text = @"您确定要退出么？";
        
    }else{
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(20,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"qd"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        
        
        
        UIButton *tongyi2 = [[UIButton alloc]initWithFrame:CGRectMake(200,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi2 setImage:[UIImage imageNamed:@"6elBtn.png"]forState:UIControlStateNormal];
        [tongyi2 addTarget:self action:@selector(maskViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi2];
        
        
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth__-80, 40)];
        [xieyiview addSubview:xuzhis];
        xuzhis.textAlignment = UITextAlignmentCenter;
        xuzhis.text = @"您确定要退出么？";
        
    }


    
    
    
    _loginButton = [[UIButton alloc]init];
    [self.view addSubview:_loginButton];

    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(__kScreenHeight__*0.88);
        make.left.mas_equalTo(__kScreenWidth__*0.031);
        make.width.mas_equalTo(__kScreenWidth__*0.936);
        make.height.mas_equalTo(__kScreenHeight__*0.076);
    }];

    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    panduan = [banduan intValue];
    if (panduan == 200 ) {
        
        
        
        
    }else{
        
        
        
    }
    
    [_loginButton addTarget:self
                     action:@selector(xuzhixiang:)
           forControlEvents:UIControlEventTouchUpInside];

    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
-(void)cheba1:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)zhongxin
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
             
#pragma mark -############  用户名  ###########
             
             NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
             NSDictionary *yonghuming1= [yonghuming objectForKey:@"user_info"];
             NSString *yonghuname2 = [yonghuming1 objectForKey:@"username"];
        
             [[NSUserDefaults standardUserDefaults]setObject:yonghuname2  forKey:@"userName"];//将用户名存入沙河路径
             if (__kScreenHeight__ == 568) {
                 UILabel *labledianhua =[[UILabel alloc]initWithFrame:CGRectMake(300*__kScreenWidth__/750,200*__kScreenHeight__/1334 ,400*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                 labledianhua.text  = yonghuname2;
                 labledianhua.font = [UIFont systemFontOfSize:12];
                 labledianhua.textAlignment = NSTextAlignmentRight;
                 labledianhua.textColor = [UIColor grayColor];
                 [self.view addSubview:labledianhua];

             }else if (__kScreenHeight__ == 667)
             {
                 UILabel *labledianhua =[[UILabel alloc]initWithFrame:CGRectMake(300*__kScreenWidth__/750,180*__kScreenHeight__/1334 ,400*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];

                 labledianhua.text  = yonghuname2;
                 labledianhua.textColor = [UIColor grayColor];
                  labledianhua.textAlignment = NSTextAlignmentRight;
                 [self.view addSubview:labledianhua];

             }
             else{
                 UILabel *labledianhua =[[UILabel alloc]initWithFrame:CGRectMake(300*__kScreenWidth__/750,164*__kScreenHeight__/1334 ,400*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                 labledianhua.text  = yonghuname2;
                 labledianhua.font = [UIFont systemFontOfSize:17];
                 labledianhua.textAlignment = NSTextAlignmentRight;
                 labledianhua.textColor = [UIColor grayColor];
                 [self.view addSubview:labledianhua];

             }
             
             
             
             
             
#pragma mark - #########  手机号修改  ###########
             NSString *phone1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"phonebang"];
             int phoneshu = [phone1 intValue];
             if (phoneshu == 1) {
                 if (__kScreenHeight__ == 568) {
                     
                     
                     [shoujihaoxiugai addTarget:self action:@selector(xiugaishoujihao:) forControlEvents:UIControlEventTouchUpInside];
                     
                     NSDictionary *xiugaibangdingshoujihao = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *xiugaibangdingshoujihao1= [xiugaibangdingshoujihao objectForKey:@"user_info"];
                     NSString *bangdeshouji = [xiugaibangdingshoujihao1 objectForKey:@"phone_number"];
                     [[NSUserDefaults standardUserDefaults]setObject:bangdeshouji forKey:@"phonenumber_02"];

                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(375*__kScreenWidth__/750,330*__kScreenHeight__/1334,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                     phone.font = [UIFont systemFontOfSize:12];
                     
                     NSString *tempA=[bangdeshouji substringFromIndex:7];//截取下标2之前的字符串
                     NSString *tempB=[bangdeshouji substringToIndex:3];//截取下标7之后的字符串
                     NSString *newString = [NSString stringWithFormat:@"%@****%@",tempB,tempA];
                      [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"phonenumber_01"];
                     phone.textAlignment = UITextAlignmentRight;
                     phone.text =  newString ;
                     phone.textColor = [UIColor grayColor];
                     
                     [self.view addSubview:phone];
                     
                 }else if(__kScreenHeight__ ==667)
                 {
                     
                     
                     

                     
                     
                     [shoujihaoxiugai addTarget:self action:@selector(xiugaishoujihao:) forControlEvents:UIControlEventTouchUpInside];
                     NSDictionary *xiugaibangdingshoujihao = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *xiugaibangdingshoujihao1= [xiugaibangdingshoujihao objectForKey:@"user_info"];
                     NSString *bangdeshouji = [xiugaibangdingshoujihao1 objectForKey:@"phone_number"];
                      [[NSUserDefaults standardUserDefaults]setObject:bangdeshouji forKey:@"phonenumber_02"];
                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(375*__kScreenWidth__/750,310*__kScreenHeight__/1334 ,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                      phone.textAlignment = UITextAlignmentRight;
                     
                     NSString *tempA=[bangdeshouji substringFromIndex:7];//截取下标2之前的字符串
                     NSString *tempB=[bangdeshouji substringToIndex:3];//截取下标7之后的字符串
                     NSString *newString = [NSString stringWithFormat:@"%@****%@",tempB,tempA];
                           [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"phonenumber_01"];
                     
                     phone.text =  newString ;
                     phone.textColor = [UIColor grayColor];
                     
                     [self.view addSubview:phone];
                     
                     
                     
                 }else{
                     
                     [shoujihaoxiugai addTarget:self action:@selector(xiugaishoujihao:) forControlEvents:UIControlEventTouchUpInside];
                     NSDictionary *xiugaibangdingshoujihao = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *xiugaibangdingshoujihao1= [xiugaibangdingshoujihao objectForKey:@"user_info"];
                     NSString *bangdeshouji = [xiugaibangdingshoujihao1 objectForKey:@"phone_number"];
                      [[NSUserDefaults standardUserDefaults]setObject:bangdeshouji forKey:@"phonenumber_02"];
                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(360*__kScreenWidth__/750,300*__kScreenHeight__/1334 ,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                      
                      phone.textAlignment = UITextAlignmentRight;
                     NSString *tempA=[bangdeshouji substringFromIndex:7];//截取下标2之前的字符串
                     NSString *tempB=[bangdeshouji substringToIndex:3];//截取下标7之后的字符串
                     NSString *newString = [NSString stringWithFormat:@"%@****%@",tempB,tempA];
                           [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"phonenumber_01"];
                    
                     phone.text =  newString ;
                     phone.textColor = [UIColor grayColor];
                     
                     [self.view addSubview:phone];

                 }

                 
             }else
             {
                 [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phonenumber_02"];
                 [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phonenumber_01"];
                 if (__kScreenHeight__ == 568) {
                     
                     
                     [shoujihaoxiugai addTarget:self action:@selector(caonima:) forControlEvents:UIControlEventTouchUpInside];
                     
                     
                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(380*__kScreenWidth__/750,330*__kScreenHeight__/1334,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                     phone.font = [UIFont systemFontOfSize:12];
               
                     phone.textAlignment = UITextAlignmentRight;
                     phone.text =  @"未完成" ;
                     phone.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1];
                     
                     [self.view addSubview:phone];
                     
                 }else if(__kScreenHeight__ ==667)
                 {
                     
                     
                     
                     
                     
                     
                     [shoujihaoxiugai addTarget:self action:@selector(caonima:) forControlEvents:UIControlEventTouchUpInside];
                  
                     
                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(380*__kScreenWidth__/750,310*__kScreenHeight__/1334 ,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                     phone.textAlignment = UITextAlignmentRight;
                     
                     
                     
                     
                     phone.text =  @"未完成" ;
                     phone.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1];
                     
                     [self.view addSubview:phone];
                     
                     
                     
                 }else{
                     
                     [shoujihaoxiugai addTarget:self action:@selector(caonima:) forControlEvents:UIControlEventTouchUpInside];
            
                     
                     UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(380*__kScreenWidth__/750,300*__kScreenHeight__/1334 ,300*__kScreenWidth__/750 ,44*__kScreenHeight__/1334 )];
                     phone.textAlignment = UITextAlignmentRight;
                  
                     
                     phone.text =  @"未完成" ;
                     phone.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1];
                     
                     [self.view addSubview:phone];
                     
                 }
                 

                 

             }
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
    
    
}
-(void)wodetouxiang:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
}
#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"buttonIndex = [%d]",buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //                     [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            //        case 2://摄像机
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            //            //            [self presentModalViewController:imagePicker animated:YES];
            //            [self presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //                      [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            //        case 3://本地视频
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            //            [self presentModalViewController:imagePicker animated:YES];
            //            [self presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
        default:
            break;
    }
}
  
#pragma mark -
#pragma UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)saveImage:(UIImage *)image {
    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //        _imageviewtouxiang=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(100, 100)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    //    [_img setImage:selfPhoto forState:UIControlStateNormal];
    _image= selfPhoto;
    
    _imgtou1.image = _image;
    
    [self shangchuantouxiang];
    
    
    
    
}


// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return newimage;
    
}
-(void)shangchuantouxiang
{
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    NSData *dataObj = UIImageJPEGRepresentation(_image , 1.0);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    [manager POST:@"http://debug.otouzi.com:8012/user/avatar"
       parameters:@{}
     
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    [formData appendPartWithFileData:dataObj name:@"avatar" fileName:@"imagetouxiang.jpg" mimeType:@"file"];
    
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    // 请求头
    NSLog(@"%@", operation.request.allHTTPHeaderFields);
    
    // 服务器回复的头
    //    NSLog(@"%@", operation.response);
    
    NSLog(@"%@", responseObject);
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *contentDic = responseObject;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"status"]];
        
        if ([stateStr isEqualToString:@"1"]) {
            
            NSDictionary *dataDic = [contentDic objectForKey:@"data"];
            NSString *imageUrl = [dataDic objectForKey:@"avatar"];
            
            [[NSUserDefaults standardUserDefaults] setObject:imageUrl forKey:@"HeadImageUrl"];
        }else{
            
            [_imgtou1 setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"HeadImageUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        }
    }
    
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    NSLog(@"%@", error);
}];
    
}
-(void)shimingren:(id)sender
{
    disafangViewController *disanfang= [[disafangViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];

    [self presentViewController:disanfang animated:NO completion:nil];
}
-(void)xiugaimima:(id)sender
{
    xiugaidengluViewController *xiugai = [[xiugaidengluViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    //    [wangji setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:xiugai animated:NO completion:nil];

}

-(void)xiugaishoujihao:(id)sender
{
    shoujihaoViewController *xigaishoujihao1 = [[shoujihaoViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    //    [wangji setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:xigaishoujihao1 animated:NO completion:nil];

    
}


-(void)huifutianxia:(id)sender
{
    hdgzViewController *touziba = [[hdgzViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:touziba animated:NO completion:nil];

}
-(void)caonima:(id)sender
{
    bangdingViewController *ba= [[bangdingViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:ba animated:NO completion:nil];

    
}

- (void)loginAction:(id)sender {
    [self xuzhitui];
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"huodongshijian"];
    [[NSUserDefaults standardUserDefaults ]removeObjectForKey:@"duandingkuaijie"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"biaohaoka"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"morenkahao"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba1"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"idhaoba2"];

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"newbiewc"];
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
    
    
       [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"SetLater"];
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
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"chongzhihouzhanghujine"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zhijietiao"];
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"yincang" object:self];
             
             
             
             /*
              *清点
              */
             
             
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"lastNoticeTime"];
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"lastActivityTime"];

             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"clickNoticeDate"];
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"clickActionDate"];
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"clickNoticeBool"];
             
             [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"clickActionBool"];
             
             

             
             [NSThread sleepForTimeInterval:0.5f];
             //
             //             DengluViewController *touziba = [[DengluViewController alloc]init];
             
             AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
             TabbarViewController *tab = [[TabbarViewController alloc]init];
             delete.window.rootViewController = tab;
             
//             [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
 
             
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             
         }];
    
    // self.login.selected = !self.login.selected;
}
- (void)switchChanged:(SevenSwitch *)sender
{
    
    
    
    if (sender.on ==YES) {
        
         [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"SetLater"];
        [self setCoreLock];
        
    }else{
       
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"coreLockType"];//验证手势密
        [self closeCoreLock];
        
    }
    
    
    
    
}
-(void)helpview:(id)sender
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



//#pragma mark - 设置手势密码
-(void)shoushixiugai:(id)sender
{
    /*
     *  修改密码
     */
  //  [[NSUserDefaults standardUserDefaults]setObject:@"modify" forKey:@"modify"];
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
        
    }else {
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:.35f];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"modify"];
            
        }];
    }
    
    
}

#pragma mark -开启手势密码
- (void)setCoreLock{
    
    
    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
    if (panduan == 200 ) {
        
        
        NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];//设置手势密码
        if ([setType isEqualToString:@"1"]) {
            ;
        }else{
            
            
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
                        [lockVC dismiss:0.35f];
                        
                        NSString *setType = @"1";
                        [[NSUserDefaults standardUserDefaults]setObject:setType forKey:@"SetLockType"];//设置手势密码
                        
                           [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"SetLater"];
                    }];
                }
                
            }
        }
        
    }else{
        
        
        
    }
    
    
    
}

#pragma mark  - 进入后台
-(void)closeCoreLock{

            
            NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];//设置手势密码
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
                              
                                [lockVC dismiss:.35f];
                                
                                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"SetLater"];
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
                                
                                

                                
                            }];
                        }
                    }
                    
                    
                    
                }
                
                
                
            }else{
                
                
                /*
                 *
                 *没设置手势密码
                 */
                
            }
            
            
            
            
    
        
        
  
    
}



-(void)guanview:(id)sender
{
     guanyuViewController *advice = [[guanyuViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:advice animated:NO completion:nil];

}







- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = YES;
                     }];
    
}
-(void)maskViewAction:(id)sender
{
    zhedang.hidden = YES;
    [self hideShareView];
}
-(void)xuzhixiang:(id)sender
{
    [self showShareView];
}
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = NO;
                         
                         //使用block，来执行一个动画
                         //向下的平移
                         //                         .transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight-1230/3-kNavigationBarHeight));
                         
                         zhedang.hidden = NO;
                     }];
    
}
-(void)xuzhitui
{
    
    zhedang.hidden = YES;
    [self hideShareView];
    
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
