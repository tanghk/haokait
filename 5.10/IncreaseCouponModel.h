//
//  IncreaseCouponModel.h
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface IncreaseCouponModel : BaseModel
@property (nonatomic ,strong)NSString *name;            //优惠券名称
@property (nonatomic ,strong)NSString *effective_time;  //优惠券开始时间
@property (nonatomic ,strong)NSString *expired_time;    //优惠券结束时间
@property (nonatomic ,strong)NSString *par;             //优惠券金额
@property (nonatomic ,strong)NSString *type;            //优惠券类型
@property (nonatomic ,strong)NSString *state;           //优惠券的使用状态
@property (nonatomic ,strong)NSString * descriptionDetail;    //描述
@property (nonatomic ,strong)NSString *increase;



@end
