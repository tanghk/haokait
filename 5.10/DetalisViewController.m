//
//  DetalisViewController.m
//  555
//
//  Created by 李浩宇 on 16/3/8.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "DetalisViewController.h"
#import "DZ_ScaleCircle.h"
#import "Masonry.h"
#import "DataService.h"
#import "UICommons.h"
@interface DetalisViewController ()

{
    
    
    UILabel *_titleLabel ;

    NSString * _total_assets;
    
    NSString *  _available;

    NSString * _frozen;
    NSString *_not_pay_interest;
    NSString * _not_pay_money;
    
    NSString *  _available3;
    NSString * _frozen3;
    NSString *_not_pay_interest3;
    NSString * _not_pay_money3;
    UIScrollView *Detalisview;
}
@end

@implementation DetalisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requsetAssetsData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 0.5)];
    xian.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:xian];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"资产详情";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
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


    
    
    
    
    
    Detalisview = [[UIScrollView alloc]init];
    [self.view addSubview:Detalisview];
    [Detalisview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64.5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];
    Detalisview.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    Detalisview.showsVerticalScrollIndicator = FALSE;
    if(__kScreenHeight__ == 568)
    {
    Detalisview.contentSize =CGSizeMake(0, 1080);
    }
    else if(__kScreenHeight__ == 667)
    {
         Detalisview.contentSize =CGSizeMake(0, 1200);
    }else
    {
    Detalisview.contentSize =CGSizeMake(0, 1300);
    }
    
    
    UIImageView *detalismain = [[UIImageView alloc]init];
    [Detalisview addSubview:detalismain];
    [detalismain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        if (__kScreenHeight__ == 568) {
            make.height.mas_equalTo(900);
        }

    }];
    
    if(__kScreenHeight__ == 736)
    {
        [detalismain setImage:[UIImage imageNamed:@"detalis_mainda"]];
    }else{
        [detalismain setImage:[UIImage imageNamed:@"detalis_main"]];
    }
    

    UIView *ligthview = [[UIView alloc]init];
    [Detalisview addSubview:ligthview];
    [ligthview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(detalismain.mas_bottom);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(300);
    }];
    ligthview.backgroundColor =[UIColor whiteColor];
    
    
    
    
    
 
 
}
- (void)requsetAssetsData{
    
    
    [DataService requestWithURL:@"/user/assets"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    
                    [self loadAssetsDataDidFinish:result];
                    
                    
                }];
    
    
    
}

- (void)loadAssetsDataDidFinish:(id)result{
    
    NSDictionary *assetsDic =result;
    
    NSLog(@"我的资产数据%@",assetsDic);
    
    NSDictionary *dataDic = [assetsDic objectForKey:@"data"];

    
    _total_assets = [dataDic objectForKey:@"total_assets"];// 账户总资产
    UILabel *allmonay  = [[UILabel alloc]init];
    [Detalisview addSubview:allmonay];
    [allmonay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.21*__kScreenHeight__);
        make.left.mas_equalTo(0.364*__kScreenWidth__);
        make.width.mas_equalTo(0.267*__kScreenWidth__);
        make.height.mas_equalTo(0.03*__kScreenHeight__);
    }];
    
    allmonay.text = _total_assets;
    allmonay.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
    if (__kScreenHeight__ == 568) {
           allmonay.font = [UIFont systemFontOfSize:14];
    }else if(__kScreenHeight__ == 667)
    {
           allmonay.font = [UIFont systemFontOfSize:17];
    }else{
           allmonay.font = [UIFont systemFontOfSize:19];
    }
 
    allmonay.textAlignment = UITextAlignmentCenter;
    
    //现有总资产
    UILabel *all = [[UILabel alloc]init];
    [Detalisview addSubview:all];
    [all mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.37*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(1.33*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            make.top.mas_equalTo(1.331*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    
    all.text =[NSString stringWithFormat:@"   %@",_total_assets] ;
    all.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    all.font = [UIFont systemFontOfSize:16];


    
    
    _not_pay_money= [dataDic objectForKey:@"not_pay_money"];;// 待收本金
    //代收本金
    UILabel *benmonay = [[UILabel alloc]init];
    [Detalisview addSubview:benmonay];
    [benmonay mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.44*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if(__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(0.43*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            make.top.mas_equalTo(0.431*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    benmonay.text = [NSString stringWithFormat:@"%@",_not_pay_money];
    benmonay.font = [UIFont systemFontOfSize:16];
//    benmonay.textAlignment = UITextAlignmentCenter;
    
    
    
    
    
  
    _not_pay_interest = [dataDic objectForKey:@"not_pay_interest"]; // 待收利息
    //代收收益
    UILabel *shouyimonay = [[UILabel alloc]init];
    [Detalisview addSubview:shouyimonay];
    [shouyimonay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.44*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.34*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }else if (__kScreenHeight__ == 667)
        { make.top.mas_equalTo(0.43*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.34*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

            
        }else{ make.top.mas_equalTo(0.431*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.34*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

            
        }
           }];
    shouyimonay.text =_not_pay_interest;
    shouyimonay.font = [UIFont systemFontOfSize:16 ];

//    shouyimonay.textAlignment = UITextAlignmentCenter;

    
    

     _available = [dataDic objectForKey:@"available"];// 可用余额

    //可用余额
    UILabel *keyongmonay = [[UILabel alloc]init];
    [Detalisview addSubview:keyongmonay];
    [keyongmonay mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.57*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        { make.top.mas_equalTo(0.555*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }else{
            make.top.mas_equalTo(0.556*__kScreenHeight__);
            make.left.mas_equalTo(0.66*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
       
    }];
    keyongmonay.text = _available;
    keyongmonay.font = [UIFont systemFontOfSize:16];

//    keyongmonay.textAlignment = UITextAlignmentCenter;
    
    
    
   _frozen = [dataDic objectForKey:@"frozen"];// 冻结余额
    //冻结金额
    UILabel *dongmonay = [[UILabel alloc]init];
    [Detalisview addSubview:dongmonay];
    [dongmonay mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.57*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(0.555*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }else{
            make.top.mas_equalTo(0.556*__kScreenHeight__);
            make.left.mas_equalTo(0.141*__kScreenWidth__);
            make.width.mas_equalTo(0.35*__kScreenWidth__);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }
        
    }];
    dongmonay.text = _frozen;
    dongmonay.font = [UIFont systemFontOfSize:16];

//    dongmonay.textAlignment = UITextAlignmentCenter;

    
    
    
   NSString * _total_investment_money = [dataDic objectForKey:@"total_investment_money"]; // 总投资额
    //累计总投资
    UILabel *daishoumanoy = [[UILabel alloc]init];
    
    [Detalisview addSubview:daishoumanoy];
    
    [daishoumanoy mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(__kScreenHeight__*0.78);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.view.frame.size.width*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(__kScreenHeight__*0.76);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.view.frame.size.width*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            make.top.mas_equalTo(__kScreenHeight__*0.761);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.view.frame.size.width*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    daishoumanoy.text = _total_investment_money;
    daishoumanoy.font = [UIFont systemFontOfSize:16];
    daishoumanoy.textAlignment = UITextAlignmentCenter;
    

//    
//    
   NSString * _total_in_account_money = [dataDic objectForKey:@"total_in_account_money"];// 总充值5
    //累计充值
    UILabel *dongjie = [[UILabel alloc]init];
    [Detalisview addSubview:dongjie];
    [dongjie mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.91*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(0.885*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            make.top.mas_equalTo(0.886*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    dongjie.textAlignment = UITextAlignmentCenter;
    dongjie.text = _total_in_account_money;
    dongjie.font = [UIFont systemFontOfSize:16];



    //累计充值
    UILabel *all3 = [[UILabel alloc]init];
    [Detalisview addSubview:all3];
    [all3 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.49*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }else if(__kScreenHeight__ == 667)
        {make.top.mas_equalTo(1.45*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
            
        }else{
            make.top.mas_equalTo(1.451*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }
    }];
    
    all3.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"- %@",_total_in_account_money]];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1] range:NSMakeRange(0,1)];

    
    
    
    all3.attributedText = str2;
   
    all3.font = [UIFont systemFontOfSize:16];
    
    
    

    NSString *_total_out_account_money = [dataDic objectForKey:@"netsave_draw_money"];// 累计提现
    //累计提现
    UILabel *yuchude = [[UILabel alloc]init];
    [Detalisview addSubview:yuchude];
    [yuchude mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.91*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(0.885*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            
            make.top.mas_equalTo(0.886*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    yuchude.textAlignment = UITextAlignmentCenter;
    yuchude.text = _total_out_account_money;
    yuchude.font = [UIFont systemFontOfSize:16];
 

    //累计提现
    UILabel *all2 = [[UILabel alloc]init];
    [Detalisview addSubview:all2];
    [all2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.43*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {make.top.mas_equalTo(1.39*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }else{
            make.top.mas_equalTo(1.391*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    
    all2.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+ %@",_total_out_account_money]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1] range:NSMakeRange(0,1)];
    

    
    all2.attributedText = str;

    
    all2.font = [UIFont systemFontOfSize:16];

    
 
    
    NSString *_total_out_account_jiang = [dataDic objectForKey:@"reward_count"];// 累计奖励
  
    //累计获得奖励
    UILabel *aar = [[UILabel alloc]init];
    [Detalisview addSubview:aar];
    [aar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.04*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(1.013*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else{
            make.top.mas_equalTo(1.014*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    aar.textAlignment = UITextAlignmentCenter;
    aar.text =_total_out_account_jiang;
    aar.font = [UIFont systemFontOfSize:16];

    
    
    
    NSString *_total_out_account_feesum = [dataDic objectForKey:@"total_fee"];//手续费
    UILabel *aar34 = [[UILabel alloc]init];
    [Detalisview addSubview:aar34];
    [aar34 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.17*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }else if (__kScreenHeight__ == 667)
        {make.top.mas_equalTo(1.138*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }else{
            make.top.mas_equalTo(1.139*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
        }
        
    }];
    aar34.textAlignment = UITextAlignmentCenter;
    aar34.text =_total_out_account_feesum;
    aar34.font = [UIFont systemFontOfSize:16];
    

    
    
    
    
    
    
    NSString *_estimate_total_interest = [dataDic objectForKey:@"estimate_total_interest"]; // 累积收益
    //累计总收益
    UILabel *daishoushouyi = [[UILabel alloc]init];
    [Detalisview addSubview:daishoushouyi];
    [daishoushouyi mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.78*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }else if (__kScreenHeight__ == 667)
        {
            make.top.mas_equalTo(0.76*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }else{
            make.top.mas_equalTo(0.761*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);

        }
           }];
    daishoushouyi.textAlignment = UITextAlignmentCenter;
    daishoushouyi.text = _estimate_total_interest;
    daishoushouyi.font = [UIFont systemFontOfSize:16];
  
//   NSString *_not_pay_money1= [dataDic objectForKey:@"have_pay_principal"];// 已收本金
//    //已收本金
//    UILabel *daishoubennin = [[UILabel alloc]init];
//    [Detalisview addSubview:daishoubennin];
//    [daishoubennin mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (__kScreenHeight__ == 568) {
//            make.top.mas_equalTo(1.04*__kScreenHeight__);
//            make.left.mas_equalTo(0);
//            make.width.mas_equalTo(__kScreenWidth__*0.5);
//            make.height.mas_equalTo(0.036*__kScreenHeight__);
//            
//        }else if(__kScreenHeight__ == 667)
//            
//        {  make.top.mas_equalTo(1.013*__kScreenHeight__);
//            make.left.mas_equalTo(0);
//            make.width.mas_equalTo(__kScreenWidth__*0.5);
//            make.height.mas_equalTo(0.036*__kScreenHeight__);
//            
//            
//        }else
//        {  make.top.mas_equalTo(1.014*__kScreenHeight__);
//            make.left.mas_equalTo(0);
//            make.width.mas_equalTo(__kScreenWidth__*0.5);
//            make.height.mas_equalTo(0.036*__kScreenHeight__);
//            
//            
//        }
//    }];
//    daishoubennin.textAlignment = UITextAlignmentCenter;
//    daishoubennin.text = _not_pay_money1;
//    daishoubennin.font = [UIFont systemFontOfSize:16];

   
    NSString *_have_pay_interest = [dataDic objectForKey:@"have_pay_interest"];
    //已收收益
    UILabel *daishoushss = [[UILabel alloc]init];
    [Detalisview addSubview:daishoushss];
    [daishoushss mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(1.04*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }else if(__kScreenHeight__ == 667)
            
        {  make.top.mas_equalTo(1.013*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
            
        }else
        {  make.top.mas_equalTo(1.014*__kScreenHeight__);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
            
        }
        
    }];
    daishoushss.textAlignment = UITextAlignmentCenter;
    daishoushss.text = _have_pay_interest;
    daishoushss.font = [UIFont systemFontOfSize:16];
    

    NSString *earn_zong = [dataDic objectForKey:@"earn"];// 综合

    //综合
    UILabel *all31 = [[UILabel alloc]init];
    [Detalisview addSubview:all31];
    [all31 mas_makeConstraints:^(MASConstraintMaker *make) {
        if(__kScreenHeight__ == 568)
        { make.top.mas_equalTo(1.55*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
            
        }else if (__kScreenHeight__ == 667)
        { make.top.mas_equalTo(1.51*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
            
        }else{
            make.top.mas_equalTo(1.511*__kScreenHeight__);
            make.left.mas_equalTo(__kScreenWidth__*0.5);
            make.width.mas_equalTo(__kScreenWidth__*0.5);
            make.height.mas_equalTo(0.036*__kScreenHeight__);
            
        }
    }];
    
    all31.text = [NSString stringWithFormat:@"= %@",earn_zong];
    all31.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
    all31.font = [UIFont systemFontOfSize:16];
    
     _available3 = [dataDic objectForKey:@"available_percent"];
     _frozen3 = [dataDic objectForKey:@"frozen_percent"];
     _not_pay_money3 = [dataDic objectForKey:@"not_pay_money_percent"];
     _not_pay_interest3 = [dataDic objectForKey:@"not_pay_interest_percent"];
    
    

    if (__kScreenHeight__ == 568) {
        [self setCircle568];
    }else if(__kScreenHeight__ == 667)
    {
        [self setCircle667];
    }else
    {
        [self setCircle];
    }

}

- (void)setCircle{
    
    DZ_ScaleCircle *circle = [[DZ_ScaleCircle alloc] initWithFrame:CGRectMake(30, -30,self.view.frame.size.width-60 , self.view.frame.size.width-60)];
    
    //    circle.backgroundColor = [UIColor grayColor];
    //    circle.alpha = 0.2;
    
    //  颜色
    circle.firstColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
    circle.secondColor = [UIColor colorWithRed:255/255.0 green:231/255.0 blue:148/255.0 alpha:1];
    circle.thirdColor = [UIColor colorWithRed:162/255.0 green:205/255.0 blue:46/255.0 alpha:1];
    circle.fourthColor = [UIColor colorWithRed:31/255.0 green:155/255.0 blue:207/255.0 alpha:1];
    
    
    
    if ([_total_assets floatValue] == 0.00 ) {
        
        circle.firstScale = 0;
        circle.secondScale = 1;
        circle.thirdScale = 0;
        circle.fourthScale = 0;
        
    }else{
        
        
        //  比例
        float a = [_available3 floatValue];
        float b = [_frozen3 floatValue];
        float c = [_not_pay_interest3 floatValue];
        float d = [_not_pay_money3 floatValue];
        circle.firstScale = d;
        circle.secondScale = a;
        circle.thirdScale = b;
        circle.fourthScale = c;
        
    }
    
    
    
//    //  比例
//    float a = [_available3 floatValue];
//    float b = [_frozen3 floatValue];
//    float c = [_not_pay_interest3 floatValue];
//    float d = [_not_pay_money3 floatValue];// 待收本金
//    circle.firstScale = d;
//    circle.secondScale = a;
//    circle.thirdScale = b;
//    circle.fourthScale = c;
    //  颜色宽度
    circle.lineWith = self.view.frame.size.width*0.025;
    //  未填充颜色
    circle.unfillColor = [UIColor whiteColor ];
    //  速度
    circle.animation_time = 1.0;
    //  中间的字
    circle.centerLable.text = @"";
    [Detalisview addSubview:circle];
}

-(void)setCircle568{
    
    DZ_ScaleCircle *circle = [[DZ_ScaleCircle alloc] initWithFrame:CGRectMake(30, -12,self.view.frame.size.width-60 , self.view.frame.size.width-60)];
    
    //    circle.backgroundColor = [UIColor grayColor];
    //    circle.alpha = 0.2;
    
    //  颜色
    circle.firstColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
    circle.secondColor = [UIColor colorWithRed:255/255.0 green:231/255.0 blue:148/255.0 alpha:1];
    circle.thirdColor = [UIColor colorWithRed:162/255.0 green:205/255.0 blue:46/255.0 alpha:1];
    circle.fourthColor = [UIColor colorWithRed:31/255.0 green:155/255.0 blue:207/255.0 alpha:1];
    
    
    
    if ([_total_assets floatValue] == 0.00 ) {
        
        circle.firstScale = 0;
        circle.secondScale = 1;
        circle.thirdScale = 0;
        circle.fourthScale = 0;
        
    }else{
        
        
        //  比例
        float a = [_available3 floatValue];
        float b = [_frozen3 floatValue];
        float c = [_not_pay_interest3 floatValue];
        float d = [_not_pay_money3 floatValue];
        circle.firstScale = d;
        circle.secondScale = a;
        circle.thirdScale = b;
        circle.fourthScale = c;
        
    }
    

    
    
//    //  比例
//    float a = [_available3 floatValue];
//    float b = [_frozen3 floatValue];
//    float c = [_not_pay_interest3 floatValue];
//    float d = [_not_pay_money3 floatValue];
//    circle.firstScale = d;
//    circle.secondScale = a;
//    circle.thirdScale = b;
//    circle.fourthScale = c;
    //  颜色宽度
    circle.lineWith = self.view.frame.size.width*0.025;
    //  未填充颜色
    circle.unfillColor = [UIColor whiteColor ];
    //  速度
    circle.animation_time = 1.0;
    //  中间的字
    circle.centerLable.text = @"";
    [Detalisview addSubview:circle];
    
}

-(void)setCircle667{
    
    DZ_ScaleCircle *circle = [[DZ_ScaleCircle alloc] initWithFrame:CGRectMake(30, -25,self.view.frame.size.width-60 , self.view.frame.size.width-60)];
    
    //    circle.backgroundColor = [UIColor grayColor];
    //    circle.alpha = 0.2;
    
    //  颜色
    circle.firstColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];//橘色d
    circle.secondColor = [UIColor colorWithRed:255/255.0 green:231/255.0 blue:148/255.0 alpha:1];//黄色a
    circle.thirdColor = [UIColor colorWithRed:162/255.0 green:205/255.0 blue:46/255.0 alpha:1];//绿色b
    circle.fourthColor = [UIColor colorWithRed:31/255.0 green:155/255.0 blue:207/255.0 alpha:1];//蓝色c
   
    
    if ([_total_assets floatValue] == 0.00 ) {
        
        circle.firstScale = 0;
        circle.secondScale = 1;
        circle.thirdScale = 0;
        circle.fourthScale = 0;
        
    }else{
    
    
        //  比例
        float a = [_available3 floatValue];
        float b = [_frozen3 floatValue];
        float c = [_not_pay_interest3 floatValue];
        float d = [_not_pay_money3 floatValue];
        circle.firstScale = d;
        circle.secondScale = a;
        circle.thirdScale = b;
        circle.fourthScale = c;
    
    }
      //  颜色宽度
    circle.lineWith = self.view.frame.size.width*0.025;
    //  未填充颜色
    circle.unfillColor = [UIColor whiteColor ];
    //  速度
    circle.animation_time = 1.0;
    //  中间的字
    circle.centerLable.text = @"";
    [Detalisview addSubview:circle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)aqlb:(id)sender
{
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
