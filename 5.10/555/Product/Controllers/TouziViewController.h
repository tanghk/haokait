//
//  TouziViewController.h
//  
//
//  Created by otouzi on 15/11/2.
//
//

#import <UIKit/UIKit.h>
#import "ListModel.h"


@interface TouziViewController : UIViewController<UITextFieldDelegate>


{
    
    CGFloat _difference;//可投资金额（差）
    UILabel *_nameLabel ;          //名称
    
    UIImageView *_newImageView;   //标志图
    
    UILabel *_revenueText;
    UILabel *_revenueLabel;
    
    UILabel * _increaseLabel;    //角标
    
    UILabel *_deadlineText;
    UILabel *_deadlineLabel;     //投资期限
    
    UILabel *_repaymentText;
    UILabel *_repaymentLabel;    //还款方式
    
    UILabel *_introductionLabel;
    
    UIButton *_questionButtton;
    
    UILabel *_investText;
    UITextField *_investTextField; //投资金额
    
    UIButton *_deleateButton;
    
    UILabel *_balanceText;
    UILabel *_balanceLabel; //余额
    
    UILabel *_incomeText;
    UILabel *_incomeLabel; //收益
    
    UIButton *_nextButton;
    UILabel *_noteLabel;
    int count;
    
    NSString *_principal;//本金
    NSString *_revenue;//年华收益
  
  
    NSString *_revenueStr;       //年化收益
    NSString *_delineStr;        //投资期限
    NSString *_way_repayment;    //还款方式
    
    NSString *_increase;
    
    NSString *_increaseStr;
    NSString * _deadline_key;     //投资期限具体到天
    NSString *_way_repayment_key; //还款方式代号
    
   NSString *_invest_money; //新手标投资金额
    
    
    
    NSString *_available; //用户余额
    
    
    
    double sum;                   //到期还本付息， 按月付息到期还本
    double text;                  //等额本息
    
    UIView *_rechargeView;         //提示充值
    UIView *_balanceNotenoughView;//剩余金额不足
    UIView *_residualAmountView;//剩余金额不足
    
    UIWindow *_lastWindow;        //当前window
    UIControl *_maskView;         //遮挡视图
    
    UILabel *_contentLabel;//提示框内容
    
    
    NSString *_noviceMoney ;
}
@property (nonatomic, strong)ListModel *model;
//@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *revenueLabel;//年华收益
@property (nonatomic ,strong)UILabel *delineLabel; //投资期限
@property (nonatomic ,strong)NSString *productId;
@property (nonatomic ,strong)NSString *invest; //输入的投资金额

@property (nonatomic ,strong)NSMutableArray *userInfoData;//用户信息


@property (nonatomic ,strong)NSString *investUrl;//投资的网址
 - (BOOL)validateNumberByRegExp:(NSString *)string;//正则表达式判断第一个允许是0


@end
