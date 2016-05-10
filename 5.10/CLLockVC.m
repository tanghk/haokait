
//
//  CLLockVC.m
//  CoreLock
//
//  Created by 成林 on 15/4/21.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockVC.h"
#import "CoreLockConst.h"
#import "CoreArchive.h"
#import "CLLockLabel.h"
#import "CLLockNavVC.h"
#import "CLLockView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DengluViewController.h"
#import "UICommons.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "CLLockInfoView.h"
#import "Masonry.h"
#import "promptLabel.h"
#import "gerenzhanghuViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "denglu02ViewController.h"
@interface CLLockVC ()
{
    UIButton * _resetButton;
    UIButton * _forgertPwd;//忘记手势密码
    UIButton *_closeBtn;
    BOOL isExistenceNetwork;
    
    
    BOOL typeAttribute;
    
    
    int count;//


}
/** 操作成功：密码设置成功、密码验证成功 */
@property (weak, nonatomic) IBOutlet CLLockInfoView *infoView;
@property (nonatomic,copy) void (^successBlock)(CLLockVC *lockVC,NSString *pwd);

@property (nonatomic,copy) void (^forgetPwdBlock)();

@property (weak, nonatomic) IBOutlet CLLockLabel *label;

@property (nonatomic,copy) NSString *msg;
@property (nonatomic,copy) NSString *msgTop;


@property (weak, nonatomic) IBOutlet CLLockView *lockView;

@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,strong) UIBarButtonItem *resetItem;

@property (weak, nonatomic) IBOutlet promptLabel *enterCoreLock;

@property (nonatomic,copy) NSString *modifyCurrentTitle;


@property (weak, nonatomic) IBOutlet UIView *actionView;

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic , strong)UIView *forgetPwdView;
@property (nonatomic, strong)UIView *startPasswordView;


/** 直接进入修改页面的 */
@property (nonatomic,assign) BOOL isDirectModify;



@end

@implementation CLLockVC
- (void)viewDidLoad {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

  //  [self.forgetBtn setEnlargeEdgeWithTop:8 right:5 bottom:8 left:5];
    [super viewDidLoad];
    
    //alertview
    [self createForgetPwdView];
    
    NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];
       if ([setType isEqualToString:@"1"]) {
           ;
       }else{
           NSString *setLater =[[NSUserDefaults standardUserDefaults]objectForKey:@"SetLater"];
           if ([setLater intValue]==1) {
               
               ;
               
           }else{
               [self startPassword];
 
           
           
           }
           
           
           
           
       }
  

    //控制器准备
    [self vcPrepare];
    
    //数据传输
    [self dataTransfer];
    
    //事件
    [self event];
    
    
    
    count = 1;
    BOOL hasPwd = [CLLockVC hasPwd];
    
//    if(!hasPwd){
//    
//        NSLog(@"你还没有设置密码，请先设置密码");
//    }else {
//       
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
        
     
            
  
        NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"samenamede"];
     //   NSString *userIcon = [[NSUserDefaults standardUserDefaults]objectForKey:@"userICon"];

            self.infoView.hidden = YES;
       // NSLog(@"用户头像：%@",userIcon);
    
            
            
            NSString *regex = @"^[1][3-8]\\d{9}$";//^[0-9]*$
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            
            if ([predicate evaluateWithObject:userName] == YES) {
               
                NSString*string1 =userName;
                NSString*  ac= [string1 substringToIndex:3];//截取掉下标7之后的字符串
                NSLog(@"截取的值为：%@",ac);
                NSString *ad=   [string1 substringFromIndex:7];//截取掉下标2之前的字符串
                NSLog(@"截取的值为：%@",ad);
                
                
                _userNameLabel.text =[NSString stringWithFormat:@"欢迎您：%@***%@",ac,ad] ;
                _userNameLabel.font = [UIFont systemFontOfSize:18];
                
                NSLog(@"全是数字");
                
            }else{
              NSLog(@"有英文字母");
                
              
                _userNameLabel.text =[NSString stringWithFormat:@"欢迎您：%@",userName] ;
                _userNameLabel.font = [UIFont systemFontOfSize:18];


            
            }
   
            
            

        }





/*
 *  事件
 */
-(void)event{
    
    /*
     *  设置密码
     */
    
    /** 开始输入：第一次 */
    self.lockView.setPWBeginBlock = ^(){
        typeAttribute = NO;
        [self.label showNormalMsg:@" "];
        [self.enterCoreLock showNormalMsg:CoreLockPWDTitleFirst];
        
        
       
        
        
    };
    
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^(){
      
        [self.label showNormalMsg:@""];
        [self.enterCoreLock showNormalMsg:CoreLockPWDTitleConfirm];
        
        
       
    };

    
    
    
    /** 密码长度不够 */
    self.lockView.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount){
        
        
      [self.label showWarnMsg:[NSString stringWithFormat:@"最少连接%@个点，请重新输入",@(CoreLockMinItemCount)]];//最少连接%@个点，请重新绘制
    };
    
    /** 两次密码不一致 */
    self.lockView.setPWSErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow){
       
        [self.label showWarnMsg:CoreLockPWDDiffTitle];
        

     
    };
    
    
    
    
    
#pragma mark - 重置手势密码

    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^(NSString *pwdM){
        [self resetButton];
        [self.label showNormalMsg:@""];
        [self.enterCoreLock showNormalMsg:CoreLockPWDTitleConfirm];
        self.modifyCurrentTitle = CoreLockPWDTitleConfirm;
        self.infoView.success=YES;
        self.infoView.pwd = pwdM;
        [self.infoView setNeedsDisplay];
        
    };
    
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd){
      
        
        //存储密码
        [CoreArchive setStr:pwd key:CoreLockPWDKey];
        
        //禁用交互
        self.view.userInteractionEnabled = NO;
        
        if(_successBlock != nil) _successBlock(self,pwd);
        
        if(CoreLockTypeModifyPwd == _type){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        }
    };
    
    
    
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^(){
        
       [self.label showNormalMsg:@""];
        [self.enterCoreLock showNormalMsg:CoreLockVerifyNormalTitle];
    };
    
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd){
    
        //取出本地密码
        NSString *pwdLocal = [CoreArchive strForKey:CoreLockPWDKey];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
    
            if(CoreLockTypeVeryfiPwd == _type){
                
                                  //禁用交互
                self.view.userInteractionEnabled = NO;
                
            }else if (CoreLockTypeModifyPwd == _type){//修改密码
                
                  [self.label showNormalMsg:@""];
                  [self.enterCoreLock showNormalMsg:@"请设置新的手势密码"];
                
                


#pragma mark - 隐藏用户名
                self.title = @"";
                _iconImageView.alpha = 0.0;
               self.modifyCurrentTitle =@"请设置新的手势密码";// CoreLockPWDTitleFirst;
;

                _userNameLabel.hidden = NO;
                 self.infoView.hidden = NO;
            
                
            }
            
            if(CoreLockTypeVeryfiPwd == _type) {
             
                if(_successBlock != nil) _successBlock(self,pwd);
            }
            
        }else{//密码不一致
         
         NSString * reset = [[NSUserDefaults standardUserDefaults]objectForKey:@"modify"];
            if ([reset isEqualToString:@"modify"]) {
           
                [self.label showWarnMsg:CoreLockPWDDiffTitle];
                
            
            
            }else{

                if (count == 5) {
                    
                    [self performSelector:@selector(loginAcrion) withObject:nil afterDelay:0.5];
                    
                    
                    count =1;
                }else{
                    
                    NSString *waringStr = [NSString stringWithFormat:@"密码错误，可以再试%d次",5-count];
                    [self.label showWarnMsg:waringStr];
                    
                    
                    
                    count++;
                }

            
            }
            
            
        }
        
        return res;
    };
    
    
    
    /*
     *  修改
     */
    
    /** 开始 */
    self.lockView.modifyPwdBlock =^(){
        
        typeAttribute =YES;
        [self.label showNormalMsg:@""];
        [self.enterCoreLock  showNormalMsg:self.modifyCurrentTitle];
        
    };
    
    
}






/*
 *  数据传输
 */
-(void)dataTransfer{
    
      [self.enterCoreLock showNormalMsg:self.msg];
    
    //传递类型
    self.lockView.type = self.type;
}







/*
 *  控制器准备
 */
-(void)vcPrepare{

    if (iphone6Plus_5_5) {
        //设置背景色
     
        self.view.backgroundColor = kColorMain;
    }else{
  
        self.view.backgroundColor = kColorMain;

    }
    
    //初始情况隐藏
    self.navigationItem.rightBarButtonItem = nil;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //默认标题
    self.modifyCurrentTitle = CoreLockModifyNormalTitle;
    // self.enterCoreLock.text = @"请输入原手势密码";
    if(CoreLockTypeModifyPwd == _type) {
        
        _actionView.hidden = YES;
        
        [_actionView removeFromSuperview];

        if(_isDirectModify)return;
   
#pragma mark - 修改手势密码
        
        if(!_forgertPwd){
            
            _forgertPwd = [UIButton buttonWithType:UIButtonTypeSystem];
            _forgertPwd.frame = CGRectMake(0, kScreenHeight-57, kScreenWidth, 20);
            _forgertPwd.titleLabel.font = Font(15);
            [_forgertPwd setTitle:@"忘记手势密码" forState:UIControlStateNormal];
            [_forgertPwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_forgertPwd addTarget:self
                             action:@selector(forgertPwdAction)
                   forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:_forgertPwd];
 
        }
        
        if (!_closeBtn) {
            
            _closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            _closeBtn.frame = CGRectMake(kScreenWidth-13-77/3, 103/3, 77/3,77/3);
           [_closeBtn setEnlargeEdgeWithTop:5 right:5  bottom:5  left:5 ];
            [_closeBtn setImage:[UIImage imageNamed:@"closeCore@3x"]
                       forState:UIControlStateNormal];
            [_closeBtn addTarget:self
                          action:@selector(closeCore)
                forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:_closeBtn];
            
            
            
        }
        
        
        
    }
    
    if(![self.class hasPwd]){
        [_modifyBtn removeFromSuperview];
    }
}

-(void)dismiss{
    [self dismiss:0];
}



/*
 *  密码重设
 */
-(void)setPwdReset{
    self.infoView.success=NO;
    self.infoView.pwd = nil;
    [self.infoView setNeedsDisplay];
 [self.label showNormalMsg:@""];
    if (typeAttribute ==YES) {
          [self.enterCoreLock showNormalMsg:CoreLockNew];
           self.modifyCurrentTitle =@"请设置新的手势密码";// CoreLockPWDTitleFirst;
        
    }else{
    
      [self.enterCoreLock showNormalMsg:CoreLockPWDTitleFirst];
    }
  
    

    //隐藏
    self.navigationItem.rightBarButtonItem = nil;
    
    //通知视图重设
    [self.lockView resetPwd];
    
    
    [_resetButton removeFromSuperview];
    _resetButton = nil;
}


/*
 *  忘记密码
 */
-(void)forgetPwd{
   

    
    
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    
   DengluViewController *login = [[DengluViewController alloc]init];
    
    [self.navigationController pushViewController:login animated:YES];
    
    
}

/*
 *  修改密码
 */
-(void)modiftyPwd{
    
}








/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
+(BOOL)hasPwd{
    
    NSString *pwd = [CoreArchive strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}




/*
 *  展示设置密码控制器
 */
+(instancetype)showSettingLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC,NSString *pwd))successBlock{
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"设置手势密码";
    
    //设置类型
    lockVC.type = CoreLockTypeSetPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showVerifyLockVCInVC:(UIViewController *)vc forgetPwdBlock:(void(^)())forgetPwdBlock successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"手势解锁";
    
    //设置类型
    lockVC.type = CoreLockTypeVeryfiPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    lockVC.forgetPwdBlock = forgetPwdBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showModifyLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    
    
    
    
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"修改密码";
    
    //设置类型
    lockVC.type = CoreLockTypeModifyPwd;
    
    //记录
    lockVC.successBlock = successBlock;
    
    return lockVC;
}





+(instancetype)lockVC:(UIViewController *)vc{
    
    CLLockVC *lockVC = [[CLLockVC alloc] init];

    lockVC.vc = vc;
    
    CLLockNavVC *navVC = [[CLLockNavVC alloc] initWithRootViewController:lockVC];
    navVC.navigationBar.hidden = YES;
    
    
    
    
    
    
    NSString *witch =   [[NSUserDefaults standardUserDefaults]objectForKey:@"witch"];
    

    NSString *fromAppDelegate =   [[NSUserDefaults standardUserDefaults] objectForKey: @"fromMain"];
    
    if ([fromAppDelegate intValue] ==1) {
      
          if ([ witch isEqualToString:@"a"]||(![witch isKindOfClass:[NSString class]])) {
              
              [UIApplication sharedApplication].keyWindow.rootViewController = navVC;

          }else{
              [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:navVC animated:YES completion:^(void){}];

          }
        
    }else if ([fromAppDelegate intValue] ==2){
    
          [UIApplication sharedApplication].keyWindow.rootViewController = navVC;
    
    }else
    

    {
        
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:navVC animated:YES completion:^(void){}];
        
    }


    
    return lockVC;
    
    
    
    
    
    
    
    
    
  }



-(void)setType:(CoreLockType)type{
    
    _type = type;
    
    //根据type自动调整label文字
    [self labelWithType];
}



/*
 *  根据type自动调整label文字
 */
-(void)labelWithType{
    
    if(CoreLockTypeSetPwd == _type){//设置密码
        
        self.msg = CoreLockPWDTitleFirst;
        
      
    }else if (CoreLockTypeVeryfiPwd == _type){//验证密码
        
        self.msg = CoreLockVerifyNormalTitle;
        
    }else if (CoreLockTypeModifyPwd == _type){//修改密码
        
       self.msg = CoreLockModifyNormalTitle;
        
            }
}




/*
 *  消失
 */
-(void)dismiss:(NSTimeInterval)interval{
   
   // [self removeFromParentViewController];
    
   // [self reloadInputViews];
  
    
    NSString *witch =   [[NSUserDefaults standardUserDefaults]objectForKey:@"witch"];
    
    NSString *fromAppDelegate =   [[NSUserDefaults standardUserDefaults] objectForKey: @"fromMain"];
    
    if ([fromAppDelegate intValue] ==1) {
        
        if ([ witch isEqualToString:@"a"]||(![witch isKindOfClass:[NSString class]])) {
            TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
            tabbarcontroller.selectedIndex =0;
            [UIApplication sharedApplication].keyWindow.rootViewController =tabbarcontroller;
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"fromMain"];
            
        }else{
        
        
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
            });
            

        
        }
    }else if([fromAppDelegate intValue] ==2){
        
        
        TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
        tabbarcontroller.selectedIndex =3;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbarcontroller;
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"fromMain"];
        
        
        
    }else{
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
           
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
        });
        
     
    }


   
 }


/*
 *  重置
 */
-(void)resetButton{
    [[NSUserDefaults standardUserDefaults]setObject:@"modify" forKey:@"modify"];
    

    [_forgertPwd removeFromSuperview];
    _forgertPwd =nil;
    if (!_resetButton) {
        
    
   _resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _resetButton.frame = CGRectMake(0, kScreenHeight-80, kScreenWidth, 40);
        
    [_resetButton setTitle:@"重新输入手势密码" forState:UIControlStateNormal];
    [_resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_resetButton addTarget:self
                    action:@selector(setPwdReset)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_resetButton];
    
    }
    
    
//    if(_resetItem == nil){
//        //添加右按钮
//        _resetItem= [[UIBarButtonItem alloc] initWithTitle:@"重设" style:UIBarButtonItemStylePlain target:self action:@selector(setPwdReset)];
//    }
//    
  }

#pragma mark - 忘记手势密码
- (IBAction)forgetPwdAction:(id)sender {
    _forgetPwdView.hidden = NO;
    
    //[self dismiss:0];
   //if(_forgetPwdBlock != nil) _forgetPwdBlock();
}
#pragma mark - 修改手势密码
/*
 *修改密码
 */
- (IBAction)modifyPwdAction:(id)sender {
    
    
    
    }


#pragma mark - 开启手势密码 .忘记手势密码
- (void)startPassword{

    //开启手势密码
    _startPasswordView = [[UIView alloc]init];
   // _startPasswordView.frame = CGRectMake(126*kWidthScale, 580*kWidthScale, kScreenWidth - (126+126)*kWidthScale, 198/2);
    //_startPasswordView.hidden = YES;
    _startPasswordView.layer.cornerRadius = 5;
    _startPasswordView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_startPasswordView];
    
    
    [_startPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(0.706*kScreenWidth);
        make.height.mas_equalTo(0.213*kScreenHeight);
        
    }];
    
    

    //文本内容
    UILabel *contentLabel = [[UILabel alloc]init];
   // contentLabel.frame = CGRectMake(0, 36*kWidthScale, _startPasswordView.width, 24/2);
    contentLabel.text = @"为了您的安全，请设置手势密码";
    //contentLabel.layer.borderWidth = 1;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:28/2];
    
    [_startPasswordView addSubview:contentLabel];
  
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startPasswordView.mas_left);
        make.right.equalTo(_startPasswordView.mas_right);
        make.top.equalTo(_startPasswordView.mas_top).offset(0.054*kScreenHeight);
        make.height.mas_equalTo(28/2);
        
    }];

    //忽略按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  cancleButton.frame = CGRectMake(49*kWidthScale, 97/2, (_startPasswordView.width-(49+49+26)*kWidthScale)/2 ,65*kWidthScale);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = kcolorFontGray;
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 6;
    [cancleButton setTitle:@"稍后设定" forState:UIControlStateNormal];
    cancleButton.tag = 1001;
    [cancleButton addTarget:self
                     action:@selector(cancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_startPasswordView addSubview:cancleButton];
    
    //确认
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // sureButton.frame = CGRectMake((49+26)*kWidthScale+(_startPasswordView.width-(49+49+26)*kWidthScale)/2, 97/2, (_startPasswordView.width-(49+49+26)*kWidthScale)/2 ,65*kWidthScale);
    [sureButton setTitle:@"开启手势" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 6;
    sureButton.tag = 1002;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [_startPasswordView addSubview:sureButton];
    
    
    
    [ sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startPasswordView.mas_left).offset(0.083*kScreenWidth);
        make.bottom.equalTo(_startPasswordView.mas_bottom).offset(-0.031*kScreenHeight);
        //make.width.mas_equalTo(0.246*kScreenWidth);
        make.height.mas_equalTo(0.058*kScreenHeight);
        
    }];
    
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sureButton.mas_right).offset(0.054*kScreenWidth);
        make.bottom.equalTo(_startPasswordView.mas_bottom).offset(-0.031*kScreenHeight);
        make.width.equalTo(sureButton.mas_width);
        make.height.mas_equalTo(0.058*kScreenHeight);
        make.right.equalTo(_startPasswordView.mas_right).offset(-0.083*kScreenWidth);
        
        
    }];





}


/*
 *忘记密码点击事件方法
 */
- (void)createForgetPwdView{

    //关注我们父视图
    _forgetPwdView = [[UIView alloc]init];
   // _forgetPwdView.frame = CGRectMake(126*kWidthScale, 580*kWidthScale, kScreenWidth - (126+126)*kWidthScale, 198/2);
    _forgetPwdView.hidden = YES;
    _forgetPwdView.backgroundColor = [UIColor whiteColor];
    _forgetPwdView.layer.cornerRadius = 6;
    [self.view addSubview:_forgetPwdView];
    
    
    
    [_forgetPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(0.706*kScreenWidth);
        make.height.mas_equalTo(0.213*kScreenHeight);
        
    }];
    
    
    
    
    
    //文本内容
    UILabel *contentLabel = [[UILabel alloc]init];
   // contentLabel.frame = CGRectMake(0, 36*kWidthScale, _forgetPwdView.width, 24/2);
        contentLabel.text = @"忘记手势密码，需重新登录";
    //contentLabel.layer.borderWidth = 1;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:28/2];
    
    [_forgetPwdView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_forgetPwdView.mas_left);
        make.right.equalTo(_forgetPwdView.mas_right);
        make.top.equalTo(_forgetPwdView.mas_top).offset(0.054*kScreenHeight);
        make.height.mas_equalTo(28/2);
        
    }];
    
    
    
    
    //忽略按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
   
      // cancleButton.frame = CGRectMake((49+26)*kWidthScale+(_forgetPwdView.width-(49+49+26)*kWidthScale)/2, 97/2, (_forgetPwdView.width-(49+49+26)*kWidthScale)/2 ,65*kWidthScale);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = kcolorFontGray;
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 6;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.tag = 2001;
    [cancleButton addTarget:self
                     action:@selector(cancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_forgetPwdView addSubview:cancleButton];
    
    
    
    
    
    
    //去登录按钮
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];

   //  sureButton.frame = CGRectMake(49*kWidthScale, 97/2, (_forgetPwdView.width-(49+49+26)*kWidthScale)/2 ,65*kWidthScale);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    sureButton.tag = 2002;
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 6;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [_forgetPwdView addSubview:sureButton];
    
    [ sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_forgetPwdView.mas_left).offset(0.083*kScreenWidth);
        make.bottom.equalTo(_forgetPwdView.mas_bottom).offset(-0.031*kScreenHeight);
        //make.width.mas_equalTo(0.246*kScreenWidth);
        make.height.mas_equalTo(0.058*kScreenHeight);
        
    }];

    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sureButton.mas_right).offset(0.054*kScreenWidth);
        make.bottom.equalTo(_forgetPwdView.mas_bottom).offset(-0.031*kScreenHeight);
        make.width.equalTo(sureButton.mas_width);
        make.height.mas_equalTo(0.058*kScreenHeight);
        make.right.equalTo(_forgetPwdView.mas_right).offset(-0.083*kScreenWidth);

        
    }];
    


}

#pragma  mark - forgetPwdViewAction
- (void)cancleAction: (UIButton *)sender{

    switch (sender.tag) {
        case 1001:
            [self changAction];
            NSLog(@"修改");

            break;
         case 2001:
              _forgetPwdView.hidden = YES;
        default:
            break;
    }
  


}

- (void)sureAction: (UIButton *)sender{
    
    switch (sender.tag) {
        case 1002:
             _startPasswordView.hidden = YES;
                  break;
          case 2002:
           
            
            
            
            [self loginAcrion];
        default:
            break;
    }
//
//    DengluViewController *loginVC = [[DengluViewController alloc]init];
//       [self presentViewController:loginVC animated:YES completion:^{
//           
//           [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"code1"];
//           
//
//   }];
}

-(void)changAction{
    _startPasswordView.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"SetLater"];
    
    
    
//    CLLockVC *lockVC = [[CLLockVC alloc] init];
//    
//    lockVC.title = @"修改密码";
//    
//    lockVC.isDirectModify = YES;
//    
//    //设置类型
//    lockVC.type = CoreLockTypeModifyPwd;
//    
//    [self.navigationController pushViewController:lockVC animated:YES];
//
    [self dismiss:0.25];

}

-(void)loginAcrion{
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
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"yincang" object:self];
             
             
             [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"fromCoreLock"];

             [NSThread sleepForTimeInterval:0.5f];
             //
             //             DengluViewController *touziba = [[DengluViewController alloc]init];
             
             AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
             TabbarViewController *tab = [[TabbarViewController alloc]init];
             delete.window.rootViewController = tab;
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
             
        
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             
         }];
    
    // self.login.selected = !self.login.selected;

}

#pragma mark - mark 忘记手势密码 跳转
- (void)forgertPwdAction{

  _forgetPwdView.hidden = NO;

}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    
    
    [self.view removeFromSuperview];
    


}
- (void)closeCore{


    [self dismiss:0.25];
    

}
-(void)startCoreLock{



    
    


}
@end
