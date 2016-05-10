//
//  HomePageNoticeController.m
//  555
//
//  Created by otouzi on 16/3/23.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "HomePageNoticeController.h"
#import "UICommons.h"
#import "Masonry.h"
@implementation HomePageNoticeController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:_webViewProgressView];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWithNavGation];
    [self createWebView];//创建webview
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
    _titleLabel.backgroundColor = [UIColor clearColor];
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
        make.height.mas_equalTo(@(0.5));
        
        
    }];

}

- (void)createWebView{
    
    //网页视图
    _webView = [[UIWebView alloc]  initWithFrame:CGRectMake(0, 64.5, kScreenWidth, kScreenHeight-64.5)];
    
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
    
}

- (void)requestWebViewURL{
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlString =_urlStr; //@"http://debug.otouzi.com:8012/SiteNotice/riskReserveFund.html";
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
    
    
}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
    [HUD hide:YES afterDelay:0.5];
    
}


- (void)backBtnAction:(UIButton*)sender
{
    
  //  [self.navigationController popViewControllerAnimated:YES];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];

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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
