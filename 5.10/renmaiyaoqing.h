//
//  renmaiyaoqing.h
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaimodle.h"
@interface renmaiyaoqing : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic , strong)renmaimodle *model;
@property (nonatomic , strong)NSMutableArray *data;


@end
