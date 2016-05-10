//
//  jiaoyitable.h
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jiaoyimodel.h"
@interface jiaoyitable : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic , strong)jiaoyimodel *model;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *openData;

@end
