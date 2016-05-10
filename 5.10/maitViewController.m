//
//  maitViewController.m
//  555
//
//  Created by 李浩宇 on 16/3/8.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "maitViewController.h"
#import "gerenzhanghuViewController.h"
#import "Masonry.h"

#import "disafangViewController.h"
#import "chongzhiViewController.h"
#import "JIAOYIViewController.h"
#import "DetalisViewController.h"
#import "AFNetworking.h"
#import "CoreArchive.h"
#import "CLLockVC.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "ViewController.h"
#import "MyInvestController.h"
#import "RedEnvelopesController.h"
#import "UITabBar+badge.h"
#import "DataService.h"
#import "WithdrawController.h"
#import "ShortcutCardWithdrawController.h"
#import "NormalCardWithdrawController.h"
#import "RedConponViewController.h"

#import "UICommons.h"
#import "UIViewExt.h"
#import "InvitationFriendController.h"
#import "NormalController.h"

@interface maitViewController ()
{
    UILabel *remainder;
    UILabel *howmuch;
    UILabel *monthmonay;
    UILabel *allmonay;
    UILabel *username;
    NSString *remainderstr;
    
    
    UIControl *zhedang;
    UIWindow *lastwindou;
    UIView *xieyiview;
    
    NSString* _activityValue;
    NSString* _noticeValue;
    NSString * _lastActivitySandbox;//沙河
    NSString * _lastNoticeSandbox;//沙河
    
    
    BOOL noticeState; // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBtn"];
    BOOL   activitystate;  //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionButton"];
    
    NSString * _clickNoticeDate; //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
    NSString * _clickActionDate;  // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
    
    
    /*
     *快捷卡
     */
    BOOL _hasDefaultBankCard;  //data-bankCard-hasDefaultBankCard
    
    /*
     *普卡
     */
    
    BOOL _bind_bankcard; //data-chinapnr-bind_bankcard
    
    
    BOOL _is_holiday;//是否是节假日
    
    BOOL _tomrrow_Is_Holiday;//明天是节假日
    
    NSString * _holiday_days;
    

    NSDictionary *_bankCardDic;
    NSDictionary *_chinapnrDic;
    NSString *_invitationUrl;//邀请
    
    NSString *_available_balance;//可用余额
    NSString *_realname;//持卡人

    NSDictionary *_user_invitation_code_url;
    NSString * _hrefShare;
    
    
    UIWindow *_lastWindow; //当前window
    
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
    UIControl *_maskView;

}

@end

@implementation maitViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"newbiewc"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self yaoqingmapuanduan];
    [self yonghuzhongixn];
    
    
      [self requestUserInformationData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
      UIColor *coloer = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    self.view.backgroundColor = coloer;


    
    self.navigationController.navigationBar.hidden = YES;
    UIView *navview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:navview];
    
    
    UIImageView *navbarImge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    [navbarImge setImage:[UIImage imageNamed:@"my_top.png"]];
    
    
     [navview addSubview:navbarImge];
    
    
    
    
    UIImageView *headview = [[UIImageView alloc]init];
    [self.view addSubview:headview];
    [headview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height*0.218);
    }];
    
    [headview setImage:[UIImage imageNamed:@"my_head.png"]];
    
    
    
    
    
    UIImageView *hengfu = [[UIImageView alloc]init];
    [self.view addSubview:hengfu];
    [hengfu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headview.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height*0.122);
    }];
    [hengfu setImage:[UIImage imageNamed:@"my_hengfu.png"]];
    
    
    UIImageView *cilckview = [[UIImageView alloc]init];
    [self.view addSubview:cilckview];
    [cilckview mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat a = self.view.frame.size.height*0.018;
        make.top.mas_equalTo(hengfu.mas_bottom).offset(a);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.bottom.mas_equalTo(-50);
    }];

    [cilckview setImage:[UIImage imageNamed:@"my_cilckbtn.png"]];

#pragma mark 邀请好友
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.text = @"邀请好友";
    rightLabel.textAlignment = NSTextAlignmentRight;
    UIColor *yellow  = [UIColor colorWithRed:255/255.0 green:231/255.0 blue:148/255.0 alpha:1];
    rightLabel.textColor = yellow;
    //rightLabel.layer.borderWidth = 1;
    [self.view addSubview:rightLabel];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(128/2);
    }];
    
    
    if (__kScreenHeight__ == 568) {
        rightLabel.font = [UIFont systemFontOfSize:13];
    }else{
        rightLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self
                 action:@selector(rightItemButtonAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(128/2);
    }];
    
    
    
    
    
 
#pragma mark - 设置按钮
    UIButton *setup = [[UIButton alloc]init];
    
    [self.view addSubview:setup];
    [setup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        
        if (__kScreenHeight__ == 568) {
            make.left.mas_equalTo(-3);
            make.width.mas_equalTo(self.view.frame.size.width*0.14);
        }
        else{
            make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width*0.118);
        }
        make.height.mas_equalTo(44);
    }];
    [setup setImage:[UIImage imageNamed:@"my_setup.png"] forState:UIControlStateNormal];
    [setup setAdjustsImageWhenHighlighted:NO];
    [setup addTarget:self action:@selector(usis:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 提现按钮
    UIButton *top_up = [[UIButton alloc]init];
    [self.view addSubview:top_up];
    [top_up mas_makeConstraints:^(MASConstraintMaker *make) {
         CGFloat a = self.view.frame.size.height*0.018;
        make.left.mas_equalTo(0.5*self.view.frame.size.width);
        make.top.mas_equalTo(hengfu.mas_bottom).offset(a);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
        make.height.mas_equalTo(0.236*self.view.frame.size.height);
    }];
    top_up.backgroundColor = [UIColor clearColor];
    [top_up setAdjustsImageWhenHighlighted:NO];
    [top_up addTarget:self action:@selector(top_upcilck:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
#pragma mark - 充值按钮
    UIButton *addmonay =[[UIButton alloc]init];
    [self.view addSubview:addmonay];
    [addmonay mas_makeConstraints:^(MASConstraintMaker *make) {
         CGFloat a = self.view.frame.size.height*0.018;
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(hengfu.mas_bottom).offset(a);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
        make.height.mas_equalTo(0.236*self.view.frame.size.height);
    }];
    addmonay.backgroundColor = [UIColor clearColor];
    [addmonay setAdjustsImageWhenHighlighted:NO];
    [addmonay addTarget:self action:@selector(addmonaycilck:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark  - 红包
    UIButton *redbox = [[UIButton alloc]init];
    [redbox addTarget:self action:@selector(myConponclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redbox];
    [redbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top_up.mas_bottom);
        make.left.mas_equalTo(0.5*self.view.frame.size.width);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
        make.height.mas_equalTo(0.236*self.view.frame.size.height);
    }];
    redbox.backgroundColor = [UIColor clearColor];
    [redbox setAdjustsImageWhenHighlighted:NO];
    
#pragma  mark - 我的投资
    UIButton *invest = [[UIButton alloc]init];
    [invest addTarget:self action:@selector(investclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invest];
    [invest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addmonay.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
        make.height.mas_equalTo(0.236*self.view.frame.size.height);
        
    }];
    invest.backgroundColor = [UIColor clearColor];
    [invest setAdjustsImageWhenHighlighted:NO];
    
    
    
#pragma mark - 交易记录
    UIButton *record= [[UIButton alloc]init];
    [self.view addSubview:record];
    [record mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headview.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(0.122*self.view.frame.size.height);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
    }];
    record.backgroundColor = [UIColor clearColor];
    [record setAdjustsImageWhenHighlighted:NO];
    [record addTarget:self action:@selector(recordcilck:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 资产详情
    UIButton *detalis = [[UIButton alloc]init];
    [self.view addSubview:detalis];
    [detalis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height*0.218);
    }];
    detalis.backgroundColor = [UIColor clearColor];
    [detalis setAdjustsImageWhenHighlighted:NO];
    [detalis addTarget:self action:@selector(detaliscilck:) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma mark - 还款日历
    UIButton *rili = [[UIButton alloc]init];
    [self.view addSubview:rili];
    [rili mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headview.mas_bottom);
        make.left.mas_equalTo(0.5*self.view.frame.size.width);
        make.width.mas_equalTo(0.5*self.view.frame.size.width);
        make.height.mas_equalTo(0.122*self.view.frame.size.height);
    }];
    rili.backgroundColor = [UIColor clearColor];
    [rili setAdjustsImageWhenHighlighted:NO];
    [rili addTarget:self action:@selector(rilicilck:) forControlEvents:UIControlEventTouchUpInside];
    
   
    

   }
-(void)rilicilck:(id)sender
{
    ViewController *reima1= [[ViewController alloc]init];
    reima1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reima1 animated:YES];
    
    

}
-(void)detaliscilck:(id)sender
{
    DetalisViewController *jiaoyu = [[DetalisViewController alloc]init];
    jiaoyu.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jiaoyu animated:YES];
    

    
}

-(void)recordcilck:(id)sender
{
    JIAOYIViewController *jiaoyu = [[JIAOYIViewController alloc]init];
    jiaoyu.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jiaoyu animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addmonaycilck:(id)sender
{
    
    NSNumber *huifu = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
    
    int dese = [huifu intValue];
    if (dese == 0) {
        
        disafangViewController *disanfang= [[disafangViewController alloc]init];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.35;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:disanfang animated:NO completion:nil];
        
    }else if (dese == 1)
    {
        
        chongzhiViewController *chong =[[chongzhiViewController alloc]init];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self presentViewController:chong animated:NO completion:nil];
        
    }

}
-(void)top_upcilck:(id)sender
{
    NSNumber *huifu = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
    
    int dese = [huifu intValue];
    if (dese == 0) {
        
        
        [self createRechargeView];

        [self showPromptWindow];
        //        disafangViewController *disanfang= [[disafangViewController alloc]init];
        //        CATransition *animation = [CATransition animation];
        //        animation.duration = 0.5;
        //        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        //        animation.type = @"pageCurl";
        //        animation.type = kCATransitionPush;
        //        animation.subtype = kCATransitionFromRight;
        //        [self.view.window.layer addAnimation:animation forKey:nil];
        //
        //        [self presentViewController:disanfang animated:NO completion:nil];
        
    }else if (dese == 1)
    {
        
        if (_bankCardDic!=nil &&_chinapnrDic!=nil) {
            
            
            
            if (_hasDefaultBankCard == YES) {
                
                ShortcutCardWithdrawController *shortcutWidthdraw = [[ShortcutCardWithdrawController alloc]init];
                shortcutWidthdraw.available_balance = _available_balance;//可用余额
                
                shortcutWidthdraw.realname = _realname;//持卡人
                shortcutWidthdraw.is_holiday = _is_holiday;
                shortcutWidthdraw.tomrrow_Is_Holiday = _tomrrow_Is_Holiday;
                
                shortcutWidthdraw.holiday_days = _holiday_days;
                CATransition *animation = [CATransition animation];
                animation.duration = 0.35;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"pageCurl";
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromRight;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentViewController:shortcutWidthdraw animated:NO completion:nil];
                
                
            }else{
                
                if (_bind_bankcard ==YES) {
                    
                    NormalController *normalWidthdraw = [[NormalController alloc]init];
                    normalWidthdraw.available_balance = _available_balance;//可用余额
                    
                    normalWidthdraw.realname = _realname;//持卡人
                    
                    normalWidthdraw.is_holiday = _is_holiday;
                    normalWidthdraw.tomrrow_Is_Holiday = _tomrrow_Is_Holiday;
                    normalWidthdraw.holiday_days = _holiday_days;
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.35;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                    
                    [self presentViewController:normalWidthdraw animated:NO completion:nil];
                    
                    
                    
                    
                }else{
                    
                    WithdrawController *withdraw  =[[WithdrawController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.35;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    [self presentViewController:withdraw animated:NO completion:nil];
                    
                    
                    
                    
                }
                
                
            }
            
            
        }else{
            
            
            
        }
        
        
    }
    
}
-(void)usis:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"c" forKey:@"witch"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"witch"]) ;

    gerenzhanghuViewController *gerende = [[gerenzhanghuViewController alloc]init];
    gerende.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gerende animated:YES];

}

-(void)yonghuzhongixn
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
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"%@",token);
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    [manager GET:@"http://debug.otouzi.com:8012/user/center"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             NSString *codema = [gerenzhongxin objectForKey:@"code"];
             int cuen = [codema intValue];
             if (cuen != 200 ) {
                 UIAlertView *alerterroe = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                                      message:@"登录过期！请重新登录"
                                                                     delegate:self
                                                            cancelButtonTitle:@"确定"
                                                            otherButtonTitles:nil];
                 [self loginActionbeng];
                 [alerterroe show];
             }
             else{
                 NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                 
                 NSDictionary *yonghuming1= [yonghuming objectForKey:@"user_info"];
                 
                 remainderstr = [yonghuming1 objectForKey:@"username"];//用户名
                 [[NSUserDefaults standardUserDefaults]setObject:remainderstr  forKey:@"userName"];//将用户名存入沙河路径

                 
               /*
                *用户余额，持卡人
                */
                 
                 
                 
                 
                 /*
                  *user_chinapnr_info
                  */
                 NSDictionary *user_chinapnr_infoDic = yonghuming[@"user_chinapnr_info"];
                 
                 
                 _available_balance = [NSString stringWithFormat:@"%@",user_chinapnr_infoDic[@"available_balance"]];
                 _realname =[NSString stringWithFormat:@"%@", user_chinapnr_infoDic[@"realname"]];//姓名
                 
                 
                 
                
                 
                 
                 _is_holiday =[yonghuming[@"is_holiday"]boolValue];
                 
                 _tomrrow_Is_Holiday = [yonghuming[@"tomorrow_is_holiday"]boolValue];

                 _holiday_days = yonghuming[@"holiday_days"];
              
                 
                 
                 /*
                  *快捷卡判断
                  */
                 
               _bankCardDic = yonghuming[@"bankCard"];
                 
                 _hasDefaultBankCard = [_bankCardDic[@"hasDefaultBankCard"]boolValue];
                 
                 NSLog(@"快捷卡判断:%d",_hasDefaultBankCard);
                 
                 
                 /*
                  *判断普卡
                  */
                 
                 _chinapnrDic = yonghuming[@"chinapnr"];
                 _bind_bankcard = [_chinapnrDic[@"bind_bankcard"] boolValue] ;
                 NSLog(@"普卡判断:%d",_bind_bankcard);
                 
                 
                 /*
                  *分享
                  */
                 _user_invitation_code_url =yonghuming[@"user_invitation_code_url"];
                 
                 _invitationUrl = _user_invitation_code_url[@"href"];
                 _hrefShare = _user_invitation_code_url[@"hrefShare"];

                 

                 
                 
             
                 
                 
                 
                 
#pragma mark - 用户名
                 if (!username) {
                     
                 
                 username = [[UILabel alloc]init];
                 [self.view addSubview:username];
                 [username mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.mas_equalTo(20);
                     make.left.mas_equalTo(0.118*self.view.frame.size.width);
                     make.height.mas_equalTo(44);
                     make.width.mas_equalTo(self.view.frame.size.width);
                 }];
                 }
                 username.text = [NSString stringWithFormat:@"你好，%@",remainderstr];
                 username.textColor = [UIColor colorWithRed:255/255.0 green:231/255.0 blue:148/255.0 alpha:1];
                 if (__kScreenHeight__ == 568) {
                     username.font = [UIFont systemFontOfSize:13];
                 }else{
                     username.font = [UIFont systemFontOfSize:15];
                 }
                 
                 
                 
              
                 
                 
            
                 
                 NSDictionary *zhanghuzichan = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *zhanghuzichan1= [zhanghuzichan objectForKey:@"invest"];
                 NSString *zhanghuzong = [zhanghuzichan1 objectForKey:@"total_assets"];//账户总资产
                 
#pragma mark - 账户总资产
                 if (!allmonay) {
                     
                 
                 allmonay = [[UILabel alloc]init];
                 [self.view addSubview:allmonay];
                 [allmonay mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.mas_equalTo(0.167*self.view.frame.size.height);
                     make.left.mas_equalTo(0);
                     make.width.mas_equalTo(self.view.frame.size.width);
                     make.height.mas_equalTo(self.view.frame.size.height*0.094);
                 }];
                 }
                 allmonay.textColor = [UIColor whiteColor];
                 allmonay.text = zhanghuzong;
                 allmonay.textAlignment = UITextAlignmentCenter;
                 if (__kScreenHeight__ == 568) {
                     allmonay.font = [UIFont systemFontOfSize:33];
                 }else{
                     allmonay.font = [UIFont systemFontOfSize:40];
                 }

                 
                 
                 
                 
                 
                 NSDictionary *daishou = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *daishou1= [daishou objectForKey:@"invest"];
                 NSString *benxi = [daishou1 objectForKey:@"collection_amount"];//待收本息
                 [[NSUserDefaults standardUserDefaults]setObject:benxi forKey:@"daishoubenxi"];
                 
#pragma mark - 本月待收金额due_in_principal
                 if (!monthmonay) {
                     
                 
                 monthmonay = [[UILabel alloc]init];
                 [self.view addSubview:monthmonay];
                 [monthmonay mas_makeConstraints:^(MASConstraintMaker *make) {
                     
                     if (__kScreenHeight__ == 568) {
                         make.top.mas_equalTo(0.38*self.view.frame.size.height);
                         make.left.mas_equalTo(0.589*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                         
                     }else if(__kScreenHeight__ > 667)
                     { make.top.mas_equalTo(0.355*self.view.frame.size.height);
                         make.left.mas_equalTo(0.589*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                         
                         
                     }else{
                         make.top.mas_equalTo(0.361*self.view.frame.size.height);
                         make.left.mas_equalTo(0.589*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                         
                     }
                 }];
                 }
                 monthmonay.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
                 monthmonay.text = [NSString stringWithFormat:@"%@",benxi];
                 if (__kScreenHeight__ == 568) {
                     monthmonay.font = [UIFont systemFontOfSize:17];
                 }else
                 {
                     monthmonay.font = [UIFont systemFontOfSize:20];
                 }
    
                 monthmonay.textAlignment = UITextAlignmentCenter;
                 
                 
                 NSDictionary *jibishu = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *jibishu1= [jibishu objectForKey:@"invest"];
                 NSString *jiba1 = [jibishu1 objectForKey:@"no_pay_number"];//待收几笔
                 [[NSUserDefaults standardUserDefaults]setObject:jiba1 forKey:@"daishoubenxi"];
                 

#pragma mark - 多少笔  no_pay_number
                 if (!howmuch) {
                     
                 
                 howmuch = [[UILabel alloc]init];
                 [self.view addSubview:howmuch];
                 [howmuch mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.mas_equalTo(self.view.frame.size.height*0.218+64);
                     make.left.mas_equalTo(0.81*self.view.frame.size.width);
                     make.width.mas_equalTo(0.188*self.view.frame.size.width);
                     make.height.mas_equalTo(0.075*self.view.frame.size.height);
                 }];
                 }
                 howmuch.text = [NSString stringWithFormat:@"(%@ 笔)",jiba1];
                 howmuch.textColor= [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
                 if (__kScreenHeight__ == 568) {
                     howmuch.font = [UIFont systemFontOfSize:12];
                 }else{
                     howmuch.font = [UIFont systemFontOfSize:14];
                 }
                 

                 
                 
                 
                 
                 NSDictionary *keyong= [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *keyong1= [keyong objectForKey:@"invest"];
                 NSString *yue = [keyong1 objectForKey:@"available"];//可用余额
                 [[NSUserDefaults standardUserDefaults]setObject:yue forKey:@"chongzhihouzhanghujine"];
#pragma mark - 可用余额
                 if (!remainder) {
                     
                 
                 remainder = [[UILabel alloc]init];
                 [self.view addSubview:remainder];
                 [remainder mas_makeConstraints:^(MASConstraintMaker *make) {
                     
                     if (__kScreenHeight__ == 568) {
                         make.top.mas_equalTo(0.38*self.view.frame.size.height);
                         make.left.mas_equalTo(0.088*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                     }else if(__kScreenHeight__ >667)
                     {
                         make.top.mas_equalTo(0.355*self.view.frame.size.height);
                         make.left.mas_equalTo(0.088*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                         
                     }else{
                         make.top.mas_equalTo(0.361*self.view.frame.size.height);
                         make.left.mas_equalTo(0.088*self.view.frame.size.width);
                         make.width.mas_equalTo(0.336*self.view.frame.size.width);
                         make.height.mas_equalTo(0.067*self.view.frame.size.height);
                     }
                     
                 }];
                 }
                 remainder.text = yue;
                 remainder.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
                 if (__kScreenHeight__ == 568) {
                     remainder.font=[UIFont systemFontOfSize:17];
                 }else{
                     remainder.font=[UIFont systemFontOfSize:20];
                 }


                 
                 
                 
                 
                 
                 
                 NSDictionary *kuaijieka = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *kuaijieka1 = [kuaijieka objectForKey:@"bankCard"];
                 NSString * kuaojiepanding = [kuaijieka1 objectForKey:@"hasDefaultBankCard"];
                 [[NSUserDefaults standardUserDefaults ]setObject:kuaojiepanding forKey:@"duandingkuaijie"];
                 
                 NSString * nima=  [[NSUserDefaults standardUserDefaults]objectForKey:@"duandingkuaijie"];
                 
                 int flii = [nima intValue];
                 if (flii == 1) {
                     
                     
                     NSDictionary *bangdingzhuangtai = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *bangdingzhuangtai1 = [bangdingzhuangtai objectForKey:@"bankCard"];
                     NSDictionary *bang2 = [bangdingzhuangtai1 objectForKey:@"defaultBankcardInfo"];
                     NSString *ding = [bang2 objectForKey:@"logo"];
                     NSLog(@"%@",ding);
                     
                     [[NSUserDefaults standardUserDefaults]setObject:ding forKey:@"morenlogo"];
                     
                     
                     NSDictionary *morenming = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *morenming1 = [morenming objectForKey:@"bankCard"];
                     NSDictionary *kaming1 = [morenming1 objectForKey:@"defaultBankcardInfo"];
                     NSString *kaming2 = [kaming1 objectForKey:@"bankname"];
                     NSLog(@"%@",kaming2);
                     
                     
                     [[NSUserDefaults standardUserDefaults]setObject:kaming2 forKey:@"morenname"];
                     
                     
                     
                     NSDictionary *morenkahao = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary *morenkahao1 = [morenkahao objectForKey:@"bankCard"];
                     NSDictionary *kahao1 = [morenkahao1 objectForKey:@"defaultBankcardInfo"];
                     NSString *kahao2 = [kahao1 objectForKey:@"card"];
                     NSString *biahao = [kahao1 objectForKey:@"bankcode"];
                     NSString *biaoid = [kahao1 objectForKey:@"id"];
                     NSString *biaoid1 = [kahao1 objectForKey:@"day"];
                     NSString *biaoid2 = [kahao1 objectForKey:@"single"];
                     
                     
                     [[NSUserDefaults standardUserDefaults]setObject:biahao forKey:@"biaohaoka"];
                     [[NSUserDefaults standardUserDefaults]setObject:kahao2 forKey:@"morenkahao"];
                     [[NSUserDefaults standardUserDefaults]setObject:biaoid forKey:@"idhaoba"];
                     [[NSUserDefaults standardUserDefaults]setObject:biaoid1 forKey:@"idhaoba1"];
                     [[NSUserDefaults standardUserDefaults]setObject:biaoid2 forKey:@"idhaoba2"];
                     
                     
                     
                     
                     
                 }
                 
                 NSDictionary *bangdingka = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary  *bangdingka1 = [bangdingka objectForKey:@"chinapnr"];
                 NSString *banghding2 = [bangdingka1 objectForKey:@"bind_bankcard"];
                 NSLog(@"%@",banghding2);
                 [[NSUserDefaults standardUserDefaults]setObject:banghding2 forKey:@"bangdingpuka"];
                 
                 
                 NSDictionary *huifuzhuangtai = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary *huifuzhuangtai1= [huifuzhuangtai objectForKey:@"chinapnr"];
                 NSString *zhuangtai = [huifuzhuangtai1 objectForKey:@"open_account"];
                 [[NSUserDefaults standardUserDefaults]setObject:zhuangtai forKey:@"huifuzhuangtai21"];
                 int dese = [zhuangtai intValue];
                 if (dese == 1) {
                     
                     
                     NSDictionary *yonghuzhanghao = [gerenzhongxin objectForKey:@"data"];
                     NSDictionary  *yonghuzhanghao1 = [yonghuzhanghao objectForKey:@"user_chinapnr_info"];
                     NSString *zhyh = [yonghuzhanghao1 objectForKey:@"usrid"];
                     NSLog(@"%@",zhyh);
                     if ([zhyh isKindOfClass:[NSNull class]]) {
                         
                     }else
                     {
                         
                         [[NSUserDefaults standardUserDefaults]setObject:zhyh forKey:@"kehuzhanghao"];
                         
                         NSLog(@"上班");
                     }
                     
                     
                 }
                 
                 NSDictionary *shifoubangdingphoen = [gerenzhongxin objectForKey:@"data"];
                 NSDictionary  *shifoubangdingphoen1 = [shifoubangdingphoen objectForKey:@"chinapnr"];
                 NSString *phone = [shifoubangdingphoen1 objectForKey:@"bind_phone"];
                 NSLog(@"%@",phone);
                 [[NSUserDefaults standardUserDefaults]setObject:phone forKey:@"phonebang"];
                 
                 
                 
             }
             [self performSelector:@selector(yanzhenghuodong) withObject:nil afterDelay:0.1];
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
    
}
- (void)loginActionbeng {
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
             
             
             
             
             
             
             
             
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             
         }];
}
-(void)yaoqingmapuanduan
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
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    [manager POST:@"http://debug.otouzi.com:8012/Showcode"
       parameters:@{}
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"%@",responseObject);
              
              NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
              
              objc = responseObject;
              NSString *codema = [objc objectForKey:@"code"];
              int cuen = [codema intValue];
              if (cuen != 200 ) {
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
                  
                  //                      UIAlertView *alerterroe = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                  //                                                                           message:@"登录过期！请重新登录"
                  //                                                                          delegate:self
                  //                                                                 cancelButtonTitle:@"确定"
                  //                                                                 otherButtonTitles:nil];
                  [self loginActionbeng];
                  //                      [alerterroe show];
              }
              else{
                  NSDictionary *qing = [objc objectForKey:@"data"];
                  NSString *qing1 = [qing objectForKey:@"status"];
                  int adc = [qing1 intValue];
                  NSLog(@"%d",adc);
                  if (adc == 1) {
                      [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"wuyaoqing"];
                  }
                  else if(adc == 0)
                  {
                      [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"wuyaoqing"];
                  }
              }
              
          } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
              
          }];
    
}
//AlertView消失事件

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
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
    // NSString *session = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    
    [manager GET:@"http://debug.otouzi.com:8012/user/logout"
      parameters:@{}
     
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSFileManager* fileManager=[NSFileManager defaultManager];
             
             NSString *path =
             [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
             
             [fileManager removeItemAtPath:path error:nil];
             
             BOOL hasPwd = [CLLockVC hasPwd];
             
             hasPwd = NO;
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tixianwebwangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bangkawangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chongzhiwangzhi"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"code1"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
             
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zhijietiao"];
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"yincang" object:self];
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"tuile" object:self];//重新获取session
             
             [NSThread sleepForTimeInterval:0.5f];
             
             
             AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
             TabbarViewController *tab = [[TabbarViewController alloc]init];
             delete.window.rootViewController = tab;
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
             
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             
         }];
    
    
}

-(void)myConponclicked:(UIButton *)sender{
    
    
    RedConponViewController *redEnvelopes = [[RedConponViewController alloc]init];
    redEnvelopes.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redEnvelopes animated:YES];
    

}

- (void)investclicked:(UIButton *)sender{
    
    MyInvestController *myInvestVC = [[MyInvestController alloc]init];
    myInvestVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myInvestVC animated:YES];
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

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



#pragma mark - 邀请好友
- (void)rightItemButtonAction:(UIButton *)sender{
    
    if (!_user_invitation_code_url) {
        
        
    }else{
    InvitationFriendController *invitationFriend =[[InvitationFriendController alloc]init];
    invitationFriend.hidesBottomBarWhenPushed = YES;
    invitationFriend.urlStr = _invitationUrl;//@"http://debug.otouzi.com:8012/Invitation/invite.html";
        invitationFriend.hrefShare = _hrefShare;
    [self.navigationController pushViewController:invitationFriend animated:YES];
    NSLog(@"邀请好友");
    }
    
    
}



-(void)yanzhenghuodong{
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
    
    
    [manager GET:@"http://debug.otouzi.com:8012/activity/pop"
      parameters:@{
                   
                   }
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"  %@",responseObject);
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             
             NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
             
             NSString *yonghuming1= [yonghuming objectForKey:@"desc"];
             
             
             NSString *shijian = [yonghuming objectForKey:@"created_at"];
             
             NSLog(@"%@",shijian);
             
             zhedang = [[UIControl alloc]
                        initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
             
             zhedang.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
             zhedang.hidden = YES;
//             [zhedang addTarget:self
//                         action:@selector(maskViewAction:)
//               forControlEvents:UIControlEventTouchUpInside];
//             
//             
             
             
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
                 UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(202*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
                 [tongyi setImage:[UIImage imageNamed:@"6ellBtn1@2x.png"]forState:UIControlStateNormal];
                 [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
                 [xieyiview addSubview:tongyi];
                 
                 UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth__-80, 40)];
                 [xieyiview addSubview:xuzhis];
                 xuzhis.text = yonghuming1;
                 xuzhis.font = [UIFont systemFontOfSize:13];
                 xuzhis.textAlignment = UITextAlignmentCenter;
                 
             }else if(__kScreenHeight__ == 667){
                 UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
                 [tongyi setImage:[UIImage imageNamed:@"6ellBtn1"]forState:UIControlStateNormal];
                 [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
                 [xieyiview addSubview:tongyi];
                 UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth__-80, 40)];
                 [xieyiview addSubview:xuzhis];
                 xuzhis.text = yonghuming1;
                 xuzhis.textAlignment = UITextAlignmentCenter;
                 
             }else{
                 UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
                 [tongyi setImage:[UIImage imageNamed:@"6ellBtn1"]forState:UIControlStateNormal];
                 [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
                 [xieyiview addSubview:tongyi];
                 UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(0, 20,__kScreenWidth__-80, 40)];
                 [xieyiview addSubview:xuzhis];
                 xuzhis.text = yonghuming1;
                 xuzhis.textAlignment = UITextAlignmentCenter;
                 
             }
             
             NSString *duandingxianshi = [[NSUserDefaults standardUserDefaults]objectForKey:@"huodongshijian"];
             
             
             if ([duandingxianshi isKindOfClass:[NSNull class]] || duandingxianshi == nil
                 || duandingxianshi == NULL) {
                 if([yonghuming1 isEqualToString:@"false"])
                 {
                     ;
                 }else {
                     [self showShareView];
                     [[NSUserDefaults standardUserDefaults]setObject:shijian forKey:@"huodongshijian"];
                 }
                 
             }else {
                 
                 
                 if ([shijian isEqualToString:duandingxianshi]) {
                     ;
                 }else{
                     [self showShareView];
                     [[NSUserDefaults standardUserDefaults]setObject:shijian forKey:@"huodongshijian"];
                 }
                 
             }
             
             
         }
         failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             
         }];
    
}
-(void)maskViewAction:(id)sender
{
    zhedang.hidden = YES;
    [self hideShareView];
}
- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = YES;
                     }];
    
}
-(void)xuzhitui:(id)sender
{
    
    zhedang.hidden = YES;
    [self hideShareView];
    
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
//创建遮盖视图
- (void)createRechargeView{
    
    
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
    _rechargeView.layer.cornerRadius = 3;
    
    if (iphone5x_4_0) {
        _rechargeView.frame = CGRectMake(40, 0.5*__kScreenHeight__-60, __kScreenWidth__-80,120);

    }else if (iphone6_4_7){
    
    
    
      _rechargeView.frame = CGRectMake(40, 0.5*__kScreenHeight__-60, __kScreenWidth__-80,130);
    }else if (iphone6Plus_5_5){
      _rechargeView.frame = CGRectMake(40, 0.5*__kScreenHeight__-60, __kScreenWidth__-80,135);
        
        
    }else{

        _rechargeView.frame = CGRectMake(40, 0.5*__kScreenHeight__-60, __kScreenWidth__-80,120);
        

    }
    
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_rechargeView];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:30/2];
    _contentLabel.text = @"您还未进行过充值或投资，请先进行充值以绑定一张银行卡";
    
    
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    
    [_rechargeView addSubview:_contentLabel];
    _contentLabel.frame = CGRectMake(20, 0.032*kScreenHeight,_rechargeView.width-40, 0.018*kScreenHeight) ;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: _contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ _contentLabel.text length])];
    [ _contentLabel setAttributedText:attributedString];
    [_contentLabel sizeToFit];
    
    
    
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 3;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_rechargeView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rechargeView.mas_centerX);
        make.top.equalTo(_contentLabel.mas_bottom).offset(0.028*kScreenHeight);
        make.width.mas_equalTo(0.230*kScreenWidth);
        make.height.mas_equalTo(0.052*kScreenHeight);
        
    }];
    
    
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [_lastWindow insertSubview:_maskView belowSubview:_rechargeView];
    
}



#pragma mark -充值窗口按钮点击事件

/*
 *确认按钮
 */

- (void)sureAction:(UIButton *)sender{
    
    
    
    [self hidePromptWindow];
    
}




#pragma mark - 提示充值信息
/*
 *显示提示框
 */
- (void)showPromptWindow{
    
    
    
    [UIView animateWithDuration:.35 animations:^{
        
        _rechargeView.hidden = NO;
        _maskView.hidden = NO;
    }];
}

/*
 *隐藏提示框
 */
- (void)hidePromptWindow{
    [UIView animateWithDuration:.35 animations:^{
        
        _rechargeView.hidden = YES;
        _maskView.hidden = YES;
        
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
