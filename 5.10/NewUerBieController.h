//
//  NewUerBieController.h
//  555
//
//  Created by otouzi on 16/4/21.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface NewUerBieController : UIViewController

UIKIT_EXTERN NSString *const Deadline;
UIKIT_EXTERN NSString *const Deadline_Value;
UIKIT_EXTERN NSString *const Have;
UIKIT_EXTERN NSString *const Join;
UIKIT_EXTERN NSString *const Units;


@property (nonatomic, strong)ListModel *model;
@property (nonatomic ,strong)NSString *productId;

@end
