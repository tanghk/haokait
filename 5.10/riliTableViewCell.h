//
//  riliTableViewCell.h
//  555
//
//  Created by 李浩宇 on 16/3/17.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rilimodel.h"
@interface riliTableViewCell : UITableViewCell
@property (strong, nonatomic)rilimodel *model;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *recalids;
@property (weak, nonatomic) IBOutlet UILabel *lilv;
@property (weak, nonatomic) IBOutlet UILabel *monay;
@property (weak, nonatomic) IBOutlet UILabel *type;

@end
