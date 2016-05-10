//
//  RepaymentModel.h
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface RepaymentModel : BaseModel
@property (nonatomic ,strong)NSString *paytime;// 还款时间
@property (nonatomic ,strong)NSString *profit;//还款金额
@property (nonatomic ,strong)NSString *state;//还款状态
@property (nonatomic ,strong)NSString * totalmoney;



@end
