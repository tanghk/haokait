//
//  SafeViewController.m
//  555
//
//  Created by otouzi on 15/10/26.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
#import "SafeViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "WebViewJavascriptBridge.h"
#import "zhucedeViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UICommons.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
@interface SafeViewController ()<UIWebViewDelegate,WebViewJavascriptBridgeBaseDelegate,NJKWebViewProgressDelegate>

{
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    UIWebView *webxinshou;
    NSString *b;
    UILabel *titleLabel;
    MBProgressHUD *HUD;

}
@property WebViewJavascriptBridge* bridge;


@end

@implementation SafeViewController
-(void)viewWillAppear:(BOOL)animated{
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    
    webxinshou.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self.view addSubview:_webViewProgressView];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(52, 68/2, __kScreenWidth__-104, 32/2);
    titleLabel.text = @"正在载入";
    titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(aqlb:)
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
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    //穿透效果
    self.navigationController.navigationBar.translucent = NO;
    
    
    NSString *weburl = [[NSUserDefaults standardUserDefaults]objectForKey:@"anquanba"];
    NSURL *url = [NSURL URLWithString:weburl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    NSString *value = [NSString stringWithFormat:@"%@",sta];
    NSString *value1 = [NSString stringWithFormat:@"%@",sb];
    NSString *value2 = [NSString stringWithFormat:@"BROWSER"];
    
    [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
    [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
    [mutableRequest addValue:value2 forHTTPHeaderField:@"T-User-Agent"];
    
    webxinshou = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64.5, __kScreenWidth__, __kScreenHeight__-64.5)];
    
    request = [mutableRequest copy];
    
    [self.view addSubview:webxinshou];
    
    [webxinshou loadRequest:request];
    
    // Do any additional setup after loading the view.
}




-(void)aqlb:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WebView Delegate
//将要开始加载

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString *host = @"http://debug.otouzi.com:8012/";
    NSString *urlstr = request.URL.absoluteString;
    NSRange range = [urlstr rangeOfString:host];
    if (range.length!=0) {
        
        
        NSString *textString = [urlstr substringFromIndex:[host length]];
        
        //        NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlGrep];
        
        
        NSString*string =textString;
        
        NSArray *array = [string componentsSeparatedByString:@"/"];
        if ([array[0] isEqualToString:@"app.d"]) {
            
            NSLog(@"事件命：%@",array[2]);
            NSLog(@"参数：%@",array[4]);
            b =array[4];
            NSString *a = [b stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
            
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:a options:0];
            
            NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", decodedString); // foo
            
            NSData *jsonData = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            NSLog(@"%@",dic);
            
            
            NSString *string = [dic objectForKey:@"target"];
            NSLog(@"%@",string);
            
            if ([string isEqualToString:@"UserRegister"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"a" forKey:@"witch"];
                CATransition *animation = [CATransition animation];
                animation.duration = 0.35;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"pageCurl";
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromRight;
                [self.navigationController.view.layer addAnimation:animation forKey:nil];
                
                zhucedeViewController *zhuce = [[zhucedeViewController alloc]init];
                
                [self presentViewController:zhuce animated:NO completion:nil];
                
            }else if([string isEqualToString:@"ProductList"])
            {
                CATransition *animation = [CATransition animation];
                animation.duration = 0.5;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"pageCurl";
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromLeft;
                [self.view.window.layer addAnimation:animation forKey:nil];
                
                AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                TabbarViewController *tab = [[TabbarViewController alloc]init];
                delete.window.rootViewController = tab;
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"quzhaunqian" object:self];
                
            }
        }
        
        
        
        
    }
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
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
     [HUD hide:YES afterDelay:0.5];
}


//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
     [HUD hide:YES afterDelay:0.5];
}


-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
