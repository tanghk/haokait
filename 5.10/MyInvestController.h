//
//  MyInvestController.h
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
@interface MyInvestController : BaseViewController<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic ,strong)NSMutableArray *data;


@end
