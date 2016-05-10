//
//  RepatmentPlanCell.h
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepaymentModel.h"
@interface RepaymentPlanCell : UITableViewCell{
    UILabel *_paytimeLab;
    UILabel *_profitLal;
    UILabel *_stateLab;
    NSString *_stateStr;

}
@property (nonatomic ,strong)RepaymentModel *model;
@property (nonatomic ,strong)UILabel *paytimeLab;
@property (nonatomic ,strong)UILabel *profitLal;
@property (nonatomic ,strong)UILabel *stateLab;


@end
