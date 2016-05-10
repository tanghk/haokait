//
//  renmaitouzitable.h
//  555
//
//  Created by 李浩宇 on 15/12/30.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaitouzimodel.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface renmaitouzitable : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic , strong)renmaitouzimodel *model;
@property (nonatomic , strong)NSMutableArray *data;


@end
