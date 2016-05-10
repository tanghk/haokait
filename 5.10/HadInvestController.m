//
//  HadInvestController.m
//  555
//
//  Created by otouzi on 16/5/3.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "HadInvestController.h"
#import "Masonry.h"
#import "UICommons.h"
#import "AFNetworking.h"//网络请求
#import "JIAOYIViewController.h"
#import "DataService.h"
#import "TabbarViewController.h"
@interface HadInvestController ()
{
    UILabel *_start_timeLabel;
    UILabel *_end_timeLabel;
    UILabel *_total_incomeLab;
    
    
    
    UILabel *_deadline;
    UILabel *_peopleCount;
    
    NSString *_deadline_Value;
    NSString  *_count ;
    
    NSString *_total_income;//投资收益
    
    UILabel *_descriptionLab;
    
}

@end

@implementation HadInvestController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestHasInvestNewBie];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // _deadline_Value = @"1";
    //  _count = @"132";
    
    self.view.backgroundColor = kColorWhite;
    [self creatWithNavGation];
    
    [self custumHasInvestBieViews];
    
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
#pragma mark - 自定义视图
- (void)custumHasInvestBieViews{
    
    int padingLeft =0.056*kScreenWidth;
    int padingTop = 0.046*kScreenHeight;
    int padingRight =0.056*kScreenWidth;
    
    
    
    /*
     *投资
     */
    UIImageView *topView = [UIImageView new];
    topView.image = [UIImage imageNamed:@"newbie_circle"];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64.5);
        make.height.mas_equalTo(0.454*kScreenHeight);
        
    }];
    
    
    
    _deadline= [[UILabel alloc]init];
    _deadline.textAlignment =NSTextAlignmentCenter;
    _deadline.font = Font(26/2);
    //_deadline.text = @"投资期限：1天";
    [self.view addSubview:_deadline];
    
    [_deadline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(26*kHeightScale);
        make.top.equalTo(self.view.mas_top).offset(0.389*kScreenHeight+64.5);
        
        
        
    }];
    
    /*
     *参与人数
     */
    _peopleCount= [[UILabel alloc]init];
    _peopleCount.font = Font(26/2);
    //_peopleCount.text = @"已有153人参与";
    _peopleCount.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_peopleCount];
    
    [_peopleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(26*kHeightScale);
        make.top.equalTo(self.view.mas_top).offset(0.389*kScreenHeight+64.5);
        
        
        
    }];
    
    
    /*
     *左侧图片
     */
    UIImageView *leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"newbie_details"];
    [self.view addSubview: leftView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(padingLeft);
        make.top.equalTo(topView.mas_bottom).offset(0.048*kScreenHeight);
        make.height.mas_equalTo(0.220*kScreenHeight);
        make.width.mas_equalTo(0.245*kScreenWidth);
        ////
        //        make.height.mas_equalTo(486/3);
        //        make.width.mas_equalTo(304/3);
    }];
    
    
    /*
     *投资金额
     */
    UILabel *experienceCoupon = [UILabel new];
    experienceCoupon.textAlignment = NSTextAlignmentRight;
    experienceCoupon.font = Font(0.021*kScreenHeight);
    experienceCoupon.text = @"1.00元＋9999元体验金";
    [self.view addSubview:experienceCoupon];
    
    [experienceCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padingRight);
        make.top.equalTo(topView.mas_bottom).offset(0.042*kScreenHeight);
        make.height.mas_equalTo(0.021*kScreenHeight);
        make.width.mas_equalTo(489/3);
        
    }];
    
    /*
     *计息时间
     */
    _start_timeLabel = [UILabel new];
    _start_timeLabel.textAlignment = NSTextAlignmentRight;
    _start_timeLabel.font = Font(0.021*kScreenHeight);
    //_start_timeLabel.text = @"2016-02-17";
    [self.view addSubview:_start_timeLabel];
    
    [_start_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padingRight);
        make.top.equalTo(experienceCoupon.mas_bottom).offset(padingTop);
        // make.height.mas_equalTo(47/3);
        make.width.mas_equalTo(481/3);
        make.height.mas_equalTo(0.021*kScreenHeight);
        
        
    }];
    //
    //
    //
    /*
     *结束时间
     */
    _end_timeLabel = [UILabel new];
    _end_timeLabel.textAlignment = NSTextAlignmentRight;
    _end_timeLabel.font = Font(0.021*kScreenHeight);
    // _end_timeLabel.text = @"2016-02-18";
    [self.view addSubview:_end_timeLabel];
    
    [_end_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padingRight);
        make.top.equalTo(_start_timeLabel.mas_bottom).offset(0.048*kScreenHeight);
        //  make.height.mas_equalTo(47/3);
        //make.width.mas_equalTo(0.387*kScreenWidth);
        make.width.mas_equalTo(481/3);
        make.height.mas_equalTo(0.021*kScreenHeight);
        
    }];
    //
    //    /*
    //     *预计收益
    //     */
    _total_incomeLab = [UILabel new];
    _total_incomeLab = [UILabel new];
    _total_incomeLab.textAlignment = NSTextAlignmentRight;
    _total_incomeLab.font = Font(0.021*kScreenHeight);
    // _total_incomeLab.text = @"2.73元";
    [self.view addSubview:_total_incomeLab];
    
    [_total_incomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padingRight);
        make.top.equalTo(_end_timeLabel.mas_bottom).offset(0.048*kScreenHeight);
        //   make.height.mas_equalTo(47/3);
        // make.width.mas_equalTo(0.387*kScreenWidth);
        make.width.mas_equalTo(481/3);
        make.height.mas_equalTo(0.021*kScreenHeight);
    }];
    //
    
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =kColorNaviLine ;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_bottom).offset(0.048*kScreenHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    
    
    
    
    
    //_total_income = @"3.73";
    _descriptionLab= [[UILabel alloc]init];
    _descriptionLab.textAlignment =NSTextAlignmentCenter;
    //descriptionLab.layer.borderWidth = 1;
    _descriptionLab.font = Font(44/3);
    //_deadline.text = @"投资期限：1天";
    [self.view addSubview:_descriptionLab];
    
    [_descriptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(lineGray.mas_bottom).offset(0.026*kScreenHeight);
        make.height.mas_equalTo(44/3);
        make.width.mas_equalTo(870/3);
        
        
        
    }];
    
    
    
    //
    //
    //
    //    /*
    //     *跳转账户余额
    //     */
    //    UIButton *balanceBtn = [UIButton new];
    //    balanceBtn.layer.borderWidth = 1;
    //    [balanceBtn addTarget:self
    //                   action:@selector(balanceAction:)
    //         forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.view addSubview:balanceBtn];
    //
    //    [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(descriptionLab.mas_right);
    //        make.top.equalTo(descriptionLab.mas_top).offset(-5);
    //        make.height.mas_offset(10+44/3);
    //        make.width.mas_equalTo(68);
    //
    //
    //
    //    }];
    //
    
    
    
    
    
}

#pragma mark - 已投资新手标
- (void)requestHasInvestNewBie{
    
    
    
    [DataService requestWithURL:@"/v2/chinapnrhandle/doneinvest"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    
                    
                    [  self loadHasInvestNewBieData :result ] ;
                }];
    
    
}
#pragma mark - 加载数据
- (void)loadHasInvestNewBieData:(id)result{
    
    NSString *const Deadline = @"投资期限:";
    NSString *const Units = @"天";
    
    NSString *const Have = @"已有";
    
    NSString *const Join = @"人参与";
    
    
    NSString *const descriptionLeft = @"本金＋收益共";
    NSString *const descriptionMiddle = @"元 将自动转入您的";
    NSString *const balance = @"账户";//账户余额
    
    
    NSLog(@"%@",result);
    
    NSDictionary *responseDic = result;
    
    NSNumber *code =responseDic[@"code"];
    
    
    if ([code intValue]==200) {
        NSDictionary *dataDic = responseDic[@"data"];
        
        
        
        
        
        _deadline_Value =[NSString stringWithFormat:@"%@", dataDic[@"days"]] ;
        _count  = dataDic[@"join_people_num"];
        
        _total_incomeLab.text = [NSString stringWithFormat:@"%@元",dataDic[@"estimate_total_interest"]];
        
        
        NSDate * start_timedt = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"release_start_time"] floatValue]];
        NSDateFormatter * start_timedf = [[NSDateFormatter alloc] init];
        [start_timedf setDateFormat:@"yyyy-MM-dd"];
        NSString *start_time = [start_timedf stringFromDate:start_timedt];
        
        
        _start_timeLabel.text = start_time;
        
        
        
        NSDate * end_timedt = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"release_end_time"] floatValue]];
        NSDateFormatter * end_timedf = [[NSDateFormatter alloc] init];
        [end_timedf setDateFormat:@"yyyy-MM-dd"];
        NSString *end_time = [end_timedf stringFromDate:end_timedt];
        
        _end_timeLabel.text =end_time;
        
        
        
        
        
        
        
        /*
         *投资收益
         */
        _total_income = [NSString stringWithFormat:@"%.2f",1+[dataDic[@"estimate_total_interest"]floatValue]];
        
        
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
        
        
        
        
        
        NSString *description = [NSString stringWithFormat:@"%@%@%@%@",descriptionLeft,_total_income,descriptionMiddle,balance];
        NSMutableAttributedString *descriptionFullStr = [[NSMutableAttributedString alloc] initWithString:description];
        NSRange descriptionRange = [[descriptionFullStr string] rangeOfString:_total_income];
        NSRange descriptionRange1 = [[descriptionFullStr string] rangeOfString:balance];
        [descriptionFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:descriptionRange];
        [descriptionFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:descriptionRange1];
        
        _descriptionLab.attributedText = descriptionFullStr;
        
        
    }
    
    
    
}

- (void)balanceAction:(UIButton *)sender{
    NSLog(@"跳转交易记录");
    
    JIAOYIViewController *balance = [[JIAOYIViewController alloc]init];
    //
    //    [self.navigationController pushViewController:balance animated:YES];
    //
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:balance animated:NO completion:nil];
    
    
    
    
}

#pragma mark 返回按钮
- (void)backBtnAction:(UIButton *)sender{
    //[self.navigationController popViewControllerAnimated:YES];
    
    
    TabbarViewController*tabbarcontroller = [[TabbarViewController alloc] init];
    tabbarcontroller.selectedIndex =1;
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarcontroller;
    

    
          
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
