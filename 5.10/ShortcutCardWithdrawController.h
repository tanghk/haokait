//
//  ShortcutCardWithdrawController.h
//  555
//
//  Created by otouzi on 16/4/12.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortcutCardWithdrawController : UIViewController<UITextFieldDelegate>
{}

@property (nonatomic ,strong)NSString *available_balance;//可用余额
@property (nonatomic ,strong)NSString *realname;//持卡人
@property (nonatomic ,assign)BOOL is_holiday;//0是非假期，1是假期。
@property (nonatomic ,assign)BOOL tomrrow_Is_Holiday;
@property (nonatomic ,assign)NSString * holiday_days;

@end
//     "is_holiday": 0,          //当天是不是节假日
//"tomorrow_is_holiday": 0,      //第二天是不是节假日
//"holiday_days": 3,             //是节假日，节假日持续几天、