//
//  MyInvestModel.h
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface MyInvestModel : BaseModel

@property (nonatomic, strong)NSString *project_name;//产品名称

@property (nonatomic, strong)NSString *money;//投资金额

@property (nonatomic, strong)NSString *invest_annual;//项目年化收益

@property (nonatomic, strong)NSString *invest_state;//状态

@property (nonatomic, strong)NSString *total_income;//项目应收收益

@property (nonatomic, strong)NSString *investment_release_start_time;//计息日期

@property (nonatomic, strong)NSString *investment_release_end_time;//计息结束日期

@property (nonatomic, strong)NSString *investment_id;//投资id

@property (nonatomic, strong)NSString *project_id;//项目id

@property (nonatomic, strong)NSString *investment_increase;//增长

@property (nonatomic, strong)NSString *protocol_url;//url

@property (nonatomic, strong)NSString *project_way_repayment;
@property (nonatomic,strong)NSString *isloan;//0 不显示，1显示

@property (nonatomic, strong)NSString *project_annual;

@property (nonatomic ,strong)NSString *invest_state_key;//   //投资状态。1：募集中，2还款中，3流标，4已结束








@end
