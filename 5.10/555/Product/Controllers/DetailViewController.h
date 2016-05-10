//
//  DetailViewController.h
//  555
//
//  Created by otouzi on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "TouziViewController.h"

#import "PageControl.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface DetailViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,PageControlDelegate,UIScrollViewDelegate,NJKWebViewProgressDelegate>
{
    
    
   // UILabel * _promptingLabel; //提示信息
    double sum;//到期还本付息， 按月付息到期还本
    double text;//等额本息
   
    CGFloat _difference;//可投资金额（差）
    UIControl *_maskView;   //遮罩视图
    UIView *_calculatorView;//计算器视图
    UIWindow *_lastWindow;  //当前window
    
    NSString *_principal;  //本金
    NSString *_revenue;   //年华收益
   
     NSNumber  *_openAccountType;//开通汇付的状态
    UITextField *_totalInvestMoneyTextField;//textField

    UILabel *_incomeLabel;       //收入label
    NSString *_revenueStr;       //年化收益
    
    NSString *_delineStr;        //投资期限
    
    NSString *_way_repayment;    //还款方式

    NSString *_increase;
    NSString * _deadline_key;     //投资期限具体到天
    NSString *_way_repayment_key; //还款方式代号
    
    UILabel * _promptingLabel;    //提示信息
   
    UILabel *_introductionLabel;//银行的倍数
    
    double factor;
    double textValue;

    NSString *_increaseStr;
    
    
    
    UIView *_investView;  //投资money
    UIView *_revenueView; //年华收益
    UIView *_deadlineView;//投资期限
   
    
    UIButton *_calculatorButton;//计算器按钮
    UIButton *_touziButton;//投资按钮
    
    
    UILabel *_linelabel; //第一条线
    UILabel *_lineNextLabel;//第二条线
    
    PageControl *thePGLeft;
    UIScrollView*scrVl;
    UIControl *alphaView;
    NSNumber *indexPoint;
    
UIPageControl *_pageControl;
    
    
    
}
@property (nonatomic ,strong)NSMutableArray *data;

@property (nonatomic, strong)ListModel *model;

@property (nonatomic, copy)NSString *productUrlString;
@property (nonatomic ,strong)NSDictionary *extend;
@property (nonatomic ,strong)UILabel *revenueLabel;//年华收益
@property (nonatomic ,strong)UILabel *delineLabel; //投资期限
@property(nonatomic, strong) NSMutableArray *loopImages;

//@property (nonatomic, readonly, strong)UIView *calculatorView;//计算器视图
@end
