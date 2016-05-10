//
//  renmaiyaoqingViewController.h
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaimodle.h"
#import "MBProgressHUD.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#import "AFNetworking.h"
@interface renmaiyaoqingViewController : UIViewController<MBProgressHUDDelegate>



{

      
        NSInteger pageCont;
        BOOL freshState;
        MBProgressHUD *HUD;
   


}
@property (nonatomic ,strong)renmaimodle *model;
@property (nonatomic , strong)NSMutableArray *data;
@end
