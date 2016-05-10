//
//  TableViewCell.h
//  555
//
//  Created by 李浩宇 on 15/12/4.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"
#import "UIImageView+AFNetworking.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface TableViewCell : UITableViewCell
@property (nonatomic ,strong)BankModel *model;
@property (nonatomic,strong)NSString *logiurl;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *backname;
@property (weak, nonatomic) IBOutlet UILabel *some;
@property (weak, nonatomic) IBOutlet UILabel *tishilable;

@end
