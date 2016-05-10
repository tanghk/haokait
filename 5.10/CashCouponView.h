//
//  CashCouponView.h
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashCouponView : UITableView<UITableViewDelegate,UITableViewDataSource>{
    
    UIButton *_investButton;
}
@property (nonatomic, strong)NSMutableArray *data;
@end


