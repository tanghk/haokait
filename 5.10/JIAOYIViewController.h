//
//  JIAOYIViewController.h
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jiaoyimodel.h"
#import "MBProgressHUD.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface JIAOYIViewController : UIViewController<MBProgressHUDDelegate>
{

    NSInteger pageCont;
    BOOL freshState;
MBProgressHUD *HUD;
}

@property (nonatomic ,strong)jiaoyimodel *model;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *openData;
@end
