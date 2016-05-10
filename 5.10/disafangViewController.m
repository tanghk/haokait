//
//  disafangViewController.m
//  555
//
//  Created by 李浩宇 on 15/11/4.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "disafangViewController.h"
#import "AFNetworking.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UICommons.h"
#import "TouziViewController.h"
#import "RedEnvelopesController.h"
#import "AppDelegate.h"
#import "chongzhiViewController.h"
#import "TabbarViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "Masonry.h"
#import "UICommons.h"

@interface disafangViewController ()<NJKWebViewProgressDelegate>
{ NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;

    UIButton *backBtn ;
    NSString *ui;
    NSString *sta;
     UILabel *titleLabel;
      NSString *b;

}
@property (nonatomic,strong)NSString *WANGZHI;
@property (nonatomic,strong)UIWebView *webView;


@end

@implementation disafangViewController

-(void)viewWillAppear:(BOOL)animated{
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    
    _webView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 2)];
    
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    
    [self.view addSubview:_webViewProgressView];
    [super viewWillAppear:animated];
    
    
    [self creatWithNavGation];
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIImageView *imge_deng = [[UIImageView alloc]init];
    [self.view addSubview:imge_deng];
    [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64.5);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(206*__kScreenHeight__/1334);
        
    }];
    [imge_deng setImage:[UIImage imageNamed:@"huifu_top.png"]];

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
                        @"system_version": currentVersion,
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
          sta = token;
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }

    
    
    
    [manager POST:@"http://debug.otouzi.com:8012/user/chinapnr/open"
      parameters:@{
                   @"version":@"2"
                   }
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             
             NSLog(@"%@",responseObject);
             
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             dic = responseObject;
             [[NSUserDefaults standardUserDefaults] setObject:dic[@"data"][@"href"] forKey:@"wangzhi"];
             
             _WANGZHI = [[NSUserDefaults standardUserDefaults]objectForKey:@"wangzhi"];
             
          NSLog(@"%@",_WANGZHI);
             
             UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,206*__kScreenHeight__/1334+64.5,self.view.bounds.size.width,__kScreenHeight__-64.5-206*__kScreenHeight__/1334)];
              webView.delegate = self;
             NSURL *url = [NSURL URLWithString:_WANGZHI];
             
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
             
             //4.查看请求头 
            NSLog(@"%@", request.allHTTPHeaderFields);
             


             
             [webView loadRequest:request];
             [self.view addSubview:webView];
             
           
//             NSString *jsCode = [NSString stringWithFormat:@"alert(1);"];
//             [_webView stringByEvaluatingJavaScriptFromString:jsCode];
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
             NSLog(@"%@",error);
         }];
    
         
    
    UIColor *coloer = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.view.backgroundColor = coloer;
    

    // Do any additional setup after loading the view.
}


- (void)setModel:(ListModel *)model{

    _model = model;
    

}

#pragma mark - WebView Delegate
//将要开始加载
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载");
    

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
            ui = array[2];
            NSLog(@"参数：%@",array[4]);
            b =array[4];
            NSString *a = [b stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
            
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:a options:0];
            
            NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            
            NSLog(@"开通汇付%@", decodedString); //Base64转字符串 NSSTRING
            
            NSData *jsonData = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            NSLog(@"%@",dic);
            NSMutableDictionary * ais = [dic objectForKey:@"data"];
            NSDictionary *bis = [ais objectForKey:@"chinapnr"];
            NSString *code2 = [bis objectForKey:@"code"];
            int sisi = [code2 intValue];
            if ([code2 isEqualToString:@"000"]) {
                
                    [NSThread sleepForTimeInterval:2.0f];
                    chongzhiViewController *chon = [[chongzhiViewController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                    [self presentViewController:chon animated:NO completion:nil];
                    
                    
               
            }
            else{
                
                NSString *uii = [dic objectForKey:@"status"];
                int ou = [uii intValue];
                
                if (ou == 1) {
                    [backBtn addTarget:self
                                action:@selector(chebade:)
                      forControlEvents:UIControlEventTouchUpInside];
                }
                
                
                if ([ui isEqualToString:@"OpenWindow"]||[ui isEqualToString:@"OperationSuccess"] ) {
                    
                    NSString *uiin = [dic objectForKey:@"target"];
                    
                    
                    
                    if ([uiin isEqualToString:@"UserCenter"]) {
                        
                        
//                        NSString *newbioe = [[NSUserDefaults standardUserDefaults]objectForKey:@"newbiewc"];
//                        int cc = [newbioe intValue];
//                        NSLog(@"%d",cc);
//                        if (cc == 1000) {
                        
                            
                            chongzhiViewController *chon = [[chongzhiViewController alloc]init];
                            CATransition *animation = [CATransition animation];
                            animation.duration = 0.5;
                            animation.timingFunction = UIViewAnimationCurveEaseInOut;
                            animation.type = @"pageCurl";
                            animation.type = kCATransitionPush;
                            animation.subtype = kCATransitionFromRight;
                            [self.view.window.layer addAnimation:animation forKey:nil];
                            
                            [self presentViewController:chon animated:NO completion:nil];
                            
                            
//                        }else{
                        
                            
                            
//                            TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
//                            tabbarcontroller.selectedIndex =3;
//                            [UIApplication sharedApplication].keyWindow.rootViewController = tabbarcontroller;
//                            
                        
                            
                            
//                        }
                        
                    }
                    else if ([uiin isEqualToString:@"MyNoviceCoupon"])
                    {
                        RedEnvelopesController   *experienceVC = [[RedEnvelopesController alloc]init];
                        
                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.5;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = @"pageCurl";
                        animation.type = kCATransitionPush;
                        animation.subtype = kCATransitionFromRight;
                        [self.view.window.layer addAnimation:animation forKey:nil];
                        
                        [self presentViewController:experienceVC animated:NO completion:nil];
                        
                        
                        
                    }
                }else if([ui isEqualToString:@"CloseWindow"]||[ui isEqualToString:@"OperationException"])
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
    
    
   
    titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);

    
    
}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载失败 错误： %@", error);
}







#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"正在载入";
    titleLabel.font = [UIFont systemFontOfSize:16];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)chebade:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
