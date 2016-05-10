//
//  ExperienceCouponCell.h
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExprienceModel.h"
@interface ExperienceCouponCell : UITableViewCell
{
    UIImageView*_bgView;                      //背景优惠券类型  未使用 已使用，已过期
    UILabel *_nameLabel;                 //优惠卷名称
    UILabel *_parLabel;                  //优惠卷金额
    UILabel *_expired_timeLabel;         //优惠卷结束时间
    UILabel *_expired_time_bottomLabel;  //下方优惠卷结束时间；
    UIButton *_expiredButton;
    NSString *_state;                    //使用状态
    
    
}

@property (nonatomic ,strong)ExprienceModel *model;
@end
