//
//  NormalController.h
//  555
//
//  Created by otouzi on 16/4/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"
#import "NoramlBankCardCell.h"
#import "WithdrawView.h"
@interface NormalController : UIViewController<UITextFieldDelegate,IndexDelegate>
{
   
}

@property(nonatomic, strong)WithdrawView *withdraw;
@property (nonatomic ,strong)NSMutableArray *data;
@property (nonatomic ,assign)BOOL is_holiday;//0是非假期，1是假期。
@property(nonatomic ,strong)NSString *available_balance;//可用余额
@property (nonatomic ,strong)NSString *realname;//持卡人
@property (nonatomic ,assign)NSString * holiday_days;
@property (nonatomic ,assign)BOOL tomrrow_Is_Holiday;
@end
