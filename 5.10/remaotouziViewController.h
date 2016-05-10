//
//  remaotouziViewController.h
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renmaitouzimodel.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface remaotouziViewController : UIViewController<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UIView *_shareView;//分享视图
    UIWindow *_lastWindow; //当前window
    UIControl *_maskView; //遮罩视图

        
        
        NSInteger pageCont;
        BOOL freshState;
        MBProgressHUD *HUD;
        
        
 


}
@property (nonatomic ,strong)renmaitouzimodel *model;
@property (nonatomic , strong)NSMutableArray *data;
@end
