//
//  rilitable.h
//  555
//
//  Created by 李浩宇 on 16/3/17.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rilimodel.h"
@interface rilitable : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic , strong)rilimodel *model;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *openData;


@end
