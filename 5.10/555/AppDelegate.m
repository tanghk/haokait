//
//  AppDelegate.m
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//


/**
 *
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */

/*
                    _ooOoo_
                   o8888888o
                   88" . "88
                   (| -_- |)
                   O\  =  /O
                ____/`---'\____
              .'  \\|     |//  `.
             /  \\|||  :  |||//  \
            /  _||||| -:- |||||-  \
            |   | \\\  -  /// |   |
            | \_|  ''\---/''  |   |
            \  .-\__  `-`  ___/-. /
          ___`. .'  /--.--\  `. . __
       ."" '<  `.___\_<|>_/___.'  >'"".
      | | :  `- \`.;`\ _ /`;.`/ - ` : | |
      \  \ `-.   \_ __\ /__ _/   .-` /  /
 ======`-.____`-.___\_____/___.-`____.-'===
 
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
             佛祖保佑       永无BUG
 */
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
#import "MainViewController.h"
#import "CLLockVC.h"
#import "ChanpinViewController.h"
#import "TabbarViewController.h"
#import "DengluViewController.h"
#import "VerifyPwdViewController.h"


//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>


//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
#import "UICommons.h"




//新浪微博SDK头文件
#import "WeiboSDK.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//#import <TencentOpenAPI/QQApi.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
//#import <QZoneConnection/ISSQZoneApp.h>
@interface AppDelegate ()
{
@private Reachability *hostReach;
    
    
    NSTimer *_timer;
}
@property(nonatomic,strong)NSString *session;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSUserDefaults standardUserDefaults]setObject:@"a" forKey:@"witch"];

    NSString *type = @"0";
    [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];//验证密码存入
    
  

    NSLog(@"－－－－－－－－－－程序启动－－－－－－－－－");
      
    NSLog(@"屏幕宽%f",  [UIScreen mainScreen].bounds.size.width);
    NSLog(@"屏幕高%f",  [UIScreen mainScreen].bounds.size.height);

    
    [NSThread sleepForTimeInterval:2.0];
    [_window makeKeyAndVisible];
 
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    TabbarViewController *tabbarcontroller = [[TabbarViewController alloc]init];
    self.window.rootViewController = tabbarcontroller;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    
    
//     引导页在程序中只会显示一次  
 
     NSUserDefaults* defs1 = [NSUserDefaults standardUserDefaults];
     int aa=[[defs1 objectForKey:@"ishelp"] intValue];
     if (aa!=5) {
     [defs1 setObject:@"5" forKey:@"ishelp"];
    //  [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"SetLater"];
     [self helpScroll];
     
     [defs1 synchronize];
         
     }else{
//        int second=[[defs1 objectForKey:@"second"] intValue];
//         if (second != 2) {
//             [self setCoreLock];
//              [defs1 setObject:@"2" forKey:@"second"];
//                [defs1 synchronize];
//         }else{
//         
         
         
      //   }
       [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"fromMain"];
       // [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"SetLater"];
         [self coreLock];
         
     }
   
    

//    [self helpScroll];
    
    
    
    
    
    
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    
    
    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/lauchdic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    BOOL notFirstLauch = [[notFirstDic objectForKey:@"notFirstLauch"] boolValue];
    

    if (notFirstLauch == YES) {
              
        
//        //启动页
//        LauchViewController *viewCtrl = [[LauchViewController alloc] init];
//        self.window.rootViewController = viewCtrl;
        
    } else {
//        //引导页
//        GuideViewController *viewCtrl = [[GuideViewController alloc] init];
//        self.window.rootViewController = viewCtrl;
        
        //以后打开app, 不是第一次打开
        // 属性列表
        // NSArray\NSDictionary
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@YES forKey:@"notFirstLauch"];
        
        [dic writeToFile:path atomically:YES];
    }
    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */

    [ShareSDK registerApp:@"d45a32d6e45b1"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformSubTypeQZone),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatFav)
                            ]
                 onImport:^(SSDKPlatformType platformType){
                     switch (platformType) {
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector  connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformSubTypeQZone:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                     
                     
                     
                 }          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     
                     switch (platformType)
                     {
                             
                             
                         case SSDKPlatformTypeSinaWeibo:
                             //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"3483920932"
                                                       appSecret:@"ead95995f9b7dbda1a5aeb02ed4055d0"
                                                     redirectUri:@"http://otouzi.com"
                                                        authType:SSDKAuthTypeBoth];
                             break;
                             
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wxb7a18663a73ae6ba"
                                                   appSecret:@"75b23d713ed973dd17030d5b7c86725f"];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1105065451"
                                                  appKey:@"hu0cyq5jpQtMxEwa"
                                                authType:SSDKAuthTypeBoth];
                             break;
                         case SSDKPlatformSubTypeQZone:
                             [appInfo SSDKSetupQQByAppId:@"1105065451"
                                                  appKey:@"hu0cyq5jpQtMxEwa"
                                                authType:SSDKAuthTypeBoth];
                             
                               break;
                             case SSDKPlatformSubTypeWechatTimeline:
                             [appInfo SSDKSetupWeChatByAppId:@"wxb7a18663a73ae6ba"
                                                   appSecret:@"75b23d713ed973dd17030d5b7c86725f"];

                         default:
                             break;
                     }
                     
                 }];
    
    


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"EnterBackground"];

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.88;
    effectView.frame = CGRectMake(0,  0, kScreenWidth,kScreenHeight);
    [self.window addSubview:effectView];
    
    NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];//设置手势密码
    if ([setType isEqualToString:@"1"]) {

        /*
         毛玻璃的样式(枚举)
         UIBlurEffectStyleExtraLight,
         UIBlurEffectStyleLight,
         UIBlurEffectStyleDark
         */
      
        
        
        /*
         *@"coreLockType" 验证手势密码
         *SetLockType 设置手势密码
         
         */
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"coreLockType"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults ]objectForKey:@"coreLockType"]);
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSString *witch = [[NSUserDefaults standardUserDefaults]objectForKey:@"witch"] ;
        
        
      
    }else{
    
   
    
    
    }
    
//    
//    
//    NSString *Background = @"1";
//    
//    [[NSUserDefaults standardUserDefaults]setObject:Background forKey:@"BackgroundVerificationCoreLock"];//后台验证密码成功
//    
//    
//    //
//    NSLog(@"最后选中vc%@",witch);
//    

    

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"EnterBackground"];

    effectView.hidden = YES;
    [self setCoreLock];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "----._55" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_55" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_55.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

            abort();
        }
    }
}
-(UIButton*)buttonPhoto:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title select:(SEL)sel Tag:(int)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:Hphoto] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:photo] forState:UIControlStateHighlighted];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    [ViewA addSubview:button];
    return button;
}
-(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect{
    UIImageView*view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    view.frame=rect;
    return view;
}
-(void)helpScroll{
    
    scrVl=[[UIScrollView alloc] init];
    scrVl.pagingEnabled = YES;
    scrVl.delegate=self;
    scrVl.frame=CGRectMake(0, 0,self.window.frame.size.width, self.window.frame.size.height);
    scrVl.bounces = NO;
    scrVl.contentSize=CGSizeMake(self.window.frame.size.width*4, self.window.frame.size.height);
    [self.window addSubview:scrVl];
    
    
    
    
    
    for (int i=0; i<4; i++) {
        [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%dhelp%d",5,i+1] rect:CGRectMake(self.window.frame.size.width*i, 0,self.window.frame.size.width ,self.window.frame.size.height)]];
    }
    
    
    [self buttonPhoto:nil hilPhoto:@"helpBtn.png" rect:CGRectMake(self.window.frame.size.width*3+105,self.window.frame.size.height-50, 294/2,67/2) title:@"" select:@selector(hiddenScroller:) Tag:1 View:scrVl textColor:[UIColor whiteColor]];
    
    
    thePGLeft=[[PageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    
    thePGLeft.dotColorCurrentPage=[UIColor yellowColor];
    
    thePGLeft.center=CGPointMake(ScreenWidth/2,120*ScreenHeight/1334);
    
    thePGLeft.numberOfPages=4;
    [self.window addSubview:thePGLeft];
    
}
-(void)hiddenScroller:(id)sender
{
    
    
    
    [UIView animateWithDuration:2.0
                     animations:^{
                         scrVl.alpha = 0.0;
                         thePGLeft.alpha=0.0;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
}

#pragma UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [thePGLeft setCurrentPage:offset.x / bounds.size.width];
    
}



#pragma mark - 验证手势密码逻辑
- (void)coreLock{
    
    /*
     *SetLockType 设置手势密码
     *coreLockType 验证手势密码
     *SetLater 稍后设置密码
     */
    
    
    NSString *setLater =[[NSUserDefaults standardUserDefaults]objectForKey:@"SetLater"];
    if ([setLater intValue]==1) {
           
        
    }else{
        
    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
    if (panduan == 200 ) {
        
        
        
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
                            NSLog(@"密码正确");
                            maskView.hidden = YES;
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
                    NSLog(@"haimei");
                    [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                        
                        NSString *type = @"1";
                        [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];
                        NSLog(@"密码设置成功");
                        [lockVC dismiss:0.35f];
                        
                              NSString *setType = @"1";
                        [[NSUserDefaults standardUserDefaults]setObject:setType forKey:@"SetLockType"];//设置手势密码
                        
                        
                    }];
                }
                
            }
        }
        
        
        
        
    }else
    {
        
        
    }
    
    
    
    }
    
    
}
#pragma mark  - 进入后台
-(void)setCoreLock{

    
    NSString *setLater =[[NSUserDefaults standardUserDefaults]objectForKey:@"SetLater"];
    if ([setLater intValue]==1) {
        
        
    }else{
        
        
        NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
        int panduan = [banduan intValue];
        if (panduan == 200 ) {
            
            
            
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
                                NSLog(@"密码正确");
                                maskView.hidden = YES;
                                NSString *type = @"1";
                                [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];//验证密码成功
                                [lockVC dismiss:0.35f];
                                
                                
                                
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
            
            
            
            
        }else
        {
            
            
        }
        
        
        
    }

}

@end
