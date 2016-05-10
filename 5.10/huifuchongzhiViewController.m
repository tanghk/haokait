//
//  huifuchongzhiViewController.m
//  555
//
//  Created by 浩宇李 on 15/12/14.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "huifuchongzhiViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UICommons.h"
#import "Masonry.h"
#import "NewbieController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface huifuchongzhiViewController ()<NJKWebViewProgressDelegate>

{NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;

    UIButton *chehuizhaohuimiam;
    NSString *wi;
     UILabel *titleLabel;
    NSString *WANGZHI;
    UIWebView *huifuweb;
    NSString *b;
}
@end

@implementation huifuchongzhiViewController
-(void)viewWillAppear:(BOOL)animated{
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    
    huifuweb.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self.view addSubview:_webViewProgressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_bridge) {
        return;
        
    }

    
    huifuweb.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
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
                action:@selector(cheba2:)
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

    
    NSString *sp = [[NSUserDefaults standardUserDefaults]objectForKey:@"chongzhiwangzhi"];
    
    NSLog(@"kjashwi %@",sp);
    
    huifuweb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, __kScreenHeight__-64)];
 
    
     NSURL *url = [NSURL URLWithString:sp];
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
     NSString *value3 = [NSString stringWithFormat:@"ios"];
     [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
     [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
     [mutableRequest addValue:value2 forHTTPHeaderField:@"T-User-Agent"];
    
     [mutableRequest addValue:value3 forHTTPHeaderField:@"T-Client-Platform"];
     request = [mutableRequest copy];
    
   
    
     [huifuweb loadRequest:request];
    
     [self.view addSubview:huifuweb];
     [self bridge];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bridge{
    
    if (_bridge) {
        return;
    }
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge
               bridgeForWebView:huifuweb
               webViewDelegate:self
               handler:^(id data, WVJBResponseCallback responseCallback) {
                   NSLog(@"ObjC received message from JS: %@", data);
                   responseCallback(@"Response for message from ObjC");
               }];
    
    
    
}

-(void)cheba2:(id)sender
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
-(void)chebade:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
}
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
            wi = array[2];
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
           
            [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"qukanchanpin"];
            
            NSString *uii = [dic objectForKey:@"status"];
            int ou = [uii intValue];
            
            if (ou == 1) {
                 [chehuizhaohuimiam addTarget:self action:@selector(chebade:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if ([wi isEqualToString:@"OpenWindow"]||[wi isEqualToString:@"OperationSuccess"]) {
                
                 NSString *uiin = [dic objectForKey:@"target"];
                
                if ([uiin isEqualToString:@"UserCenter"]) {
                    
                    NSString *newbioe = [[NSUserDefaults standardUserDefaults]objectForKey:@"newbiewc"];
                    int cc = [newbioe intValue];
                    NSLog(@"%d",cc);
                    if (cc == 1000) {
                        
                        
                        NewbieController  *disanfang= [[NewbieController alloc]init];
                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.5;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = @"pageCurl";
                        animation.type = kCATransitionPush;
                        animation.subtype = kCATransitionFromRight;
                        [self.view.window.layer addAnimation:animation forKey:nil];
                        
                        [self presentViewController:disanfang animated:NO completion:nil];

                        disanfang.productId =@"996";
                    }else{
                        
                    
                    
                    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                    TabbarViewController *tab = [[TabbarViewController alloc]init];
                    delete.window.rootViewController = tab;
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
                    
                    }
                    
                    
                }
              }else if([wi isEqualToString:@"CloseWindow"]||[wi isEqualToString:@"OperationException"])
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

                    
        }


        
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
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
