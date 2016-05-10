//
//  DengluViewController.h
//  555
//
//  Created by 浩宇李 on 15/9/23.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ListModel.h"
@interface DengluViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSString *shoujihao;
@property (nonatomic,strong) NSString *mima;
@property (nonatomic, strong)NSString *statues;
@property (nonatomic, strong)ListModel *model;

@end
