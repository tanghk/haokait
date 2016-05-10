//
//  bankview.h
//  demotest
//
//  Created by otouzi on 15/12/7.
//  Copyright © 2015年 otouzi. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import <UIKit/UIKit.h>
#import "BankModel.h"

@interface bankview : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic , strong)BankModel *model;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *openData;

@end
