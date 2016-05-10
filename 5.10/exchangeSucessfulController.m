//
//  exchangeSucessfulController.m
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "exchangeSucessfulController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "RedEnvelopesController.h"
#import "UIViewExt.h"
@interface exchangeSucessfulController ()

@end


@implementation exchangeSucessfulController{

    UIImageView *_exchangeSucessfulView;
       UIImageView *_bgView;//获取红包的背景
    UILabel *_nameLabel; //描述label
    UILabel *_parLabel;//金额
    UILabel *_unitsLabel;//单位
    UILabel *_increaseLabel;//加息文字
    UILabel *_expired_timeLabel;
    
    UILabel *_leftPromptLabel;
    UILabel *_rightPromptLabel;
    UILabel *_promptLabel;//提示label

   
    UILabel *_increaseText;//加息文字
    
     NSString *_leftPromptstr;
     NSString *_Promptstr;
     NSString *_rightPromptstr;
    




}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self creatWithNavGation];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
   // [self custumExchangeSuccessfulView];

}
#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = kColorWhite;
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = RGB(245, 245, 245, 1);
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"兑换红包";
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
- (instancetype)init{
    self = [super init];
    if ( self) {
        [self custumExchangeSuccessfulView];
        //_promptLabel.text =  @"10000";
        
    _leftPromptstr = @"您获得了";
    }
    return self;
    
}
- (void)setCodeDic:(NSDictionary *)codeDic{
    _codeDic = codeDic;
    _nameLabel.text = [NSString stringWithFormat:@"%@",[_codeDic objectForKey:@"description"]];
    //_promptLabel.text = [NSString stringWithFormat:@"%@",[_codeDic objectForKey:@"money"]];
    _parLabel.text =[NSString stringWithFormat:@"%@",[_codeDic objectForKey:@"money"]]; //@"100000";
    
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[[_codeDic objectForKey:@"expired_time"] floatValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *regStr = [df stringFromDate:dt];
    

    _expired_timeLabel.text = [NSString stringWithFormat:@"有限期至%@",regStr];//@"有限期至2016-12-14  10:20";
   // _bgView.image = [UIImage imageNamed:@"redPacketRedBg1"];
    
    
    
    
    
    _leftPromptLabel.text =  @"您获得了";
    _Promptstr =[NSString stringWithFormat:@"%@",[_codeDic objectForKey:@"money"]];
    _type = [NSString stringWithFormat:@"%@",[_codeDic objectForKey:@"type"]];
    
    if ([_type intValue] ==1) {
        _rightPromptstr = @"元体验金";
         _unitsLabel.text = @"元";
        _bgView.image = [UIImage imageNamed:@"redPacketRedBgex"];

        

    }else if ([_type intValue] ==2){
        _rightPromptstr = @"元本金券";
        _unitsLabel.text = @"元";
       _bgView.image = [UIImage imageNamed:@"redPacketRedBg2"];

    
    }else if ([_type intValue] ==3){
         _unitsLabel.text = @"%";
        _rightPromptstr = @"%加息券";
        _increaseText.text = @"加息";
       
        _bgView.image = [UIImage imageNamed:@"redPacketRedBg3"];

    }
    
    NSString *prompt = [NSString stringWithFormat:@"%@%@%@",_leftPromptstr,_Promptstr,_rightPromptstr];
    
    NSMutableAttributedString *mulFullStr = [[NSMutableAttributedString alloc] initWithString:prompt];
   
    NSRange range = [[mulFullStr string] rangeOfString:_Promptstr];
    
    [mulFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:range];
    
    _promptLabel.attributedText = mulFullStr;
    
    
   }



#pragma mark - 兑换成功
- (void)custumExchangeSuccessfulView{
    
    _exchangeSucessfulView = [[UIImageView alloc]init];
    _exchangeSucessfulView.userInteractionEnabled = YES;
    _exchangeSucessfulView.image = [UIImage imageNamed:@"convertRedPacketSucceed"];

    [self.view addSubview:_exchangeSucessfulView];
    
    [_exchangeSucessfulView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64.5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //    [_leftPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo (_exchangeSucessfulView.mas_top).offset(0.224*kScreenHeight);
//        make.height.mas_equalTo(0.02*kScreenHeight);
//     make.left.equalTo(_exchangeSucessfulView.mas_left);
//     // make.right.equalTo(_promptLabel.mas_left);
//      
//        
//    }];
//
    

    /*
     *中间提示信息
     */
    _promptLabel = [[UILabel alloc]init];
   
   
    _promptLabel.textAlignment = NSTextAlignmentCenter;
   // _promptLabel.layer.borderWidth = 1;
    [_exchangeSucessfulView addSubview:_promptLabel];
    
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (_exchangeSucessfulView.mas_top).offset(0.224*kScreenHeight);
        make.height.mas_equalTo(0.02*kScreenHeight);
     // make.left.equalTo(_leftPromptLabel.mas_right);
      // make.right.equalTo(_rightPromptLabel.mas_left);
     make.centerX.equalTo(_exchangeSucessfulView.mas_centerX);
          }];
    


    
    

    /*
     *背景图
     */
    _bgView = [[UIImageView alloc]init];
//    _bgView.image = [UIImage imageNamed:@"redPacketRedBg1"];
    [_exchangeSucessfulView addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0.056*kScreenWidth);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.height.mas_equalTo(0.188*kScreenHeight);
        make.top.equalTo(_promptLabel.mas_bottom).offset(0.035*kScreenHeight);
    }];
    
    
    /*
     *name
     */
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = Font(13);
    _nameLabel.textColor = RGB(255, 241, 176, 1);
    [_bgView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(77);
        make.top.equalTo(_bgView.mas_top).offset(18);
        make.height.mas_equalTo(13);
          make.right.equalTo(_bgView.mas_right).offset(-0.015*kScreenWidth);
    }];
    
    
    
    /*
     *金额
     */
    
    _parLabel = [[UILabel alloc]init];
     //_parLabel.text = @"100000";
    _parLabel.font = [UIFont boldSystemFontOfSize:52/2];
    _parLabel.textAlignment = NSTextAlignmentCenter;
    _parLabel.textColor = kColorWhite;
    [_bgView addSubview:_parLabel];
    
    [_parLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.centerY.equalTo (_bgView.mas_centerY);
        make.height.mas_equalTo(52/2);
    }];
    
    
    /*
     *单位(元)
     */
    
    _unitsLabel = [[UILabel alloc]init];
    
    _unitsLabel.font = [UIFont systemFontOfSize:34/2];
    _unitsLabel.textColor = kColorWhite;
//    _unitsLabel.text = @"元";
    
    [_bgView addSubview:_unitsLabel];
    
    [_unitsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_parLabel.mas_bottom).offset(-2);
        make.left.equalTo(_parLabel.mas_right).offset(8);
        make.height.mas_equalTo(17);
        
    }];
    
    /*
     *加息提示
     */
    
    
    _increaseText = [[UILabel alloc]init];
    
    _increaseText.font = [UIFont systemFontOfSize:34/2];
    _increaseText.textColor = kColorWhite;
    
    [_bgView addSubview:_increaseText];
    
    
    [_increaseText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_parLabel.mas_bottom).offset(-3);
        make.right.equalTo(_parLabel.mas_left).offset(-2);
        make.height.mas_equalTo(17);
        
    }];
    
    

    /*
     *优惠卷过期时间
     */
    _expired_timeLabel =[[UILabel alloc]init];
    _expired_timeLabel.textColor = kColorWhite;
//    _expired_timeLabel.text = @"有限期至2016-12-14  10:20";
    _expired_timeLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_bgView addSubview:_expired_timeLabel];
    
    
    
    [_expired_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-20);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-18);
        make.height.mas_equalTo(12);
    }];
    
    
    
    /*
     *查看红包
     */
    UIButton *checkPackgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkPackgeButton addTarget:self
                          action:@selector(checkAction)
                forControlEvents:UIControlEventTouchUpInside];
    //checkPackgeButton.layer.borderWidth = 1;
    [checkPackgeButton setTitle:@"[查看红包]" forState:UIControlStateNormal];
    [checkPackgeButton setTitleColor:kColorMain forState:UIControlStateNormal];
    checkPackgeButton.titleLabel.font = Font(15);
    
    [_exchangeSucessfulView addSubview:checkPackgeButton];
    
    [checkPackgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo (_exchangeSucessfulView.mas_centerX);
        make.top.equalTo(_bgView.mas_bottom).offset(0.064*kScreenHeight);
        make.height.mas_equalTo(0.03*kScreenHeight);
      //  make.width.mas_equalTo(0.181*kScreenWidth);
       
        
    }];
    
    
    UIButton *goInvest =[UIButton buttonWithType:UIButtonTypeCustom];
    [goInvest addTarget:self
                          action:@selector(goInvestAction)
                forControlEvents:UIControlEventTouchUpInside];
   // goInvest.layer.borderWidth = 1;
    goInvest.layer.cornerRadius = 3;
    goInvest.backgroundColor = kColorMain;
    [goInvest setTitle:@"马上使用" forState:UIControlStateNormal];
    //[goInvest setTitleColor:kColorMain forState:UIControlStateNormal];
    goInvest.titleLabel.font = Font(15);
    
    [_exchangeSucessfulView addSubview:goInvest];

    
    
    
    
    [goInvest mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo (_exchangeSucessfulView.mas_centerX);
        make.top.equalTo(checkPackgeButton.mas_bottom).offset(0.029*kScreenHeight);
        make.height.mas_equalTo(0.079*kScreenHeight);
        make.width.mas_equalTo(0.377*kScreenWidth);
        
        
    }];

    
}

#pragma mark - 查看红包点击事件
- (void)checkAction{
//    RedEnvelopesController *redPackageVC =[[RedEnvelopesController alloc]init];
//    
//    [self.navigationController  popToViewController:redPackageVC animated:YES];
//    
//    
//    for (UIViewController * tem in self.navigationController.viewControllers) {
//        
//        if ([tem isKindOfClass:[RedEnvelopesController class]]) {
//            
//          
//            [self.navigationController popToViewController:tem animated:YES];
//            
//        }
//        
//    }
//    
//    
    
     RedEnvelopesController *redPackageVC =[[RedEnvelopesController alloc]init];
   
    //
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:redPackageVC animated:NO completion:nil];

   
}


#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    
    
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
#pragma mark - 立马使用
- (void)goInvestAction{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
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
