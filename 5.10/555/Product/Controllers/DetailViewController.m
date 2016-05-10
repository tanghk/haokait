//
//  DetailViewController.m
//  555
//
//  Created by otouzi on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "DetailViewController.h"
#import "UICommons.h"
#import "TouziViewController.h"
#import "AFNetworking.h"//网络请求
#import "UIViewExt.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CLLockVC.h"
#import "DengluViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "disafangViewController.h"
#import "kaitonghuifuyindao.h"
#import "RiskGuaranteeViewController.h"
#import "anquanViewController.h"
#import "chongzhiViewController.h"
#import "UIImageView+WebCache.h"
#import "InvestmentViewController.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "SafeViewController.h"
#import "RiskController.h"
@interface DetailViewController ()<MBProgressHUDDelegate>{
    
    NSString *_parameter;//参数
    NSString *_event;//事件名称
    UIView *_promptView;//提示弹窗
    UILabel *_contentLabel;//提示窗文字
    UILabel *_titleLabel ;
UIActivityIndicatorView *_indicatorView; //加载控件
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;

}

@property(nonatomic, strong) UIWebView *webView;
@end

@implementation DetailViewController

- (void)dealloc {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];


    
        //4.移除通知的监听
       // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSucess" object:nil];
    
        
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newProductLoginSuccess" object:nil];
    

}

- (void)viewWillAppear:(BOOL)animated{
  

    [super viewWillAppear:animated];
    
      [self requestWebViewURL];
//      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestWebViewURL) name:@"investSucess" object:nil];
       [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(jumpTouzi) name:@"touziAciton"  object:nil];
    _loopImages = [NSMutableArray array];
     [self.view addSubview:_webViewProgressView];
  }
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWithNavGation];

    [self createWebView];//创建网页视图
 // self.navigationController.navigationBar.hidden = NO;
    _lastWindow =[UIApplication sharedApplication].windows.lastObject ;//当前的window

   self.view.backgroundColor = [UIColor whiteColor];
  
    [self createCalculatorAndTouziButton];//创建计算器和立即投资按钮
    
    [self promptWindow];
    
    
    
  

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
    
    
    _titleLabel= [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(88*__kScreenWidth__/750, 68/2, kScreenWidth-(2*88*__kScreenWidth__/750), 32/2);
    _titleLabel.text = @"产品详情";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    //_titleLabel.textColor = [UIColor whiteColor];
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
#pragma mark -setModel
- (void)setModel:(ListModel *)model{
    
    _model = model;
    NSLog(@"%@",_model);
    
    
    //可投资金额
    CGFloat st = [_model.money floatValue];
    CGFloat sr =[_model.total_invest_money floatValue];
    _difference = (st - sr);
    
    
    NSDictionary *extandDic =_model.extend;
    _productUrlString = [extandDic objectForKey:@"href"];
    NSLog(@"产品url地址%@",_productUrlString);
   
   _revenueStr = _model.revenue;
    NSLog(@"年华收益%@",_revenueStr);
   
    _delineStr = _model.deadline;
   
    _way_repayment = _model.way_repayment;
    NSLog(@"投资方式%@",_way_repayment);
    
    _way_repayment_key = model.way_repayment_key;
    _deadline_key =model.deadline_key;
     NSLog(@"投资期限%@",_deadline_key);
    _increase =[NSString stringWithFormat:@"%@",model.increase];

    
    
}
#pragma mark - 加载网页
- (void)createWebView{


    /**是否开通汇付*/
    _openAccountType = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];

    if ([_way_repayment_key isEqualToString:@"4"]) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64.5,kScreenWidth,kScreenHeight-64.5)];
        //_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,44.5,kScreenWidth,kScreenHeight-44.5)];
        
    }else{
        if ( [_openAccountType isEqualToNumber:@1]){
            
           _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64.5,kScreenWidth,kScreenHeight-(24+23)*kWidthScale-88/2-64.5)];
            
           // _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,44.5,kScreenWidth,kScreenHeight-(24+23)*kWidthScale-88/2-44.5)];
            
        }
        else{
            
           _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64.5,kScreenWidth,kScreenHeight-(24+23+84)*kWidthScale-88/2-64.5)];
           // _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,44.5,kScreenWidth,kScreenHeight-(24+23+84)*kWidthScale-88/2-44.5)];
        }
        
        
    }
    
 
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
#pragma mark - 网络请求
- (void)requestWebViewURL{

  
    //沙盒路径
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *session = [notFirstDic objectForKey:@"sb"];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    

    NSURL *url = [NSURL URLWithString:_productUrlString];
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
           }




-(void)getParam1:(NSString*)str1 withParam2:(NSString*)str2 sbParam3:(NSString *)str3
{
    NSLog(@"收到html传过来的参数：str1=%@,str2=%@,str3= %@",str1,str2,str3);
}



#pragma mark - 创建视图

//创建计算器和投资按钮
- (void)createCalculatorAndTouziButton{
    //创建计算器按钮

   
    _calculatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _calculatorButton.frame = CGRectMake(14*kWidthScale, kScreenHeight - 24*kWidthScale-88/2, 88/2, 88/2);
    
    
    if (_difference == 0) {
        [_calculatorButton setImage:[UIImage imageNamed:@"6productDetails5_2@2x.png"] forState:UIControlStateNormal];
        _calculatorButton.backgroundColor = [UIColor whiteColor];
           }else if(_difference > 0)
    {
        [_calculatorButton setImage:[UIImage imageNamed:@"6productDetails5"] forState:UIControlStateNormal];
        _calculatorButton.backgroundColor = [UIColor whiteColor];
        [_calculatorButton addTarget:self
                              action:@selector(calculatorButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    if ([_way_repayment_key isEqualToString:@"4"]) {
        _calculatorButton.hidden = YES;
        
    }else{
        
    }

    [self.view addSubview:_calculatorButton];
    
    //创建投资按钮
    _touziButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _touziButton.frame = CGRectMake((14+14)*kWidthScale +88/2, kScreenHeight - 24*kWidthScale-88/2, kScreenWidth-((14+14+14)*kWidthScale +88/2),88/2);
    
    [_touziButton setTitle:@"立即投资" forState:UIControlStateNormal];
    _touziButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    _touziButton.tintColor = [UIColor blackColor];
    
    if (_difference == 0) {
          [_touziButton setBackgroundColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1]];
    }else if (_difference > 0)
    {

        [_touziButton setBackgroundColor:kColorRed];
        [_touziButton addTarget:self
                         action:@selector(touziAction)
               forControlEvents:UIControlEventTouchUpInside];

    }
    if ([_way_repayment_key isEqualToString:@"4"]) {
        _touziButton.hidden = YES;
        
    }else{
        
    }
    

    [self.view addSubview:_touziButton];
    
    _promptingLabel = [[UILabel alloc]init];
    _promptingLabel.frame = CGRectMake(0, kScreenHeight-(24+23+84)*kWidthScale-88/2, kScreenWidth, 84*kWidthScale);
    _promptingLabel.textColor = kColorWhite;
    _promptingLabel.backgroundColor = RGB(233, 76, 61, 0.8);
    _promptingLabel.font = [UIFont systemFontOfSize:22/2];
    [self.view addSubview:_promptingLabel];

    /**是否是新手标*/
    if ([_way_repayment_key isEqualToString:@"4"]) {
        _promptingLabel.hidden = YES;
        
        
    }else{
        
    }
    /**是否开通汇付*/
    _openAccountType = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
    
    if ( [_openAccountType isEqualToNumber:@1]){
        
        _promptingLabel.hidden = YES;
        
    }
    else{
        
        NSString *pk = [[NSUserDefaults standardUserDefaults]objectForKey:@"code1"];
        int pc = [pk intValue];
        if (pc != 200) {
            _promptingLabel.text = @"请到“首页”点击右上角“登录";
            
            _promptingLabel.textAlignment = NSTextAlignmentCenter;
            
            [_calculatorButton setImage:[UIImage imageNamed:@"6productDetails5_2@2x.png"] forState:UIControlStateNormal];
            
            _calculatorButton.userInteractionEnabled = NO;
            [_touziButton setBackgroundColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1]];
            _calculatorButton.userInteractionEnabled = NO;
            
        }else{
            
            
            if (![_openAccountType isEqualToNumber:@1]){
                _promptingLabel.text = @"为了您的资金安全，请先到”我的-充值“进行实名认证";
            _promptingLabel.textAlignment = NSTextAlignmentCenter;
            [_calculatorButton setImage:[UIImage imageNamed:@"6productDetails5_2@2x.png"] forState:UIControlStateNormal];
            
            _calculatorButton.userInteractionEnabled = NO;
            [_touziButton setBackgroundColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1]];
            _calculatorButton.userInteractionEnabled = NO;
        }else{
        
        
//            _promptingLabel.text = @"为了您的资金安全，请到”我的-账户设置“进行实名认证";
//            _promptingLabel.textAlignment = NSTextAlignmentCenter;
//            [_calculatorButton setImage:[UIImage imageNamed:@"6productDetails5_2@2x.png"] forState:UIControlStateNormal];
//            
//            _calculatorButton.userInteractionEnabled = NO;
//            [_touziButton setBackgroundColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1]];
//            _calculatorButton.userInteractionEnabled = NO;
//
        }
        
        }

        
    }
    }
#pragma mark - 懒加载计算器视图
-(void)createCalculatorView{

    _calculatorView = [[UIView alloc]init];
    _calculatorView.frame = CGRectMake(24*kWidthScale, -542*kWidthScale, kScreenWidth-(24+24)*kWidthScale, 542*kWidthScale);
    _calculatorView.backgroundColor = [UIColor whiteColor];
    _calculatorView.layer.cornerRadius = 10;
    
    //计算机标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(30*kWidthScale, 32*kWidthScale, 120/2, 24/2);
    titleLabel.text = @"收益计算器";
    titleLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_calculatorView addSubview:titleLabel];
    
    //背景色
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 90*kWidthScale, _calculatorView.width, 153*kWidthScale);
    bgView.backgroundColor = RGB(35, 34, 57, 1);

    [_calculatorView addSubview:bgView];
    
    //关闭按钮
    UIButton *closeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(_calculatorView.width-28*kWidthScale-45/2,23*kHeightScale, 45/2, 45/2);
    [closeButton setImage:[UIImage imageNamed:@"6counter"] forState:UIControlStateNormal ];
    [closeButton addTarget:self
                    action:@selector(closeButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [_calculatorView addSubview:closeButton];
    
    //产品收益text
    UILabel *incomeTextLabel= [[UILabel alloc]init];
    incomeTextLabel.frame = CGRectMake(30*kWidthScale, 33*kWidthScale, 300/2, 30/2);
    incomeTextLabel.text = @"产品到期收益为(元)";
    //incomeTextLabel.layer.cornerRadius = 10;
    incomeTextLabel.textColor = [UIColor whiteColor];
    incomeTextLabel.clipsToBounds = YES;
    incomeTextLabel.font = [UIFont systemFontOfSize:30/2];
    
    
    [bgView addSubview:incomeTextLabel];
    
    //产品收益
    _incomeLabel = [[UILabel alloc]init];
    _incomeLabel.frame = CGRectMake((30+23)*kWidthScale+260/2, 33*kWidthScale, _calculatorView.width - (30+23)*kWidthScale-300/2,30/2) ;
    _incomeLabel.text = @"00.00";
    _incomeLabel.font = [UIFont systemFontOfSize:30/2];
    _incomeLabel.textColor = kColorRed;
    _incomeLabel.textAlignment = NSTextAlignmentLeft;
    
    [bgView addSubview:_incomeLabel];
    
    //是银行活期利息的9倍
    _introductionLabel = [[UILabel alloc]init];
    _introductionLabel.frame = CGRectMake(30*kWidthScale, (33+32)*kWidthScale+30/2, _calculatorView.width, 30/2);
    _introductionLabel.textColor = kColorBlue;
    _introductionLabel.text = @"是银行活期利息的9倍，银行活期利息0元";
    _introductionLabel.font = [UIFont systemFontOfSize:24/2];
    
    [bgView addSubview:_introductionLabel];
    
    /*
     *投资金视图
     */
    
    _investView = [[UIView alloc]init];
    _investView .frame = CGRectMake(0, (90+153)*kWidthScale, _calculatorView.width, 116*kWidthScale);
    [_calculatorView addSubview:_investView];
    
    
    //投资金额textlabel
    UILabel  *totalInvestMoneyTextLabel = [[UILabel alloc]init];
    totalInvestMoneyTextLabel.frame = CGRectMake(30*kWidthScale, 22*kWidthScale, 97/2,70/2);
    totalInvestMoneyTextLabel.text = @"投资金额";
    
    totalInvestMoneyTextLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_investView addSubview:totalInvestMoneyTextLabel];
    

    //投资金额textfield
    _totalInvestMoneyTextField = [[UITextField alloc]init];
    _totalInvestMoneyTextField.frame = CGRectMake((30+31)*kWidthScale+97/2, 22*kWidthScale, 456*kWidthScale, 70/2);
    _totalInvestMoneyTextField.placeholder  = @"请输入投资金额";
    _totalInvestMoneyTextField.font = [UIFont systemFontOfSize:24/2];
    _totalInvestMoneyTextField.textAlignment = NSTextAlignmentCenter;
    _totalInvestMoneyTextField.delegate = self;
    _totalInvestMoneyTextField.layer.borderWidth = 1;
    _totalInvestMoneyTextField.layer.borderColor = [kColorLightGray CGColor];
   _totalInvestMoneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _totalInvestMoneyTextField.clearButtonMode = UITextFieldViewModeAlways;
    [_totalInvestMoneyTextField addTarget:self
                                   action:@selector(textField:)
                         forControlEvents:UIControlEventEditingChanged];
    
    NSLog(@"%@",_totalInvestMoneyTextField.text );
   
    [_investView addSubview:_totalInvestMoneyTextField];
    
    //（元）单位
    UILabel *moneyUnitLabel = [[UILabel alloc]init];
    moneyUnitLabel.frame = CGRectMake(_calculatorView.width - 31*kWidthScale-24/2, 46*kWidthScale, 24/2,24/2);
    moneyUnitLabel.text = @"元";
    moneyUnitLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_investView addSubview:moneyUnitLabel];
    
    /*
     *提示信息
     */
    
    _promptingLabel =[[UILabel alloc]init];
    _promptingLabel.frame = CGRectMake((30+31)*kWidthScale+97/2, 22*kWidthScale+70/2, 456*kWidthScale, 0);
    _promptingLabel.text = @"输入金额必须是100的正整数倍";
    _promptingLabel.textColor = kColorRed;
    _promptingLabel.font = [UIFont systemFontOfSize:24/2];
   // _promptingLabel.hidden = YES;
    [_investView addSubview:_promptingLabel];
    
   /*
    *年华收益视图
    */
    
    _revenueView = [[UIView alloc]init];
    _revenueView.frame = CGRectMake(0, (90+153+116)*kWidthScale, _calculatorView.width, 91*kWidthScale);
    
    [_calculatorView addSubview:_revenueView];
    

   //年华收益text
    UILabel  *revenueTextLabel = [[UILabel alloc]init];
    revenueTextLabel .frame = CGRectMake(30*kWidthScale, 33*kWidthScale, 120/2, 24/2);
    revenueTextLabel .text = @"年化收益";
    revenueTextLabel.font = [UIFont systemFontOfSize:24/2];
   // totalInvestMoneyTxetLabel.font = [UIFont systemFontOfSize:15];
 
    [_revenueView addSubview:revenueTextLabel ];

    //年华收益
    _revenueLabel =[[UILabel alloc]init];
    _revenueLabel.frame = CGRectMake(_calculatorView.width-31*kWidthScale-160/2, 33*kWidthScale,180/2, 24/2);
  
    
    if ([_increase isEqualToString:@"0"]||[_increase isEqualToString:@"0.00"]||[_increase isEqualToString:@"0.0"]) {
        NSString *revenueStr = [NSString stringWithFormat:@"%@%%",_revenueStr];
        _revenueLabel.text = revenueStr;
    }else
    {
        
        
      
        double revenue = [_revenueStr doubleValue];
        
        double increasenum =  [_increase  doubleValue];
        
        NSString *revenueStr = [NSString stringWithFormat:@"%.1f%%+%.1f%%",revenue,increasenum];
        _revenueLabel.text = revenueStr;
    }
   // NSString *revenueStr = [NSString stringWithFormat:@"%@%%+%@%%",_revenueStr,_increase];
   
    
    
    _revenueLabel.font = [UIFont systemFontOfSize:24/2];
    _revenueLabel.textAlignment = NSTextAlignmentRight;
   // _revenueLabel.layer.borderWidth = 1;
 //   _revenueLabel.text = revenueStr;
    _revenueLabel.textColor = kColorRed;
    [_revenueView addSubview:_revenueLabel];
    
    /*
     *投资期限
     */
    
    _deadlineView = [[UIView alloc]init];
    _deadlineView.frame = CGRectMake(0, (90+153+116+91)*kWidthScale, _calculatorView.width, 91*kWidthScale);
    [_calculatorView addSubview:_deadlineView];
    
    //投资期限text
    UILabel *deadlineTextLabel = [[UILabel alloc]init];
    deadlineTextLabel.frame = CGRectMake(30*kWidthScale, 33*kWidthScale,96/2, 24/2);
    deadlineTextLabel.text = @"投资期限";
    deadlineTextLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_deadlineView addSubview:deadlineTextLabel];
    
    
    //投资期限
    _delineLabel = [[UILabel alloc]init];
    _delineLabel.frame = CGRectMake(_calculatorView.width-31*kWidthScale-88/2,33*kWidthScale, 88/2, 24/2);
    _delineLabel.text =_delineStr;
   // _delineLabel.layer.borderWidth = 1;
    _delineLabel.textAlignment = NSTextAlignmentRight;
    //_delineLabel.text = @"1个月";
    _delineLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_deadlineView addSubview:_delineLabel];

    /*
    *分割线
    */
    
    _linelabel =[[UILabel alloc]init];
    _linelabel.frame = CGRectMake(0, _investView.height-1, _investView.width, 1);
    _linelabel.backgroundColor = kColorLightGray;
    [_investView addSubview:_linelabel];
    
    /*
     *分割线
     */
    _lineNextLabel = [[UILabel alloc]init];
    _lineNextLabel.frame = CGRectMake(0, _revenueView.height-1, _investView.width, 1);
    _lineNextLabel.backgroundColor = kColorLightGray;
    [_revenueView addSubview:_lineNextLabel];
    
    
      [_lastWindow addSubview:_calculatorView];

   
}
#pragma mark -创建遮盖视图

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
    
    //在某个子视图上面插入一个视图
    //[self insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
    
    //在某个子视图下面插入一个视图
    [_lastWindow insertSubview:_maskView belowSubview:_calculatorView];
    
    //根据下标插入
    //[self insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>];
    
    
}


#pragma mark -计算机按钮点击事件
//计算器按钮的点击事件
- (void)calculatorButtonAction:(UIButton*)sender{
    [self createCalculatorView];//计算器视图
    [self createMaskView];//遮盖视图

      [self showCalculatorView];
    
    
    
}


//显示尾部视图
- (void)showCalculatorView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                         _calculatorView.transform = CGAffineTransformMakeTranslation(0, _calculatorView.height+171*kWidthScale+kNavigationBarHeight);
                         _maskView.hidden = NO;//遮罩显示
                     }];
    
}


//隐藏尾部视图
- (void)hideCalculatorView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                           _promptingLabel.height = 0;
                         _calculatorView.transform = CGAffineTransformMakeTranslation(0, 1600);
                         _totalInvestMoneyTextField.text = @"";
                         _incomeLabel.text = @"00.00";
                         
                           _maskView.hidden = YES;
                     } completion:^(BOOL finished) {
                       
                         [_calculatorView removeFromSuperview];
                      
                         _calculatorView=nil;

                       // _calculatorView.transform = CGAffineTransformIdentity;
                     }];
    
 


}

//关闭计算器按钮
- (void)closeButtonAction:(UIButton *)sendder{
   
    double textValue =  [_totalInvestMoneyTextField.text doubleValue] ;
    
    _principal = [NSString stringWithFormat:@"%.10f",textValue];
    NSLog(@"text1= %@",_principal);
    
   
    [self hideCalculatorView];
  
    [_totalInvestMoneyTextField resignFirstResponder];//键盘释放第一响应者
  
   
}


//遮盖视图的点击事件
- (void)maskViewAction:(UIControl *)sender{

   _promptView.hidden = YES;
    [_totalInvestMoneyTextField resignFirstResponder];
    _maskView.hidden = YES;//隐藏遮盖视图
    [UIView animateWithDuration:.35
                     animations:^{
                         _calculatorView.transform = CGAffineTransformMakeTranslation(0, 1600);
                         _maskView.hidden = YES;
                         _promptingLabel.height = 0;
                         _totalInvestMoneyTextField.text = @"";
                         _incomeLabel.text = @"00.00";

                                            } completion:^(BOOL finished) {
                    
         
                                                [_calculatorView removeFromSuperview];
                                                [self createCalculatorView];
                        // _calculatorView.transform = CGAffineTransformIdentity;
                                                
                                              }];
    
  

}

- (void)textField:(UITextField *)textField
{
    NSLog(@"----------%@",textField.text);
       int invest = [textField.text intValue];
    NSLog(@"*********%d",invest%10 != 0 );

    if ([textField.text intValue]<10||invest%10 != 0 ) {
        
        _promptingLabel.height = 70/2;
   
        if ([textField.text isEqualToString:@""]){
            _promptingLabel.height = 0;
            
        }
    }else if ([textField.text intValue]>=10){
       
        _promptingLabel.height = 0;

    }
    
    if (invest >=_difference ){
        textField.text =[NSString stringWithFormat:@"%d",(int)_difference];//取整形
        _promptingLabel.height = 0;

    }
    
    _investView .frame = CGRectMake(0, (90+153)*kWidthScale, _calculatorView.width, 116*kWidthScale+_promptingLabel.height);
    _linelabel.frame = CGRectMake(0, _investView.height-1, _investView.width, 1);
    _revenueView.frame = CGRectMake(0, (90+153+116)*kWidthScale+_promptingLabel.height, _calculatorView.width, 91*kWidthScale);
    _deadlineView.frame = CGRectMake(0, (90+153+116+91)*kWidthScale+_promptingLabel.height, _calculatorView.width, 91*kWidthScale);
     _calculatorView.frame = CGRectMake(24*kWidthScale, 171*kWidthScale+kNavigationBarHeight-70/2, kScreenWidth-(24+24)*kWidthScale, 542*kWidthScale+_promptingLabel.height);
    
    
     textField.clearsOnBeginEditing = YES;
    double textValue =  [_totalInvestMoneyTextField.text doubleValue] ;
    
    _principal = [NSString stringWithFormat:@"%.10f",textValue];
   // NSLog(@"text1= %@",_principal);
    
    
    //年华收益
    double  revenueValue = [_revenueLabel.text doubleValue];
    double increaseValue = [_increase  doubleValue];//角标
    double revenue = revenueValue/100;
    double increase = increaseValue/100;
       NSLog(@"%.10f",sum);

   
    _revenue = [NSString stringWithFormat:@"%.10f",revenue];
   // NSLog(@"text2=%@",_revenue);
    _increaseStr = [NSString stringWithFormat:@"%.10f",increase];

    //求幂次的方法
    /*
     double s = pow([_principal doubleValue], delineValue);
     NSLog(@"输出的结果是%.2f",s);
     */
    
    //按月付息 到期还本     ，到期还本付息
    
    sum = ([_principal doubleValue]*([_revenue doubleValue]+[_increaseStr doubleValue])* [_deadline_key intValue])/365;//输入金额＊年华收益＊投资期限＊30/365
    
    
    NSLog(@"%.10f",sum);
    
        //计算器保留小数点后两位
        NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler
    
                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
    
                                           scale:2
    
                                           raiseOnExactness:NO
    
                                           raiseOnOverflow:NO
    
                                        raiseOnUnderflow:NO
    
                                           raiseOnDivideByZero:YES];
    
        NSDecimalNumber *ouncesDecimal;
        NSDecimalNumber *roundedOunces;
    
        ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:sum];
        roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundDown];
    
        NSString *str = [NSString stringWithFormat:@"%@",roundedOunces];
    NSLog(@"保留两位小数%@",str);

    
    //设贷款额为a，月利率为i，年利率为I，还款月数为n，每月还款额为b，还款利息总和为Y
    //还款总额:n×a×i×（1＋i）^n÷〔（1＋i）^n－1〕
    //注:a^b表示a的b次方。
    
    
    //_principal  投资金额   _tex2 年华收益
    // [_principal doubleValue]   //[_revenue doubleValue]
    
    //月利率  年化收益／12  保留10位
    CGFloat mouthValue = ([_revenue doubleValue]+[_increaseStr doubleValue])/12;//[_revenue doubleValue]
    
    
   
    NSLog(@"月利率%.10f",mouthValue);
    
    //本金＊月利率 保留10位
    CGFloat tempA =  [_principal doubleValue]* mouthValue;
    NSLog(@"本金＊月利率 保留10位 =%.10f",tempA);
  
    //幂的值
    double upPowerValue = pow(1+mouthValue, [_deadline_key intValue]);
    NSLog(@"upPowerValue =%.10f",upPowerValue);
    
    //月收本息
    double allsum = ([_principal doubleValue]*mouthValue *upPowerValue)/(upPowerValue-1);
    
    NSString * allSumSave = [NSString stringWithFormat:@"%.2f",allsum];
    NSLog(@"allSumSave = %@",allSumSave);
    
    
    // 应收利息
    double getMoney = [allSumSave doubleValue] *[_deadline_key intValue] ;
    NSString * money = [NSString stringWithFormat:@"%.2f",getMoney];
    
    text = [money doubleValue]-[_principal doubleValue];
    NSLog(@"%.10f",getMoney);
    
    //产品收益label 赋值
   
    if ([_way_repayment_key intValue] ==2) {//按月等额本息
        //产品收益label 赋值
        _incomeLabel.text = [NSString stringWithFormat:@"%.2f",text];//产品收益赋值
        factor = text/9;
        
            }
    else  if([_way_repayment_key intValue] ==3){// 到期返本付息
       

      _incomeLabel.text = [NSString stringWithFormat:@"%@",str];
      
        factor = [str doubleValue]/9;
        if ([str isEqualToString:@"0"])  {
            _incomeLabel.text = @"00.00";
        }
    }else{//"按月付息 到期返本"
      _incomeLabel.text = [NSString stringWithFormat:@"%@",str];
       factor = [str doubleValue]/9;
        if ([str isEqualToString:@"0"])  {
            _incomeLabel.text = @"00.00";
        }
    }
    
    
    
    
    //计算器保留小数点后两位
    NSDecimalNumberHandler *factorRoundDown = [NSDecimalNumberHandler
                                         
                                         decimalNumberHandlerWithRoundingMode:NSRoundDown
                                         
                                         scale:2
                                         
                                         raiseOnExactness:NO
                                         
                                         raiseOnOverflow:NO
                                         
                                         raiseOnUnderflow:NO
                                         
                                         raiseOnDivideByZero:YES];
    
    NSDecimalNumber *factorOuncesDecimal;
    NSDecimalNumber *factorRoundedOunces;
    
    factorOuncesDecimal = [[NSDecimalNumber alloc] initWithFloat:factor];
    factorRoundedOunces = [factorOuncesDecimal  decimalNumberByRoundingAccordingToBehavior:factorRoundDown];
    
    NSString *factorStr = [NSString stringWithFormat:@"%@",factorRoundedOunces];
    
    
    
  _introductionLabel.text =[NSString stringWithFormat: @"是银行活期利息的9倍，银行活期利息%@元",factorStr];
}

# pragma mark - texfieild代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
 
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"%@",textField.text);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑");
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_totalInvestMoneyTextField == textField)
    {
        if ([toBeString length] > 20) {
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"超过最大字数不能输入了"
                                                           delegate:nil cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
        
        if ([toBeString length]==0) {
          
        }
    }
    return YES;
}



//投资按钮点击事件

#pragma mark - 投资按钮点击事件
- (void)touziAction{
    
    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
     _openAccountType =  [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
    if (panduan != 200 ) {
        

        _touziButton.userInteractionEnabled = NO;
    }else{
    
        if ([_openAccountType isEqualToNumber:@1]) {
            /*
            TouziViewController *touziViewController = [[TouziViewController alloc]init];
                        touziViewController.model = _model;
            
                        NSLog(@"%@",touziViewController.model);

                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.5;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = @"pageCurl";
                        animation.type = kCATransitionPush;
                        animation.subtype = kCATransitionFromRight;
                        [self.view.window.layer addAnimation:animation forKey:nil];
                        
                 
             [self presentViewController:touziViewController animated:NO completion:nil];
*/
            
            TouziViewController *touziViewController = [[TouziViewController alloc]init];
            touziViewController.model = _model;
            touziViewController.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:touziViewController animated:YES];
            

        }else{
        
            
            _touziButton.userInteractionEnabled = NO;

        
        }
    
    
    
    }
    
//
//    _openAccountType =  [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
//    
//    
//    
//    
//    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
//    int panduan = [banduan intValue];
//    
//    if (panduan != 200 ) {
//        
//        
//        DengluViewController *loginVC =[[DengluViewController alloc]init];
//        loginVC.model = _model;
//        loginVC.statues = @"000";
//        [self presentViewController:loginVC animated:YES completion:^{
//           NSString *fromProduct = @"fromPrduct";
//          
//        [[NSUserDefaults standardUserDefaults]setObject:fromProduct forKey:@"fromProduct"];
//            
//            
//            
//            NSLog(@"请先登录然后在进行投资");
//            
//            
//            
//        }];
//        
//        [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(jumpTouzi) name:@"loginSuccess"  object:nil];
//        
//        
//    }else if (panduan == 200){//
//        
//        
//        if ( [_openAccountType isEqualToNumber:@1]) {
//            
//            
//            TouziViewController *touziViewController = [[TouziViewController alloc]init];
//            touziViewController.model = _model;
//            
//            NSLog(@"%@",touziViewController.model);
//
//            
//            CATransition *animation = [CATransition animation];
//            animation.duration = 0.5;
//            animation.timingFunction = UIViewAnimationCurveEaseInOut;
//            animation.type = @"pageCurl";
//            animation.type = kCATransitionPush;
//            animation.subtype = kCATransitionFromRight;
//            [self.view.window.layer addAnimation:animation forKey:nil];
//            
//            [self presentViewController:touziViewController animated:NO completion:nil];
//
//        }else{
//            
////            kaitonghuifuyindao* third = [[kaitonghuifuyindao alloc]init];
////            //            third.type = @"1";
////            third.model = _model;
////            [self presentViewController:third animated:YES completion:^{
////                NSLog(@"挑战到汇付天下");
////            }];
//            /*
//             *没有开通恢复 弹出提示窗口
//             */
//            
//            
//            [UIView animateWithDuration:.35 animations:^{
//                _promptView.hidden = NO;
//                _maskView.hidden = NO;
//            }];
//            
//
//        }
//        
//        
//        
//        
//        
//    }
}


#pragma mark - Notification

- (void)fitKeyboardShow:(NSNotification *)notification {
    _calculatorView.frame = CGRectMake(24*kWidthScale, 171*kWidthScale+kNavigationBarHeight-70/2, kScreenWidth-(24+24)*kWidthScale, 542*kWidthScale+_promptingLabel.height);
    

   NSLog(@"%@", notification.userInfo);
    /*
     UIKeyboardAnimationCurveUserInfoKey = 7; 动画的样式options
     UIKeyboardAnimationDurationUserInfoKey = "0.25";  动画持续时间
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";  键盘的Bounds
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
     键盘出现之前的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     键盘显示完全之后的frame
     */
    
    //取出键盘高度rect
    NSValue *value =
    [notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect = [value CGRectValue];
    
    //修改textView底部距离屏幕底部约束为键盘的高度
   // self.textViewBottomConstraint.constant = rect.size.height;
    
    //如果是键盘收起，则修改约束为50
    NSString *name = notification.name;
    if ([name isEqualToString:UIKeyboardWillHideNotification]) {
       // self.textViewBottomConstraint.constant = 50;
    }
    
    //取出键盘动画的时间
    CGFloat duration = [[notification.userInfo
                         objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    //键盘动画的样式
    NSUInteger curve = [[notification.userInfo
                         objectForKey:@"UIKeyboardAnimationCurveUserInfoKey"] integerValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve
                     animations:^{
                         //修改约束，要做出动画效果，让相关的视图重新布局
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         ;
                     }];
}


- (void)fitKeyboardHide:(NSNotification *)notification {
    
    NSLog(@"键盘收起");
}
//    //计算器保留小数点后两位
//    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
//
//                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
//
//                                       scale:2
//
//                                       raiseOnExactness:NO
//
//                                       raiseOnOverflow:NO
//
//                                    raiseOnUnderflow:NO
//
//                                       raiseOnDivideByZero:YES];
//
//    NSDecimalNumber *ouncesDecimal;
//    NSDecimalNumber *roundedOunces;
//
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:sum];
//    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundUp];
//      //NSLog( NSString stringWithFormat:@"%@",roundedOunces ) ;
//    NSString *str = [NSString stringWithFormat:@"%@",roundedOunces];
//NSLog(@"%@",str);
// _incomeLabel.text =str;

/*
 *提示窗口  提示开通恢复天下
 */
#pragma mark - 提示开通汇付天下
- (void)promptWindow{
    
    //提示弹窗
    _promptView = [[UIView alloc]init];
    _promptView.frame = CGRectMake(202*kPlusScale, 790*kPlusScale, kScreenWidth - (202+202)*kPlusScale, 340/3);
    _promptView.hidden = YES;
    _promptView.layer.cornerRadius = 3;
    _promptView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_promptView];

    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [_lastWindow insertSubview:_maskView belowSubview:_promptView];
    
    

    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(80*kPlusScale, 34*kWidthScale+12, _promptView.width-(80+80)*kPlusScale, 20);
 
    
    _contentLabel.font = [UIFont systemFontOfSize:28/2];
    _contentLabel.text = @"投资前请先开通汇付天下";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
   // _contentLabel.layer.borderWidth = 1;

    [_promptView addSubview:_contentLabel];
    
    //取消
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+(59+34)*kWidthScale, (_promptView.width-(82+82+44)*kPlusScale)/2 ,110*kPlusScale);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = RGB(180, 180, 180, 1);
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 3;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleButton addTarget:self
                     action:@selector(cancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag = 1001;
    [_promptView addSubview:cancleButton];
    
    //立即充值
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(82*kPlusScale+44*kPlusScale+(_promptView.width-(82+82+44)*kPlusScale)/2, _contentLabel.height+(59+34)*kWidthScale, (_promptView.width-(82+82+44)*kPlusScale)/2, 110*kPlusScale);
    [sureButton setTitle:@"去开通" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = RGB(211, 74, 89, 1);
    sureButton.layer.cornerRadius = 3;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    sureButton.tag = 1002;
    [_promptView addSubview:sureButton];
    
      
    
   
    
}



#pragma mark - WebView Delegate
//将要开始加载
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载");

//    _titleLabel.text = @"正在载入";
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
            
            /*
             *事件名称
             */
            
            if ([_event isEqualToString:@"OpenBrowser"]) {
                NSString *urlStr = [dic objectForKey:@"href"];
                NSLog(@"监听事件的网址%@",urlStr);
                
                if ([urlStr isEqualToString:@"http://debug.otouzi.com:8012/SiteNotice/riskReserveFund.html"]) {
//                   RiskGuaranteeViewController *riskGuaranteeVC = [[RiskGuaranteeViewController alloc]init];
//                    
                   // riskGuaranteeVC.urlStr = urlStr;
//                    
//                    CATransition *animation = [CATransition animation];
//                    animation.duration = 0.5;
//                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                    animation.type = @"pageCurl";
//                    animation.type = kCATransitionPush;
//                    animation.subtype = kCATransitionFromRight;
//                    [self.view.window.layer addAnimation:animation forKey:nil];
//                    [self presentViewController:riskGuaranteeVC animated:NO completion:nil];
                 
                    RiskController *riskVC = [[RiskController alloc]init];
                    //
                    
                    riskVC.urlStr = urlStr;

                    
                    [self.navigationController pushViewController:riskVC animated:YES];
                    
              
                }else if ([urlStr isEqualToString:@"http://debug.otouzi.com:8012/SiteNotice/insurance.html"]){
               
                    
                    /*
                    anquanViewController *anquanVC = [[anquanViewController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                 [self presentViewController:anquanVC animated:NO completion:nil];
                    */
                    SafeViewController *safeVC = [[SafeViewController alloc]init];
                    safeVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:safeVC animated:YES];
                    

                    
                  
                    

                }else {
                
                /*
                    InvestmentViewController *investmentVC = [[InvestmentViewController alloc]init];
                    investmentVC.urlStr = urlStr;
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    [self presentViewController:investmentVC animated:NO completion:nil];

                   */
                    InvestmentViewController *investmentVC = [[InvestmentViewController alloc]init];
                    investmentVC.urlStr = urlStr;

                    [self.navigationController pushViewController:investmentVC animated:YES];

                
                
                }
                
            }else if ([_event isEqualToString:@"OpenWindow"]||[_event isEqualToString:@"OperationSuccess"]){
            /*
             *参数名称
             */
            NSString *target = [dic objectForKey:@"target"];
            if ([target isEqualToString:@"ChinapnrOpenAccount"]) {//跳转汇付
 
                _openAccountType = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];

                NSLog(@"开通汇付状态%@",_openAccountType);
                if ( [_openAccountType isEqualToNumber:@1]) {
                    /*
                    TouziViewController *touziViewController = [[TouziViewController alloc]init];
                    touziViewController.model = _model;
                    
                    NSLog(@"%@",touziViewController.model);
                    
                    
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                    [self presentViewController:touziViewController animated:NO completion:nil];
                     */
                
                    
                    TouziViewController *touziViewController = [[TouziViewController alloc]init];
                    touziViewController.model = _model;
                    [self.navigationController pushViewController:touziViewController animated:YES];
 
                    
                }else{
     
                    /*
                     *没有开通恢复 弹出提示窗口
                     */
                    
                   
                    [UIView animateWithDuration:.35 animations:^{
                        _promptView.hidden = NO;
                        _maskView.hidden = NO;
                    }];
                 
//
                    
                }
            
            }else if ([target isEqualToString:@"NoviceProjectInvestment"]){//跳转投资页面
                
            
//            
//                TouziViewController *touziViewController = [[TouziViewController alloc]init];
//                touziViewController.model = _model;
//                
//                NSLog(@"%@",touziViewController.model);
//                
//                
//                CATransition *animation = [CATransition animation];
//                animation.duration = 0.5;
//                animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                animation.type = @"pageCurl";
//                animation.type = kCATransitionPush;
//                animation.subtype = kCATransitionFromRight;
//                [self.view.window.layer addAnimation:animation forKey:nil];
//                
//                [self presentViewController:touziViewController animated:NO completion:nil];
//            
                
                
                
                TouziViewController *touziViewController = [[TouziViewController alloc]init];
                touziViewController.model = _model;
                [self.navigationController pushViewController:touziViewController animated:YES];
                

            }else if ([target isEqualToString:@"UserLogin"]){
            
                
//                
//                UIAlertView *myalert = [[UIAlertView alloc]
//                                        initWithTitle:@"请先登录"
//                                        message:nil
//                                        delegate:self
//                                        cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
//                                        otherButtonTitles:nil];
//                
//                [myalert show];

// 
//                DengluViewController *loginVC =[[DengluViewController alloc]init];
//                loginVC.model = _model;
//                loginVC.statues = @"111";
//                [self presentViewController:loginVC animated:YES completion:^{
//                    NSString *fromProduct = @"fromNewPrduct";
//                    
//                    [[NSUserDefaults standardUserDefaults]setObject:fromProduct forKey:@"fromNewPrduct"];
// 
//                    
//                    NSLog(@"请先登录然后在进行投资");
//    
//                    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(lockView) name:@"newProductLoginSuccess"  object:nil];
//                    

               // }];
                
                
          
                
                
            }else if ([target isEqualToString:@"ChinapnrQuickRecharge"]){
            
            
                NSNumber *huifu = [[NSUserDefaults standardUserDefaults]objectForKey:@"huifuzhuangtai21"];
                
                int dese = [huifu intValue];
                if (dese == 0) {
                    
                    disafangViewController *disanfang= [[disafangViewController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionPush;
                    animation.subtype = kCATransitionFromRight;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    
                    [self presentViewController:disanfang animated:NO completion:nil];
                    
                }else if (dese == 1)
                {
                    
                    chongzhiViewController *chong =[[chongzhiViewController alloc]init];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"pageCurl";
                    animation.type = kCATransitionFromTop;
                    animation.subtype = kCATransitionFromBottom;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    [self presentViewController:chong animated:YES completion:nil];
                }

            
            
            
            }else if ([target isEqualToString:@"ProductPics"]){
            
                NSDictionary *args = [dic objectForKey:@"args"];
              _loopImages = [args objectForKey:@"picsList"];
               
                indexPoint = [args objectForKey:@"index"];
                   NSLog(@"点击第%@图片",indexPoint);
                NSLog(@"点击显示图片%@",_loopImages);
     
                alphaView = [[UIControl alloc]init];
                alphaView.backgroundColor = [UIColor blackColor];
                alphaView.alpha= 0.9;
                alphaView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                [alphaView addTarget:self action:@selector(alphaViewAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.view addSubview:alphaView];

           
//                //关闭按钮
               UIButton *closeScrollButton =[UIButton buttonWithType:UIButtonTypeCustom];

                closeScrollButton.frame = CGRectMake(kScreenWidth-31*kWidthScale-23, 32, 45/2, 45/2);
                closeScrollButton.userInteractionEnabled = YES;
                           [closeScrollButton setImage:[UIImage imageNamed:@"6counter"] forState:UIControlStateNormal ];
             [closeScrollButton addTarget:self
                               action:@selector(closeScrollButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
                
                [alphaView addSubview:closeScrollButton];

                
                scrVl=[[UIScrollView alloc] init];
              
                scrVl.pagingEnabled = YES;
                scrVl.delegate=self;
                scrVl.frame=CGRectMake(0, kScreenHeight/3,kScreenWidth, kScreenHeight/3);
                scrVl.bounces = NO;
                // scrollView中每个分页的尺寸
                CGSize scrollViewSize = scrVl.frame.size;
                scrVl.contentSize=CGSizeMake(kScreenWidth*(_loopImages.count),kScreenHeight/3 );
               // scrVl.contentOffset = CGPointMake(self.loopImages.count + 2 *kScreenWidth, 0);
            
                CGPoint initialOffset=  CGPointMake([indexPoint intValue]*scrollViewSize.width, 0);
                

                [scrVl setContentOffset:initialOffset];
  
                
                [self.view addSubview:scrVl];

                for (int i=0; i<_loopImages.count; i++) {
                   
                    UIImageView *imageView = [[UIImageView alloc]init];
                    imageView.frame = CGRectMake(42*kWidthScale+ kScreenWidth*i, 0, kScreenWidth-(2*42*kWidthScale),kScreenHeight/3);
                    [imageView sd_setImageWithURL:[NSURL URLWithString:_loopImages[i]]];
                    
                    [scrVl addSubview:imageView];
                    
                    
                 
                }
//
                
               
            
            
                //创建分页控件
                _pageControl = [[UIPageControl alloc]
                                initWithFrame:CGRectMake(44, 48,
                                                         kScreenWidth-88, 20)];
                
                _pageControl.numberOfPages = self.loopImages.count;
                              // pageControl 可以响应点击事件
                [_pageControl addTarget:self
                                 action:@selector(pageControlAction:)
                       forControlEvents:UIControlEventTouchUpInside];
                _pageControl.currentPage =(scrVl.contentOffset.x)/ scrVl.frame.size.width;
                
                [self.view addSubview:_pageControl];

            
            
            
            
            
            
            }
            
      
            } else if([_event isEqualToString:@"CloseWindow"]||[_event isEqualToString:@"OperationException"])
            {
                
//                
//                CATransition *animation = [CATransition animation];
//                animation.duration = 0.5;
//                animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                animation.type = @"pageCurl";
//                animation.type = kCATransitionPush;
//                animation.subtype = kCATransitionFromLeft;
//                [self.view.window.layer addAnimation:animation forKey:nil];
//                [self dismissViewControllerAnimated:NO completion:nil];
                
                
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
    
//     _titleLabel.text = @"产品详情";
//    _titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
//
    
    
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
    
    
    [self.navigationController popViewControllerAnimated:YES];
//    
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];

//
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionMoveIn;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    //[self dismissViewControllerAnimated:NO completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
//    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//    TabbarViewController *tab = [[TabbarViewController alloc]init];
//    delete.window.rootViewController = tab;
//  [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
}


/*
 *跳转投资页面
 */
- (void)jumpTouzi{

_openAccountType = [[NSUserDefaults standardUserDefaults]objectForKey:@"open_account"];

    
   
        
        if ( [_openAccountType isEqualToNumber:@1]) {
            
            
//            
//            if ([_way_repayment_key isEqualToString:@"4"]) {
//                [self lockView];
//            }
//            
//            
//            TouziViewController *touziViewController = [[TouziViewController alloc]init];
//            touziViewController.model = _model;
//            
//            
//            NSLog(@"%@",touziViewController.model);
//            [self.navigationController pushViewController:touziViewController animated:YES];

            TouziViewController *touziViewController = [[TouziViewController alloc]init];
            touziViewController.model = _model;
            
            NSLog(@"%@",touziViewController.model);
            
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"pageCurl";
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:animation forKey:nil];
            
            [self presentViewController:touziViewController animated:NO completion:nil];

            
        }else{
            
            
                    kaitonghuifuyindao * third = [[kaitonghuifuyindao alloc]init];
                    third.model = _model;
                    NSLog(@"注册汇付天下model = %@",third.model);
                    [self presentViewController:third animated:YES completion:^{
                        NSLog(@"跳转到汇付天下");
                    }];

                  }
        
        
        
        
    
    


}

/*
 *确认按钮
 */
- (void)sureAction:(UIButton *)sender{
    
    [UIView animateWithDuration:.35 animations:^{
        _promptView.hidden = YES;
        _maskView.hidden = YES;
        
        kaitonghuifuyindao * third = [[kaitonghuifuyindao alloc]init];
        third.model = _model;
        NSLog(@"登录成功汇付天下model = %@",third.model);
        
        [self presentViewController:third animated:YES completion:^{
            NSLog(@"跳转到汇付天下");
        }];
        

    }];
    }
/*
 *取消按钮
 */
- (void)cancleAction:(UIButton *)sender{
    
     _promptView.hidden = YES;
     _maskView.hidden = YES;
    
}

- (void)lockView{
    NSString *setType = [[NSUserDefaults standardUserDefaults]objectForKey:@"SetLockType"];
    
    if ([setType isEqualToString:@"1"]) {
        ;
    }else{
        
        
        BOOL hasPwd = [CLLockVC hasPwd];
        hasPwd = NO;
        if(hasPwd){
            
            NSLog(@"已经设置过密码了，你可以验证或者修改密码");
        }else{
            
            [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                
                
                
                
                NSString *setType = @"1";
                [[NSUserDefaults standardUserDefaults]setObject:setType forKey:@"SetLockType"];//设置手势密码
                
                NSLog(@"密码设置成功");
                
                
                
                NSString *type = @"1";
                [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"coreLockType"];//已经设置手密码
                [lockVC dismiss:1.0f];
            }];
        }
        
        
        
    }
    
}


#pragma UIScrollView delegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    
//    CGPoint offset = scrVl.contentOffset;
//    CGRect bounds = scrVl.frame;
//    [thePGLeft setCurrentPage:offset.x / bounds.size.width];
    

    //根据偏移量，计算切换到第几页
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
//    if (page == self.loopImages.count + 1) {
//        //如果是最后一页，跳转到第一个页面
//        CGPoint point = CGPointMake(scrollView.frame.size.width, 0);
//        [scrollView setContentOffset:point];
//        
//        page = 0;
//    } else if (page == 0) {
//        //如果是第一页，跳转到最后一个页面
//        CGPoint point =
//        CGPointMake(scrollView.frame.size.width * self.loopImages.count, 0);
//        [scrollView setContentOffset:point];
//        
//        page = self.loopImages.count-1;
//    } else {
//        page--;
//    }
//    
//   // thePGLeft.currentPage = page;

    _pageControl.currentPage = page;



}
- (void)closeScrollButtonAction:(UIButton*)sender{

    
   
                    
                         scrVl.alpha = 0.0;
                         alphaView.alpha = 0.0;
                         _pageControl.alpha = 0.0;
    
                 
}


- (void)alphaViewAction:(UIControl *)sender{

    scrVl.alpha = 0.0;
    alphaView.alpha = 0.0;
_pageControl.alpha = 0.0;
}

- (void)pageControlAction:(UIPageControl *)sender {
    //切换显示的图片
    NSInteger page = _pageControl.currentPage;
    //根据页数修改偏移量
    CGPoint point = CGPointMake((page) * scrVl.frame.size.width, 0);
   
    [scrVl setContentOffset:point animated:YES];
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    // self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
@end
