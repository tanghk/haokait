//
//  InvitationFriendController.m
//  555
//
//  Created by otouzi on 16/4/13.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "InvitationFriendController.h"
#import "UICommons.h"
#import "Masonry.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "WXApi.h"
#import "UIViewExt.h"

#import "UIButton+EnlargeTouchArea.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>


//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface InvitationFriendController ()
{
    
    UILabel *_titleLabel;
    NSString *_parameter;//参数
    NSString *_event;//事件名称
    UIButton *_backBtn;
    MBProgressHUD *HUD;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    
    
    UIControl *_maskView; //遮罩视图
    
    UIWindow *_lastWindow; //当前window
    

    
    UIView *_shareView;//分享视图

    
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
    
    
}


@end

@implementation InvitationFriendController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:_webViewProgressView];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = kcolorGrayNew;
    [self creatWithNavGation];
    [self createWebView];//创建webview
    
    
   _title = @"分享给你9999元红包-享受真实安全高收益理财";
   _text =@"年化收益12%-18%,下载APP注册另有588大礼包。";
    
    
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    
    //分享视图
    [self createShareView];

    
    //遮盖视图
    [self createMaskView];
    
    [self createRechargeView];
    
    }

-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 导航栏
- (void)creatWithNavGation{
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = kColorWhite;
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    _titleLabel.text = @"正在载入";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
 
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(backBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =kColorNaviLine ;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationgView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@0.5);
        
        
    }];
    
}

- (void)createWebView{
    
    //网页视图
    _webView = [[UIWebView alloc]  initWithFrame:CGRectMake(0, 64.5, kScreenWidth, kScreenHeight-64.5-80*kPlusHeightScale- 174*kPlusHeightScale)];
    
    //自适应设备的屏幕
    _webView.scalesPageToFit = YES;
    
    
    
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self requestWebViewURL];
    
    [self.view addSubview:_webView];
    
    
    
    
    
    
    UIButton *invitationBtn = [UIButton new];
    [invitationBtn setTitle:@"立即邀请好友" forState:UIControlStateNormal];
    invitationBtn.layer.cornerRadius = 5;
    invitationBtn.backgroundColor = kColorMain;
    invitationBtn.titleLabel.font = Font(60*kPlusHeightScale);
    [invitationBtn addTarget:self
                      action:@selector(invitation:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invitationBtn];
    
    [invitationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(39*kPlusScale);
        make.right.equalTo(self.view).offset(-39*kPlusScale);
        make.height.mas_equalTo(174*kPlusHeightScale);
        make.bottom.mas_equalTo(-40*kPlusHeightScale);
        
    }];
    
}


#pragma mark - 分享视图

- (void)createShareView{
    _shareView = [[UIView alloc]init];
    _shareView.frame = CGRectMake(129*kPlusScale, kScreenHeight, kScreenWidth - (129*2)*kPlusHeightScale, (341+18+88)*kHeightScale);
    _shareView.backgroundColor = [UIColor whiteColor];
    [_lastWindow addSubview:_shareView];
    
    
    
    NSArray *shareImages = @[
                             @"6moreShareQQ@2x",
                             @"6moreShareWB@2x",
                             @"6moreShareWX@2x",
                             @"6moreSharePR@2x",
                             
                             ];
    NSArray *titles = @[
                        @"QQ",
                        @"新浪微博",
                        @"微信",
                        @"微信朋友圈",
                        
                        ];
    for (int i = 0; i<2; i++) {
        
        for (int j= 0; j<2; j++) {
            
            
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat  spaceValue = (_shareView.width  -(80*kHeightScale)*2)/3;
           
            shareButton.frame = CGRectMake(spaceValue+(spaceValue+80*kHeightScale)*j, 36*kHeightScale+154*kHeightScale*i, 80*kWidthScale, 80*kHeightScale);
            [shareButton setAdjustsImageWhenHighlighted:NO];
            //shareButton.layer.borderWidth = 1;
            [shareButton setEnlargeEdgeWithTop:12 right:12 bottom:12 left:12];
            [shareButton setImage:[UIImage imageNamed:shareImages[j+2*i] ]forState:UIControlStateNormal];
           // [shareButton setImage:[UIImage imageNamed:shareImages[j+2*i] ]forState:UIControlStateSelected];
            
            [shareButton addTarget:self
                            action:@selector(shareAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            shareButton.tag =1000+j+2*i;
            [_shareView addSubview:shareButton];
            
            
            UILabel *titleLabel = [[UILabel alloc]init];
//            titleLabel.frame = CGRectMake((79)*kWidthScale+j *((_shareView.width-(158)*kWidthScale)/2),, ((_shareView.width-(158)*kWidthScale)/2), 22*kHeightScale);
          //titleLabel.frame = CGRectMake(34*kWidthScale+j *((_shareView.width-(34+34)*kWidthScale)/3),130*kHeightScale+ 150*kHeightScale*i, ((_shareView.width-(34+34)*kWidthScale)/3), 22*kHeightScale);
            titleLabel.text = titles[j+2*i];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:22/2];
            //titleLabel.layer.borderWidth = 1;
            [_shareView addSubview:titleLabel];
            
            
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_shareView).offset(130*kHeightScale+ 150*kHeightScale*i);
                make.centerX.equalTo(shareButton.mas_centerX);
                make.height.mas_equalTo(22*kHeightScale);
            }];
            
        }
        
    }
    
    
    
    /*
    
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
            CGFloat  spaceValue = (_shareView.width -100*kWidthScale*2 -(80*kHeightScale)*3)/2;
            shareButton.frame = CGRectMake(100*kWidthScale+(spaceValue+80*kHeightScale)*j, 36*kHeightScale+154*kHeightScale*i, 80*kWidthScale, 80*kHeightScale);
            
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateNormal];
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateSelected];
            
            [shareButton addTarget:self
                            action:@selector(shareAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            shareButton.tag =1000+j+3*i;
            [_shareView addSubview:shareButton];
            
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.frame = CGRectMake(34*kWidthScale+j *((_shareView.width-(34+34)*kWidthScale)/3),130*kHeightScale+ 150*kHeightScale*i, ((_shareView.width-(34+34)*kWidthScale)/3), 22*kHeightScale);
            titleLabel.text = titles[j+3*i];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:22/2];
            //titleLabel.layer.borderWidth = 1;
            [_shareView addSubview:titleLabel];
            
        }
        
    }
    
    
    
    

    
    */
    
    
//    
//    NSArray *shareImages = @[
//                             @"6moreShareQQ@2x",
//                             @"6moreShareWX@2x",
//                             @"6moreShareWB@2x",
//
//                             
//                             ];
//    NSArray *titles = @[
//                        @"QQ",
//                        @"微信",
//                        @"新浪微博",
//                        ];
//
//    
//    for (int j= 0; j<3; j++) {
//        
//        
//        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        CGFloat  spaceValue = (_shareView.width -100*kWidthScale*2 -(80*kHeightScale)*3)/2;
//        shareButton.frame = CGRectMake(100*kWidthScale+(spaceValue+80*kHeightScale)*j, 36*kHeightScale, 80*kWidthScale, 80*kHeightScale);
//        
//        [shareButton setImage:[UIImage imageNamed:shareImages[j] ]forState:UIControlStateNormal];
//              [shareButton addTarget:self
//                        action:@selector(shareAction:)
//              forControlEvents:UIControlEventTouchUpInside];
//        shareButton.tag =1000+j;
//        [_shareView addSubview:shareButton];
//        
//        
//        UILabel *titleLabel = [[UILabel alloc]init];
//        titleLabel.frame = CGRectMake(34*kWidthScale+j *((_shareView.width-(34+34)*kWidthScale)/3),130*kHeightScale, ((_shareView.width-(34+34)*kWidthScale)/3), 22*kHeightScale);
//        titleLabel.text = titles[j];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.font = [UIFont systemFontOfSize:22/2];
//        //titleLabel.layer.borderWidth = 1;
//        [_shareView addSubview:titleLabel];
//        
//    }
//
    
    
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = CGRectMake(0, _shareView.height - (88+18)*kHeightScale, _shareView.width, 18*kHeightScale);
    //bgView.backgroundColor = RGB(163, 163, 163, 1);
    bgView.backgroundColor = kColorWhite;
    bgView.alpha = 0.8;
    [_shareView addSubview:bgView];
    
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(70/3, _shareView.height-118*kHeightScale, _shareView.width-2*70/3, 88*kHeightScale);
    cancleButton.layer.cornerRadius = 5;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self
                     action:@selector(shareCancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:kColorMain];
    [_shareView addSubview:cancleButton];
    
    
    
    
}

/*
- (void)shareAction:(UIButton*)sender{
    
    switch (sender.tag ) {
        case 1000:
            
            
            [self TencentQQShare];
            break;
        case 1001:
            [self TencentQzoneShare];
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
 */

- (void)shareAction:(UIButton*)sender{
    
    switch (sender.tag ) {
        case 1000:

            [self TencentQQShare];
            break;
        case 1001:
            [self sinaWeiboShare];// [self sinaWeiboAlertView];

            break;
        case 1002:
            [self TencentWechatShare];
            
            break;
        case 1003:
            [self TencentWechatTimelineShare];
            

              default:
            break;
    }
    
    
}



#pragma mark - 遮盖视图
//创建遮盖视图
- (void)createMaskView{
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
      [_lastWindow insertSubview:_maskView belowSubview:_shareView];
 }

- (void)requestWebViewURL{
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlString =_urlStr;
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *value = [NSString stringWithFormat:@"%@",sta];
    NSString *value1 = [NSString stringWithFormat:@"%@",sb];
    NSString *value2 = [NSString stringWithFormat:@"BROWSER"];
    
    [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
    [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
    [mutableRequest addValue:value2 forHTTPHeaderField:@"T-User-Agent"];
    [mutableRequest addValue:@"ios" forHTTPHeaderField:@"T-Client-Platform"];
    
    //3.把值覆给request
    request = [mutableRequest copy];
    [_webView loadRequest:request];
    
    
}
#pragma mark - WebView Delegate
//将要开始加载
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载");
    _titleLabel.text = @"正在载入";
    
    return YES;
    
}
//已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"已经开始加载");
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
}

//已经加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"已经加载完成");
    _titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    
    [HUD hide:YES afterDelay:0.5];
    
     _titleLabel.text = @"邀请好友";
}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
    [HUD hide:YES afterDelay:0.5];
    
}


- (void)backBtnAction:(UIButton*)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}



- (void)shareCancleAction:(UIButton *)sender{
    [self hideShareView];
    
    
    
    
}

- (void)invitation:(UIButton *)sender{

    NSLog(@"111");
    [self showShareView];
    


}
#pragma mark - 遮挡视图点击事件
- (void)maskViewAction:(UIControl *)sender{
    _maskView.hidden = YES;
    _rechargeView.hidden = YES;

    [self hideShareView];
    
    
    
}


//显示尾部视图
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                         _shareView.transform = CGAffineTransformMakeTranslation(0, -(341+18+88)*kHeightScale-10);
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


////代理方法
//- (void)changeType{
//
//    [self.login setBackgroundImage:[UIImage imageNamed:@"moreBtn2"] forState:UIControlStateNormal];
//
//
//
//}



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
    
    [self hideShareView];
    if (![WeiboSDK isWeiboAppInstalled]) {
      
        
        [self showPromptWindow];
        
        _contentLabel.text = [NSString stringWithFormat:@"未安装微博客户端！"];
        

        
    }else{
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        NSArray* imageArray = @[[UIImage imageNamed:@"sharelogo"]];
        
        
        
        //使用客户端分享
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:_text//@"沃投资真是我的赚钱神器，方便、安全、高收益；还能帮助农民伯伯呢,你也下载试试！"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.hrefShare]
                                          title:_title//@"沃投资，岂止于收益；爱心助农，让投资更有价值;"
                                           type: SSDKContentTypeWebPage];
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             //         switch (state) {
             //             case SSDKResponseStateSuccess:
             //             {
             //                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
             //                                                                     message:nil
             //                                                                    delegate:nil
             //                                                           cancelButtonTitle:@"确定"
             //                                                           otherButtonTitles:nil];
             //                 [alertView show];
             //                 break;
             //             }
             //             case SSDKResponseStateFail:
             //             {
             //                 UIAlertView *alertView = [[UIAlertView alloc]
             //                                           initWithTitle:@"分享失败"
             //                                           message:[NSString stringWithFormat:@"%@", error]
             //                                           delegate:nil
             //                                           cancelButtonTitle:@"确定"
             //                                           otherButtonTitles:nil];
             //                 [alertView show];
             //                 break;
             //             }
             //             case SSDKResponseStateCancel:
             //             {
             //                 UIAlertView *alertView = [[UIAlertView alloc]
             //                                           initWithTitle:@"分享已取消"
             //                                           message:nil
             //                                           delegate:nil
             //                                           cancelButtonTitle:@"确定"
             //                                           otherButtonTitles:nil];
             //                 [alertView show];
             //                 break;
             //             }
             //             default:
             //                 break;
             //         }
             
         }];
        

    
    
    }
    
    
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
#pragma mark - 短信分享
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

/*
 *视图消失的时候
 */
- (void)viewDidDisappear:(BOOL)animated{
    
}



#pragma mark - 腾讯QQ分享
- (void)TencentQQShare{
    
    
    
    [self hideShareView];
    if (![QQApiInterface  isQQInstalled]){
    
        
        [self showPromptWindow];
        
        _contentLabel.text = [NSString stringWithFormat:@"未安装QQ客户端!"];
        

    
    }else{
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"sharelogo"]];
    
    
    
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:_text//@"沃投资真是我的赚钱神器，方便、安全、高收益；还能帮助农民伯伯呢,你也下载试试！"
                                     images:imageArray
                                        url:[NSURL URLWithString:self.hrefShare]
                                      title:_title//@"沃投资，岂止于收益；爱心助农，让投资更有价值;"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share: SSDKPlatformTypeQQ
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
    }];
    
    
    }
    
}
#pragma mark - 腾讯QQ空间分享
- (void)TencentQzoneShare{
    
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"sharelogo"]];
    
    
    
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:_text//@"沃投资真是我的赚钱神器，方便、安全、高收益；还能帮助农民伯伯呢,你也下载试试！"
                                     images:imageArray
                                        url:[NSURL URLWithString:self.hrefShare]
                                      title:_title//@"沃投资，岂止于收益；爱心助农，让投资更有价值;"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share: SSDKPlatformSubTypeQZone
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {

         
     }];
    
    
    
    
}

#pragma mark - 微信
- (void)TencentWechatShare{
    
    [self hideShareView];

    if (![WXApi  isWXAppInstalled]){
        
        
        
        [self showPromptWindow];
        
        _contentLabel.text = [NSString stringWithFormat:@"未安装微信客户端!"];
        
   
        
    }else{
        
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"sharelogo"]];
    
    
    
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:_text//@"沃投资真是我的赚钱神器，方便、安全、高收益；还能帮助农民伯伯呢,你也下载试试！"
                                     images:imageArray
                                        url:[NSURL URLWithString:self.hrefShare]
                                      title:_title//@"沃投资，岂止于收益；爱心助农，让投资更有价值;"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share: SSDKPlatformSubTypeWechatSession
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         

    }];
    
    
    }
    
}


#pragma mark － 微信朋友圈
- (void)TencentWechatTimelineShare{
    
    [self hideShareView];
    if (![WXApi  isWXAppInstalled]){
        
        
        [self showPromptWindow];
        
        _contentLabel.text = [NSString stringWithFormat:@"未安装微信客户端!"];
        
        
        
    }else{
        

    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"sharelogo"]];
    
    
    
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:_text//@"沃投资真是我的赚钱神器，方便、安全、高收益；还能帮助农民伯伯呢,你也下载试试！"
                                     images:imageArray
                                        url:[NSURL URLWithString:self.hrefShare]
                                      title:_title//@"沃投资，岂止于收益；爱心助农，让投资更有价值;"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share: SSDKPlatformSubTypeWechatTimeline
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
     }];
    
    
    }
}



#pragma mark -提示充值弹窗

//创建遮盖视图
- (void)createRechargeView{
    
    
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
    _rechargeView.layer.cornerRadius = 3;
       _rechargeView.frame = CGRectMake(0.163*kScreenWidth, 0.358*kScreenHeight, kScreenWidth - 2*0.163*kScreenWidth, 0.149*kScreenHeight);
    
    
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow insertSubview:_rechargeView aboveSubview:_maskView];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
      _contentLabel.numberOfLines = 1;
    _contentLabel.font = [UIFont systemFontOfSize:28/2];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
      [_rechargeView addSubview:_contentLabel];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_rechargeView.mas_top).offset(0.032*kScreenHeight);
        make.left.equalTo(_rechargeView.mas_left);
        make.right.equalTo(_rechargeView.mas_right);
        make.height.mas_equalTo(0.018*kScreenHeight);
    }];
   
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
   
    _rechargeView.hidden = NO;
        _maskView.hidden = NO;
  
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @1.1;
    
    
    [animation setDuration:0.35];
    [animation setAutoreverses:YES];
    [_rechargeView.layer addAnimation:animation forKey:nil];
    
//
//    [UIView animateWithDuration:.35 animations:^{
//        
//        _rechargeView.hidden = NO;
//        _maskView.hidden = NO;
//    }];
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




@end
