//
//  NewUerBieController.m
//  555
//
//  Created by otouzi on 16/4/21.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "NewUerBieController.h"
#import "Masonry.h"
#import "UICommons.h"
#import "AppDelegate.h"
#import "AFNetworking.h"//网络请求
#import "TabbarViewController.h"
#import "InvestSucessController.h"
#import "DataService.h"
#import "ChanpinViewController.h"

#import "disafangViewController.h"
#import "denglu02ViewController.h"
#import "chongzhiViewController.h"
#import "UIViewExt.h"
#import "HasInvestedBieController.h"
#import "NewUSerBieInvestController.h"
@interface NewUerBieController ()


{
    
    UILabel *_deadline;
    UILabel *_peopleCount;
    
    NSString *_deadline_Value;
    NSString  *_count ;
    
    
    UIWindow *_lastWindow;        //当前window
    UIControl *_maskView;         //遮挡视图
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
    
    NSNumber  *_openAccountType;//开通汇付的状态
    
    
    UIButton *_sureButton;
}



@end


@implementation NewUerBieController




- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    [self creatWithNavGation];
    [self requestprojectDeadLineNum];
    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMaskView];
    
    //    _deadline_Value = @"1";
    //    _count = @"132";
    
    
    self.view.backgroundColor = kcolorGrayNew;
    
    [self custumNewbie];
    
}

- (void)setModel:(ListModel *)model{
    _model = model;
    NSLog(@"%@",_model);
    
    
    _productId = model.product_id;
    
    
}




#pragma mark - 请求网络
- (void)requestprojectDeadLineNum{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"project_id":_productId   //要查询的产品id
                                     
                                     }];
    
    [DataService requestWithURL:@"/project/deadLineNum"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    
                    NSLog(@"新手体验标%@",result);
                    
                    
                    [self loadDeadLineNum:result];
                    
                    
                }];
    
}


#pragma mark -加载数据
- (void)loadDeadLineNum:(id)result{
    
    
    NSDictionary *response = result;
    NSNumber *code = [response objectForKey:@"code"];
    
    if ([code intValue] == 200) {
        NSDictionary *dataDic  = [response objectForKey:@"data"];
        
        
        _deadline_Value =[NSString stringWithFormat:@"%@",dataDic[@"deadline"]];
        _count = [NSString stringWithFormat:@"%@",dataDic[@"investCount"]];
        
        
        NSString *const Deadline = @"投资期限:";
        NSString *const Units = @"天";
        
        NSString *const Have = @"已有";
        NSString *const Join = @"人参与";
        
        NSString *deadlineStr = [NSString stringWithFormat:@"%@%@%@",Deadline,_deadline_Value,Units];
        NSMutableAttributedString *deadlineFullStr = [[NSMutableAttributedString alloc] initWithString:deadlineStr];
        NSRange deadlineRange = [[deadlineFullStr string] rangeOfString:_deadline_Value];
        NSRange deadlineRange1 = [[deadlineFullStr string] rangeOfString:Deadline];
        NSRange deadlineRange2 = [[deadlineFullStr string] rangeOfString:Units];
        [deadlineFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:deadlineRange];
        [deadlineFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:deadlineRange1];
        [deadlineFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:deadlineRange2];
        
        
        _deadline.attributedText = deadlineFullStr;
        
        
        
        
        
        
        
        
        NSString *peopleCountStr = [NSString stringWithFormat:@"%@%@%@",Have,_count,Join];
        NSMutableAttributedString *peopleCountFullStr = [[NSMutableAttributedString alloc] initWithString:peopleCountStr];
        NSRange peopleCountRange = [[peopleCountFullStr string] rangeOfString:_count];
        NSRange peopleCountRange1 = [[peopleCountFullStr string] rangeOfString:Have];
        NSRange peopleCountRange2 = [[peopleCountFullStr string] rangeOfString:Join];
        
        
        [peopleCountFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:peopleCountRange];
        [peopleCountFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:peopleCountRange1];
        [peopleCountFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:peopleCountRange2];
        
        
        _peopleCount.attributedText = peopleCountFullStr;
        
    }
}




#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = RGB(245, 245, 245, 1);
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"新手体验标";
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
#pragma mark -   创建新手标视图
- (void)custumNewbie{
    
    
    
    UIScrollView *scrol = [[UIScrollView alloc]init];
    scrol.frame = CGRectMake(0, 44.5, kScreenWidth, kScreenHeight-64.5);
    scrol.backgroundColor = kcolorGrayNew;
    scrol.contentSize = CGSizeMake(kScreenWidth, 1124*kHeightScale+75);
    
    
    [self.view addSubview:scrol];
    
    
    UIImageView *topView  = [UIImageView new];
    topView.image = [UIImage imageNamed:@"newbie_big"];
    topView.frame = CGRectMake(0, 0, kScreenWidth, 1124*kHeightScale);
    
    [scrol addSubview:topView];
    
    
    
    /*
     *投资期限
     */
    //    NSString *prompt = [NSString stringWithFormat:@"%@%@",Invest_Money,_model.money];
    //    NSMutableAttributedString *mulFullStr = [[NSMutableAttributedString alloc] initWithString:prompt];
    //    NSRange range = [[mulFullStr string] rangeOfString:_model.money];
    //    [mulFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:range];
    //
    //    _moneyLabel.attributedText = mulFullStr;
    
    
    
    _deadline= [[UILabel alloc]init];
    _deadline.textAlignment =NSTextAlignmentCenter;
    _deadline.font = Font(26/2);
    //_deadline.text = @"投资期限：1天";
    [topView addSubview:_deadline];
    
    [_deadline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(12);
        make.right.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(26*kHeightScale);
        make.top.equalTo(topView.mas_top).offset(519*kHeightScale);
        
        
        
    }];
    
    /*
     *参与人数
     */
    _peopleCount= [[UILabel alloc]init];
    _peopleCount.font = Font(26/2);
    _peopleCount.text = @"已有153人参与";
    _peopleCount.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_peopleCount];
    
    [_peopleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(26*kHeightScale);
        make.top.equalTo(topView.mas_top).offset(519*kHeightScale);
        
        
        
    }];
    
    
    
    
    UIView *invest = [UIView new];
    invest.backgroundColor = kcolorGrayNew;
    [self.view addSubview:invest];
    
    
    [invest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left .equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(150/2);
    }];
    
    
    
    
    UIButton *investBtn = [UIButton new];
    investBtn.backgroundColor = kColorMain;
    investBtn.layer.cornerRadius = 5;
    [investBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    investBtn.titleLabel.font = Font(35/2);
    [investBtn addTarget:self
                  action:@selector(investAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [invest addSubview:investBtn];
    
    
    [investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left .equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.bottom.equalTo(self.view).offset(-(45/2));
        make.height.mas_equalTo(105*kHeightScale);
    }];
    
    
    
    
    
}

#pragma mark 投资按钮
- (void)investAction:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1000" forKey:@"newbiewc"];
    //
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];//是否登录状态
    
    int panduan = [banduan intValue];
    if (panduan != 200 ) {
        /*
         *登录
         */
        
        denglu02ViewController *login = [[denglu02ViewController alloc]init];
        
        //disanfang.model = _model;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.35;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:login animated:NO completion:nil];
        
        
        
        
        
    }else{
        
        
        
        [DataService requestWithURL:@"/v2/chinapnrhandle/invest"
                             params:nil
                         httpMethod:@"get"
                    completionBlock:^(id result) {
                        
                        NSLog(@"新手体验标成功%@",result);
                        
                        
                        [self loadChinapnrhandleInvestData:result];
                        
                    }];
        
        
    }
    
    
    
    
}
#pragma mark -新手体验标投资请求
- (void)loadChinapnrhandleInvestData:(id)result{
    
    NSDictionary *responseDic = result;
    NSNumber *code = responseDic [@"code"];
    
    if ([code intValue]==200) {
        NSDictionary *dataDic = responseDic[@"data"];
        
        NSString *isOpen =[NSString stringWithFormat:@"%@",dataDic [@"is_open"]];
        //  NSString isOpen =  ];
        if ([isOpen intValue] ==0 ) {
            
            /*
             *没有开通汇付
             */
            
            disafangViewController *disanfang= [[disafangViewController alloc]init];
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"pageCurl";
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:animation forKey:nil];
            
            [self presentViewController:disanfang animated:NO completion:nil];
            
            
            
        }else{
            
            NSString *money = dataDic[@"money"];
            if ([isOpen intValue] ==1 &&[money intValue]>=1 ) {
                NSString *url = dataDic[@"href"];
                
              NewUSerBieInvestController *newBieInvest = [[NewUSerBieInvestController alloc]init];
                newBieInvest.investUrl =url;

                [self.navigationController pushViewController:newBieInvest animated:YES];
                
//                
//                CATransition *animation = [CATransition animation];
//                animation.duration = 0.5;
//                animation.timingFunction = UIViewAnimationCurveEaseInOut;
//                animation.type = @"pageCurl";
//                animation.type = kCATransitionPush;
//                animation.subtype = kCATransitionFromRight;
//                [self.view.window.layer addAnimation:animation forKey:nil];
//                [self presentViewController:newBieInvest animated:NO completion:nil];
                
                
            }else{
                
                /*
                 *没有开通汇付天下 或钱数小于100
                 */
                
                
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
            
        }
        
    }else if([code intValue]==2371){
        
     
        [self showPromptWindow];
        
        _contentLabel.text = @"抱歉，此项目为新注册用户专享，去看看其他项目吧。";
        
        
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: _contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ _contentLabel.text length])];
        [ _contentLabel setAttributedText:attributedString];
        [_contentLabel sizeToFit];
        

        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_rechargeView.mas_centerX);
            make.top.equalTo(_contentLabel.mas_bottom).offset(0.028*kScreenHeight);
            make.width.mas_equalTo(0.230*kScreenWidth);
            make.height.mas_equalTo(0.052*kScreenHeight);
            
        }];
        
    }else if([code intValue] ==2373){
    
    
        
        [self showPromptWindow];
        
        _contentLabel.text = @"抱歉，您的新手标体验券已过期，去看看其他项目吧。";
        
        
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: _contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ _contentLabel.text length])];
        [ _contentLabel setAttributedText:attributedString];
        [_contentLabel sizeToFit];
        
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_rechargeView.mas_centerX);
            make.top.equalTo(_contentLabel.mas_bottom).offset(0.028*kScreenHeight);
            make.width.mas_equalTo(0.230*kScreenWidth);
            make.height.mas_equalTo(0.052*kScreenHeight);
            
        }];

    
    
    }else if([code intValue] ==2372){
    
    
        
        
        HasInvestedBieController *hasUsed = [[HasInvestedBieController alloc]init];
        hasUsed.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:hasUsed animated:YES];
        
    
    
    }else{
    
    
    
        
        /*
         *code 值不等于200
         */
        NSString*data = responseDic[@"data"];
        
        NSLog(@"新手标立即体验：%@",data);
        
        [self showPromptWindow];
        _contentLabel.text = data;
    }
    
    
    
    
}





- (void)backBtnAction:(UIButton*)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
 
    
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
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
//    //
    
}
#pragma mark -提示充值弹窗

//创建遮盖视图
- (void)createMaskView{
    
    
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
    _rechargeView.layer.cornerRadius = 3;
    //    _rechargeView.frame = CGRectMake(0.163*kScreenWidth, 0.425*kScreenHeight, kScreenWidth - 2*0.163*kScreenWidth, 0.149*kScreenHeight);
    _rechargeView.frame = CGRectMake(40, 0.5*__kScreenHeight__-60, __kScreenWidth__-80,128);
    
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_rechargeView];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    //_contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:30/2];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.text = @"抱歉，此项目为新注册用户专享，去看看其他项目吧。";
    [_rechargeView addSubview:_contentLabel];
    
    _contentLabel.frame = CGRectMake(20, 0.032*kScreenHeight,_rechargeView.width-40, 0.018*kScreenHeight) ;
    //确认
    
 
    
    
    
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    _sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    _sureButton.layer.cornerRadius = 3;
    [_sureButton setBackgroundColor:sureColor];
    [_sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_rechargeView addSubview:_sureButton];
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [_lastWindow insertSubview:_maskView belowSubview:_rechargeView];
    
}

#pragma mark -充值窗口按钮点击事件

/*
 *确认按钮
 */

- (void)sureAction:(UIButton *)sender{
    
    
    
    [self hidePromptWindow];
    
}

#pragma mark -遮挡视图点击事件
- (void)maskViewAction:(UIControl *)sender{
    
    
    [self hidePromptWindow];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 提示充值信息
/*
 *显示提示框
 */
- (void)showPromptWindow{
    [UIView animateWithDuration:.35 animations:^{
        
        _rechargeView.hidden = NO;
        _maskView.hidden = NO;
    }];
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
