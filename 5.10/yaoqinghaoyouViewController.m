//
//  yaoqinghaoyouViewController.m
//  555
//
//  Created by 李浩宇 on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "yaoqinghaoyouViewController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UICommons.h"
#import "UIViewExt.h"
#import "guizeViewController.h"
@interface yaoqinghaoyouViewController ()
{
    UILabel *yaoqingma;
}

@end

@implementation yaoqinghaoyouViewController
- (void)viewWillAppear:(BOOL)animated{
   [ super viewWillAppear:animated];
    [self createShareView];
     [self yaoqingma];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    UIColor *coloer = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.view.backgroundColor = coloer;
    
    
    UIImage *img = [UIImage imageNamed:@"6inviteFriends_01@2x.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];

    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(yaoqing12:) forControlEvents:UIControlEventTouchUpInside];

    //活动规则按钮
    
    UIButton *huodongguize  = [[UIButton alloc]initWithFrame:CGRectMake(599*__kScreenWidth__/750, 53*__kScreenHeight__/1334, 127*__kScreenWidth__/750, 48*__kScreenHeight__/1334)];
    UIImage *huo = [UIImage imageNamed:@"6inviteFriends_16@2x.png"];
    [huodongguize setBackgroundImage:huo forState:UIControlStateNormal];
    [self.view addSubview:huodongguize];
    [huodongguize addTarget:self action:@selector(yaoqing:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //简介
    
    UIImageView *jianjie = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 695*__kScreenHeight__/1334)];
    
    UIImage *imjie = [UIImage imageNamed:@"6inviteFriends_02@2x.png"];
    [jianjie setImage:imjie];
    
    [self.view addSubview:jianjie];
    
    
    //yellow
    
    UIImageView *yellow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 822*__kScreenHeight__/1334, __kScreenWidth__, 333*__kScreenHeight__/1334)];
    
    UIImage *imyellow = [UIImage imageNamed:@"6inviteFriends_03@2x.png"];
    [yellow setImage:imyellow];
    [self.view addSubview:yellow];
    
    
    //我的专属
    
    UILabel *zhuanshu = [[UILabel alloc]initWithFrame:CGRectMake(177*__kScreenWidth__/750, 987*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
    
    zhuanshu.text = @"我的专属邀请码：";
    zhuanshu.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:zhuanshu];
    
    
    //邀请码
    if (__kScreenHeight__ == 568) {
        
        yaoqingma = [[UILabel alloc]initWithFrame:CGRectMake(446*__kScreenWidth__/750,987*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
        
        yaoqingma.font = [UIFont systemFontOfSize:15];
        
        yaoqingma.textColor = [UIColor colorWithRed:247/255.0 green:56/255.0 blue:39/255.0 alpha:1];
        [self.view addSubview:yaoqingma];

    }else if (__kScreenHeight__ >= 667)
    {
        yaoqingma = [[UILabel alloc]initWithFrame:CGRectMake(416*__kScreenWidth__/750,987*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
        
        yaoqingma.font = [UIFont systemFontOfSize:15];
        
        yaoqingma.textColor = [UIColor colorWithRed:247/255.0 green:56/255.0 blue:39/255.0 alpha:1];
        [self.view addSubview:yaoqingma];

        
    }
    
    
    //分享给好友
    
    UIButton *fenxiang = [[UIButton alloc]initWithFrame:CGRectMake(227*__kScreenWidth__/750,995*__kScreenHeight__/1334 , 297*__kScreenWidth__/750, 66*__kScreenHeight__/1334)];
//    [fenxiang addTarget:self
//                 action:@selector(showShareView)
//       forControlEvents:UIControlEventTouchUpInside];
    
    [fenxiang setImage:[UIImage imageNamed:@"6inviteFriends_13@2x.png"] forState:UIControlStateNormal];
//    [self.view addSubview:fenxiang];
    
    
    
    
    //查看人脉邀请记录

    
    UIImage *im1 = [UIImage imageNamed:@"6inviteFriends_06@2x.png"];
    UIButton *chongzhi = [[UIButton alloc]initWithFrame:CGRectMake(14*__kScreenWidth__/750, 1202*__kScreenHeight__/1334, 351*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    [chongzhi setBackgroundImage:im1 forState:UIControlStateNormal];
    [chongzhi addTarget:self action:@selector(renmaiyaoqingjilu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chongzhi];
    
    
    
    
   
    
    
    
    //查看人脉投资记录
    
    UIImage *im2 = [UIImage imageNamed:@"6inviteFriends_08@2x.png"];
    UIButton *tixian = [[UIButton alloc]initWithFrame:CGRectMake(385*__kScreenWidth__/750, 1202*__kScreenHeight__/1334, 351*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    [tixian setBackgroundImage:im2 forState:UIControlStateNormal];
    
    [self.view addSubview:tixian];
    
    [tixian addTarget:self action:@selector(renmaitouzijilu:) forControlEvents:UIControlEventTouchUpInside];
  
    // Do any additional setup after loading the view.
}
-(void)renmaiyaoqingjilu:(id)sender
{
    renmaiyaoqingViewController *yaoqingjilu1 = [[renmaiyaoqingViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:yaoqingjilu1 animated:NO completion:nil];
}
-(void)renmaitouzijilu:(id)sender
{
    remaotouziViewController *renmaitou1z = [[ remaotouziViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:renmaitou1z animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)yaoqingma
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
                        @"system_version":currentVersion,
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
    

    

    [manager POST:@"http://debug.otouzi.com:8012/Showcode"
       parameters:@{}
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"%@",responseObject);
              
              NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
              
              objc = responseObject;
            
              NSDictionary *qing = [objc objectForKey:@"data"];
              NSString *qing1 = [qing objectForKey:@"owncode"];
              NSLog(@"%@",qing1);
              if (qing1 == nil) {
                  qing1 = @"暂无邀请码";
              }
              NSLog(@"%@",qing1);
              [[NSUserDefaults standardUserDefaults] setObject:qing1 forKey:@"yaoqingluanma"];//存在本地沙盒
                           
              yaoqingma.text = [NSString stringWithFormat:@"%@",qing1];
                           
          } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
              
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


#pragma mark - 分享视图

- (void)createShareView{
    _shareView = [[UIView alloc]init];
    _shareView.frame = CGRectMake(48*kPlusScale, kScreenHeight, kScreenWidth - (48+48)*kPlusScale, (341+18+88)/2);
    _shareView.backgroundColor = [UIColor whiteColor];
    [_lastWindow addSubview:_shareView];
    
    
    //    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    btn.frame = CGRectMake(20, 20, 100, 60);
    //    [btn setTitle:@"点我" forState:UIControlStateNormal];
    //    [btn addTarget:self
    //            action:@selector(buttonAc:)
    //  forControlEvents:UIControlEventTouchUpInside];
    //
    //    [_shareView addSubview:btn];
    //
    NSArray *shareImages = @[
                             @"6moreShareQQ@2x",
                             @"6moreShareKJ@2x",
                             @"6moreShareWB@2x",
                             @"6moreShareWX@2x",
                             @"6moreSharePR@2x",
                             @"6moreShareDX@2x"
                             
                             ];
    NSArray *titles = @[
                        @"QQ",
                        @"QQ空间",
                        @"新浪微博",
                        @"微信",
                        @"微信朋友圈",
                        @"短信"
                        
                        ];
    for (int i = 0; i<2; i++) {
        
        for (int j= 0; j<3; j++) {
            
            
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat  spaceValue = (_shareView.width -100*kWidthScale*2 -(80/2)*3)/2;
            shareButton.frame = CGRectMake(100*kWidthScale+(spaceValue+80/2)*j, 36*kWidthScale+154*kWidthScale*i, 80/2, 80/2);
            
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateNormal];
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateSelected];
            
            [shareButton addTarget:self
                            action:@selector(shareAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            shareButton.tag =1000+j+3*i;
            [_shareView addSubview:shareButton];
            
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.frame = CGRectMake(34*kWidthScale+j *((_shareView.width-(34+34)*kWidthScale)/3),130*kWidthScale+ 150*kWidthScale*i, ((_shareView.width-(34+34)*kWidthScale)/3), 22/2);
            titleLabel.text = titles[j+3*i];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:22/2];
            //titleLabel.layer.borderWidth = 1;
            [_shareView addSubview:titleLabel];
            
        }
        
    }
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = CGRectMake(0, _shareView.height - (88+18)*kWidthScale, _shareView.width, 18*kWidthScale);
    bgView.backgroundColor = RGB(163, 163, 163, 1);
    
    [_shareView addSubview:bgView];
    
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, _shareView.height-88*kWidthScale, _shareView.width, 88/2);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self
                     action:@selector(shareCancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:kColorRed];
    [_shareView addSubview:cancleButton];
    
    
    
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
    [_lastWindow insertSubview:_maskView belowSubview:_shareView];
    
    
}

- (void)maskViewAction:(UIControl *)sender{
    _maskView.hidden = YES;
    [self hideShareView];
    


}
- (void)shareAction:(UIButton*)sender{
    
    switch (sender.tag ) {
        case 1000:
            
            break;
        case 1001:
            
            break;
        case 1002:
            [self sinaWeiboAlertView];
            
            break;
        case 1003:
            ;
            break;
        case 1004:
            ;
            break;
        case 1005:
            [self showMessageView];
        default:
            break;
    }
    
    
}
- (void)shareCancleAction:(UIButton *)sender{
    [self hideShareView];
    
    
    
    
}







//显示尾部视图
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                         _shareView.transform = CGAffineTransformMakeTranslation(0, -(341+18+88)/2);
                         _maskView.hidden = NO;//遮罩显示
                     }];
    
}

//隐藏尾部视图
- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         _shareView.transform = CGAffineTransformIdentity;
                         _maskView.hidden = YES;
                     }];
    
}





#pragma mark - 提示显示是否打开微博alertview

- (void)sinaWeiboAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"\"沃投资\"想要打开\"微博\""
                              delegate:self
                              cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    /*
     
     
     // 初始化一个一个UIAlertController
     // 参数preferredStyle:是IAlertController的样式
     // UIAlertControllerStyleAlert 创建出来相当于UIAlertView
     // UIAlertControllerStyleActionSheet 创建出来相当于 UIActionSheet
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"\"沃投资\"想要打开\"微博\"" preferredStyle:(UIAlertControllerStyleAlert)];
     
     // 创建按钮
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
     [self sinaWeiboShare];
     
     }];
     // 创建按钮
     // 注意取消按钮只能添加一个
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
     // 点击按钮后的方法直接在这里面写
     }];
     
     
     // 添加按钮 将按钮添加到UIAlertController对象上
     [alertController addAction:okAction];
     [alertController addAction:cancelAction];
     
     
     
     // 将UIAlertController模态出来 相当于UIAlertView show 的方法
     [self presentViewController:alertController animated:YES completion:nil];
     
     */
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        [self sinaWeiboShare];
    }
    
    
    
    
}


#pragma mark -  sinaWeibo分享
- (void)sinaWeiboShare{
    
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:@"沃 touzi "
                                     images:nil
                                        url:[NSURL URLWithString:@"https://api.weibo.com/oauth2/default.html"]
                                      title:@"沃 touzi"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"分享失败"
                                           message:[NSString stringWithFormat:@"%@", error]
                                           delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"分享已取消"
                                           message:nil
                                           delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
         
     }];
    
    
    
}

#pragma mar - 短信分享

/*
 *短信
 */

- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10010"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [self presentModalViewController:controller animated:YES];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}
-(void)yaoqing12:(id)sender
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






@end
