//
//  bangkaViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/18.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "bangkaViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "TabbarViewController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface bangkaViewController ()<NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;

    UILabel *titleLabel;
    UIWebView *bangkaweb;
    
    
    /*
     *快捷卡
     */
    BOOL _hasDefaultBankCard;  //data-bankCard-hasDefaultBankCard
    
    /*
     *普卡
     */
    
    BOOL _bind_bankcard; //data-chinapnr-bind_bankcard
    
    
    
    
    NSDictionary *_bankCardDic;
    NSDictionary *_chinapnrDic;
}

@end

@implementation bangkaViewController
-(void)viewWillAppear:(BOOL)animated{
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    
    bangkaweb.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self.view addSubview:_webViewProgressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    titleLabel.text = @"绑定银行卡";
    titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(cheba3:)
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
    
    
    
//   NSString *sp = [[NSUserDefaults standardUserDefaults]objectForKey:@"bangkawangzhi"];
    
   // NSLog(@"kjashwi %@",sp);
    
    bangkaweb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64.5, __kScreenWidth__, __kScreenHeight__-64.5)];
    
    
    NSURL *url = [NSURL URLWithString:self.urlValue];
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
    
    request = [mutableRequest copy];
    
    [self.view addSubview:bangkaweb];
    
    [bangkaweb loadRequest:request];

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cheba3:(id)sender
{
    
    
    
    
    
    [self requesrUserCenterData];
    
    
    
   }




#pragma mark－用户中心
- (void)requesrUserCenterData{
    
    [DataService requestWithURL:@"/user/center"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [ self loadUserCenterData :result];
                    
                    
                    
                }];
    
}






#pragma mark -用户中心加载数据
- (void)loadUserCenterData:(id)result{
    
    NSLog(@"用户中心%@",result);
    
    NSDictionary *reponseDic =result;
    
    
    NSNumber *code = reponseDic[@"code"];
    
    if ([code intValue] ==200)
    {
        
        NSDictionary *dataDic = reponseDic[@"data"];
        
        
        /*
         *快捷卡判断
         */
        
        _bankCardDic = dataDic[@"bankCard"];
        
        _hasDefaultBankCard = [_bankCardDic[@"hasDefaultBankCard"]boolValue];
        
        NSLog(@"快捷卡判断:%d",_hasDefaultBankCard);
        
        
        /*
         *判断普卡
         */
        
        _chinapnrDic = dataDic[@"chinapnr"];
        _bind_bankcard = [_chinapnrDic[@"bind_bankcard"] boolValue] ;
        NSLog(@"普卡判断:%d",_bind_bankcard);

        if (_bankCardDic!=nil &&_chinapnrDic!=nil) {

                if (_bind_bankcard ==YES) {
                    
                
                    
                    TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
                    tabbarcontroller.selectedIndex =3;
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarcontroller;
                    

                    
                }else{
                    
                    
                    
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
            
            
    }else{
    
    
    /*
     *code不等于200
     */
    
    }
      
    
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
