//
//  InvestSucessController.m
//  555
//
//  Created by otouzi on 16/3/30.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "InvestSucessController.h"
#import "Masonry.h"
#import "UICommons.h"
#import "AFNetworking.h"//网络请求
#import "HasInvestedBieController.h"
#import "DataService.h"
@interface InvestSucessController ()
{
    UILabel *_start_timeLabel;
    UILabel *_end_timeLabel;
    UILabel *_total_incomeLab;




}
@end

@implementation InvestSucessController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestChinapnrhandleInvest];
     
    [self creatWithNavGation];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = kColorWhite;
    [self custumInvestSucceedViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    ///v2/chinapnrhandle/invest
}

#pragma mark - 请求投资成功数据
- (void)requestChinapnrhandleInvest{
    
    
    
  }


#pragma mark - 自定义视图
- (void)custumInvestSucceedViews{
    int padingLeft =0.056*kScreenWidth;
    int padingTop = 0.046*kScreenHeight;
    int padingRight =0.056*kScreenWidth;
    
    
    /*
     *投资成功
     */
    UIImageView *topView = [UIImageView new];
    topView.image = [UIImage imageNamed:@"newbie_succeed"];
    [self.view addSubview:topView];

    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64.5);
        make.height.mas_equalTo(0.298*kScreenHeight);
     
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
        make.width.mas_equalTo(481/3);
        
    }];

    /*
     *计息时间
     */
    _start_timeLabel = [UILabel new];
    _start_timeLabel.textAlignment = NSTextAlignmentRight;
    _start_timeLabel.font = Font(0.021*kScreenHeight);
    _start_timeLabel.text = @"2016-02-17";
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
    _end_timeLabel.text = @"2016-02-18";
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
    _total_incomeLab.text = @"2.73元";
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
    
    
    /*
     *完成按钮
     */
    UIButton *completeBtn = [UIButton new];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = Font(0.027*kScreenHeight);
    [completeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [completeBtn setBackgroundColor:kColorMain];
    completeBtn.layer.cornerRadius = 5;

    [completeBtn addTarget:self
                    action:@selector(completeAction:)
          forControlEvents:UIControlEventTouchUpInside];
    

    [self.view addSubview:completeBtn];
    
    
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-0.031*kScreenWidth);
        make.left.equalTo(self.view).offset(0.031*kScreenWidth);
        make.top.equalTo(leftView.mas_bottom).offset(0.118*kScreenHeight);
        make.height.mas_equalTo(0.079*kScreenHeight);
    }];
    //

    
    
    
   

}




#pragma mark - 完成按钮
- (void)completeAction:(UIButton *)sender{
    
  HasInvestedBieController *hasInvestedBie = [[HasInvestedBieController alloc]init];
//  
//    [self.navigationController pushViewController:hasInvestedBie animated:YES];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:hasInvestedBie animated:NO completion:nil];
    
    

    
}

#pragma mark 返回按钮
- (void)backBtnAction:(UIButton *)sender{
   // [self.navigationController popViewControllerAnimated:YES];
    
    

//    
    
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

@end
