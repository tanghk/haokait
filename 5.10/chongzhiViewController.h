//
//  chongzhiViewController.h
//  555
//
//  Created by 李浩宇 on 15/12/3.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
#import "BankModel.h"
#import "NewbieController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
@interface chongzhiViewController : UIViewController
{
    int c;
    int yizu;
    int erzu;
    
}
@property (nonatomic ,strong)BankModel *model;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *openData;

@end
