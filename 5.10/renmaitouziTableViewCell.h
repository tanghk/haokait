//
//  renmaitouziTableViewCell.h
//  555
//
//  Created by 李浩宇 on 15/12/30.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaitouzimodel.h"
@interface renmaitouziTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;
@property (weak, nonatomic) IBOutlet UILabel *dengji;
@property (weak, nonatomic) IBOutlet UILabel *jjine;
@property(nonatomic,strong)renmaitouzimodel *model;

@end

