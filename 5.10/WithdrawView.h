//
//  WithdrawView.h
//  555
//
//  Created by otouzi on 16/4/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoramlBankCardCell.h"
@protocol IndexDelegate<NSObject>

@optional
- (void)changeIndex:(NSUInteger)index;

@end

@interface WithdrawView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id<IndexDelegate>indexdelegate;
@property (nonatomic, strong)NSMutableArray *data;
@end
