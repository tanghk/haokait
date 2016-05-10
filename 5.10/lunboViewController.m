//
//  lunboViewController.m
//  555
//
//  Created by 李浩宇 on 16/1/18.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "lunboViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UICommons.h"
#import "Masonry.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface lunboViewController ()<NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
        UIWebView *webxinshou;
        
    UILabel *titleLabel;
}
@property WebViewJavascriptBridge* bridge;
@end

@implementation lunboViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *a = [[NSUserDefaults standardUserDefaults]objectForKey:@"dijizhanga"];
    NSLog(@"%@",a);
    int b = [a intValue];
    NSMutableArray *urls = [[NSUserDefaults standardUserDefaults]objectForKey:@"bannerwangzhi"];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
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
                action:@selector(addddd:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];

    
    //穿透效果
    self.navigationController.navigationBar.translucent = NO;
    
    
    NSString *weburl = urls[b];
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
    
    webxinshou = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, __kScreenHeight__-64)];
    
    request = [mutableRequest copy];
    
    [self.view addSubview:webxinshou];
    
    [webxinshou loadRequest:request];
    
        [self bridge];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addddd:(id)sender
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
-(void)bridge{
    
    if (_bridge) {
        return;
    }
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge
               bridgeForWebView:webxinshou
               webViewDelegate:self
               handler:^(id data, WVJBResponseCallback responseCallback) {
                   NSLog(@"ObjC received message from JS: %@", data);
                   responseCallback(@"Response for message from ObjC");
               }];
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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
