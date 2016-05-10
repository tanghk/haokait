//
//  WithdrawController.h
//  555
//
//  Created by otouzi on 16/3/29.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawController : UIViewController<UITextFieldDelegate>
{
    UILabel *_canBeWithdrawalAmount;//可提现金额
    UILabel *_withdrawalAmount;//提现金额
    UITextField *_enterAmount;//输入金额
    NSString *_available_balance;//可用余额
    NSString *_amount_entered;//输入金额
}
@end
