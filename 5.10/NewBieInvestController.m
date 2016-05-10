//
//  NewBieInvestController.m
//  555
//
//  Created by otouzi on 16/4/6.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "NewBieInvestController.h"
#import "AFNetworking.h"
#import "ChanpinViewController.h"
#import "UICommons.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "Masonry.h"
#import "NewbieController.h"
#import "HadInvestController.h"
@interface NewBieInvestController ()

@end

@implementation NewBieInvestController


- (void)viewWillAppear:(BOOL)animated{
    [self creatWithNavGation];
    [self.view addSubview:_webViewProgressView];
    
}

- (void)viewDidLoad {
    
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64.5,self.view.bounds.size.width,kScreenHeight-64.5)];
    
 
    
    //自适应设备的屏幕
    _webView.scalesPageToFit = YES;
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self requestWeb];
    
    [self.view addSubview:_webView];
    
    
    
    
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
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    //_titleLabel.text = @"产品投资";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // _titleLabel.textColor = [UIColor whiteColor];
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



- (void)requestWeb{
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    NSURL *url = [NSURL URLWithString:self.investUrl];
    
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
    //4.查看请求头
    NSLog(@"%@", request.allHTTPHeaderFields);
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - WebView Delegate
//将要开始加载
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载");
    _titleLabel.text = @"正在载入";
    NSString *host = @"http://debug.otouzi.com:8012/";
    NSString *urlstr = request.URL.absoluteString;
    NSRange range = [urlstr rangeOfString:host];
    if (range.length!=0) {
        
        
        NSString *textString = [urlstr substringFromIndex:[host length]];
        
        //        NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlGrep];
        
        NSString*string =textString;
        
        NSArray *array = [string componentsSeparatedByString:@"/"];
        if ([array[0] isEqualToString:@"app.d"]) {
            
            NSLog(@"事件命event：%@",array[2]);
            NSLog(@"参数parameter：%@",array[4]);
            
            
            _parameter =array[4];
            
            _event = array[2];
            NSString *parameters = [_parameter stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
            
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:parameters options:0];
            
            NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            
            NSLog(@"新手标%@", decodedString); //Base64转字符串 NSSTRING
            
            NSData *jsonData = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            NSLog(@"%@",dic);
            
            
            
            NSString *uii = [dic objectForKey:@"status"];
            int ou = [uii intValue];
            
            if (ou == 1) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"investSucess" object:self];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"investSucess"];
                
                
            }
            
            
            if ([_event isEqualToString:@"OpenWindow"]||[_event isEqualToString:@"OperationSuccess"])
            {
                
                NSString *target = [dic objectForKey:@"target"];
                if ([target isEqualToString:@"UserCenter"])
                {
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"investSucess" object:self];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"investSucessProduct" object:self];
                  

                    HadInvestController  *hadinvest = [[HadInvestController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                    [self presentViewController:hadinvest animated:NO completion:nil];
                    
                //    disanfang.productId =@"996";
                    
                    
                }
                
                
            }
            
            else if([_event isEqualToString:@"CloseWindow"]||[_event isEqualToString:@"OperationException"])
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




//已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"已经开始加载");
}

//网页加载完成调用此方法

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"已经加载完成");
    
    _titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    
    
}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)backBtnAction:(UIButton*)sender
{
    
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
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
