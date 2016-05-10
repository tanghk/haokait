//
//  jiaoyiTableViewCell.h
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jiaoyimodel.h"
@interface jiaoyiTableViewCell : UITableViewCell
@property (strong, nonatomic)jiaoyimodel *model;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyiclass;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *messge;

@property (weak, nonatomic) IBOutlet UILabel *jiaoyijine;
@property (weak, nonatomic) IBOutlet UILabel *keyongyue;


@end
