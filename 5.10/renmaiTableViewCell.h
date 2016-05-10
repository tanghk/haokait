//
//  renmaiTableViewCell.h
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaimodle.h"
@interface renmaiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dengji;
@property (weak, nonatomic) IBOutlet UILabel *zhaungtai;
@property (nonatomic,strong)renmaimodle *model;
@end
