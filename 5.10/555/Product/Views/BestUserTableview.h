//
//  BestUserTableview.h
//  555
//
//  Created by otouzi on 15/10/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DetailTableViewController.h"

@interface BestUserTableview : UITableView<UITableViewDataSource,UITableViewDelegate>//,DetailTableViewControllerDelegate

{
    
    
    
}
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic ,strong)NSIndexPath *indexp;
@end
