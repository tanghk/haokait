//
//  ChanpinViewController.h
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestUserTableview.h"//优质用户表视图
#import "SelectedModel.h"
#import "MBProgressHUD.h"

@interface ChanpinViewController : UIViewController<MBProgressHUDDelegate>

{
    UIImageView *_images;
   
    MBProgressHUD *HUD;
    //BestUserTableview *_bestUserTableView;//优质散标表视图
    //TransferTableView *_transfertableview; //转让专区表视图

    UIView*_footerView;             //筛选按钮弹出视图
    
    UIImageView *_headerImageView;   //头视图
    
    UIControl *_maskView;           //遮罩视图

    UIWindow *_lastWindow;          //当前window

    //筛选按钮下
    UIView *_filterNavigationView;  //筛选视图
    UIView *_repaymentView;         //还款方式
    UIView *_revenueView;           //年化收益视图
    UIView *_deadlineView;          //投资期限视图
    
    UILabel *_repaymentLabel;       //还款方式label
    UILabel *_revenueLabel;         // 年化收益率label
    UILabel *_deadlineLabel;        //投资期限
    UILabel *_riskLabel;
    
    UIButton *_riskButton;            //风险等级button
    UIButton *_repayButton;          //所有还款方式
    UIButton *_revenueButton;        //年化收益率button
    UIButton *_deadlineButton;       //投资期限button
    
    UILabel *_deadlineTimeLabel;     //投资时间

    NSString *_postStr;             //发送请求到code
    NSString *baseUrl;
    
    NSString *_sta;                 //全局的token
    
    BOOL isExistenceNetwork;        //判断网络状态
    
    NSInteger pageCont;
    BOOL freshState;
    
      UIButton *_headerControl;    
    BOOL hasData;
    
    NSString *_fiterType;    //是筛选数据
    NSInteger fiterCont;
    BOOL fiterFreshState;
    
    
    
    
    
    NSString *_bannerUrl;//活动化图片
}

@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *baseData;
@property (nonatomic , strong)UIButton *quanButton;//全局button
@property (nonatomic , strong)UIButton *juButton;//全局button
@property (nonatomic, strong)NSMutableArray *filterData;//筛选列表data

@property (nonatomic, strong)NSMutableArray *selectedRepayData;

@property (nonatomic , strong)NSMutableArray *selectedRevenueData;

@property (nonatomic , strong)NSMutableArray *selectedDeadlineData;

@property (nonatomic ,strong)NSMutableArray *selectedRiskData;

@property (strong,nonatomic)UIButton * tmpBtn;//全局button
@property (strong,nonatomic)UIButton * staticButton;//全局button
@property (nonatomic , strong)UIButton *otherButton;

@end
