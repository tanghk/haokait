//
//  HelperCenterController.m
//  555
//
//  Created by otouzi on 16/3/23.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "HelperCenterController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "MBProgressHUD.h"
@implementation HelperCenterController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatWithNavGation];
    [self requestData];//请求网络数据
    [self.view addSubview:_webViewProgressView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    //[_indicatorView startAnimating];
    [self createWebView];//创建webview
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
}
#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(52, 68/2, __kScreenWidth__-104, 32/2);
    titleLabel.text = @"常见问题";
    titleLabel.font = [UIFont systemFontOfSize:16];
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
}


/*
 *post /problems
 header Access-Token Application-Session
 
 request
 {
 }
 response
 {
 "status": true,
 "code": 200,
 "data": {
 "event": "OpenBrowser",
 "href": "http://news.youth.cn/gj/201512/t20151209_7396356.htm"
 }
 }
 
 */
#pragma mark - 请求网络数据

- (void)requestData{

    
    [DataService requestWithURL:@"/problems"
                         params:nil
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    
                    
                    NSNumber *code = result[@"code"];
                    if ([code intValue]==200) {
                        
                        NSDictionary *responsedata = [result objectForKey:@"data"];
                        NSLog(@"常见问题%@",result);
                        self.urlStr = [responsedata objectForKey:@"href"];
                        
                        NSURL *url =[NSURL URLWithString:_urlStr];
                        
                        //沙盒路径
                        NSString *path =
                        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
                        //读取文件
                        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
                        NSString *session = [notFirstDic objectForKey:@"sb"];
                        NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                        
                        NSURLRequest *request = [NSURLRequest requestWithURL:url];
                        NSMutableURLRequest *mutableRequest = [request mutableCopy];
                        NSString *value = [NSString stringWithFormat:@"%@",sta];
                        NSString *value1 = [NSString stringWithFormat:@"%@",session];
                        [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
                        [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
                        //3.把值覆给request
                        request = [mutableRequest copy];
                        
                        //4.查看请求头
                        //  NSLog(@"%@", request.allHTTPHeaderFields);
                        
                        [_webView loadRequest:request];
                        
                        

                    }else{
                    
                    
                    
                    }
                    
                    
                    
                }];
    

    
}
- (void)createWebView{
    
    
    
    //网页视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44.5, kScreenWidth, kScreenHeight-kNavigationBarHeight+18.5)];    //自适应设备的屏幕
    
    //自适应设备的屏幕
    _webView.scalesPageToFit = YES;
    //设置代理
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    
    [self.view addSubview:_webView];
    
}


#pragma mark - WebView Delegate
//将要开始加载
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载");
    return YES;
}
//已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"已经开始加载");
    [_indicatorView startAnimating];
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
    [_indicatorView stopAnimating];
    [HUD hide:YES afterDelay:0.5];

}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
    [HUD hide:YES afterDelay:0.5];

}

-(void)aqlb:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//
//- (void)backBtnAction:(UIButton*)sender
//{
//
//    [self.navigationController popViewControllerAnimated:YES];
//
////    CATransition *animation = [CATransition animation];
////    animation.duration = 0.5;
////    animation.timingFunction = UIViewAnimationCurveEaseInOut;
////    animation.type = @"pageCurl";
////    animation.type = kCATransitionPush;
////    animation.subtype = kCATransitionFromLeft;
////    [self.view.window.layer addAnimation:animation forKey:nil];
////    [self dismissViewControllerAnimated:NO completion:nil];
//
//}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
