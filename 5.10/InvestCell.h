//
//  InvestCell.h
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInvestModel.h"
@interface InvestCell : UITableViewCell
{
    UILabel *_nameLabel;
    UILabel *_moneyLabel;
    UILabel *_invest_annualLabel;
    UILabel *_invest_stateLabel;
    UILabel *_total_incomeLabel;
    UILabel *_investment_release_start_timeLabel;
    UILabel *_investment_release_end_timeLabel;
    NSString *_project_id;
    NSString *_investment_id;
    NSString *_protocol_url;
    
    UIButton *_planButton;
    UIButton *_investmentAgreement;
    
    
    NSString *_isloanType;
    
    NSString *_invest_state_key;
    
}
@property (nonatomic ,strong)MyInvestModel *model;
//@property (nonatomic, strong)NSString *money;//投资金额
//
//@property (nonatomic, strong)NSString *invest_annual;//项目年化收益
//
//@property (nonatomic, strong)NSString *invest_state;//状态
//
//@property (nonatomic, strong)NSString *total_income;//项目应收收益
//
//@property (nonatomic, strong)NSString *investment_release_start_time;//计息日期
//
//@property (nonatomic, strong)NSString *investment_release_end_time;//计息结束日期

UIKIT_EXTERN NSString *const Invest_Money;
UIKIT_EXTERN NSString *const Invest_Annual;
UIKIT_EXTERN NSString *const Total_Income;
UIKIT_EXTERN NSString *const Invest_State;
UIKIT_EXTERN NSString *const Investment_Release_Start_Time;
UIKIT_EXTERN NSString *const Investment_Release_End_Time;


@end
