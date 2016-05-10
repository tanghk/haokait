//
//  repaymentPlanController.h
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
@interface RepaymentPlanController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;


}
@property (nonatomic ,strong)NSString *project_id;
@property (nonatomic ,strong)NSString *investment_id;
@property (nonatomic ,strong)NSMutableArray *data;

UIKIT_EXTERN NSString *const Invest_Money;
UIKIT_EXTERN NSString *const Invest_Annual;
UIKIT_EXTERN NSString *const Total_Income;
UIKIT_EXTERN NSString *const Invest_State;
UIKIT_EXTERN NSString *const Investment_Release_Start_Time;
UIKIT_EXTERN NSString *const Investment_Release_End_Time;

@end
