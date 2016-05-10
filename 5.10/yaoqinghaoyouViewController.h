//
//  yaoqinghaoyouViewController.h
//  555
//
//  Created by 李浩宇 on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "renmaiyaoqingViewController.h"
#import "remaotouziViewController.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>
@interface yaoqinghaoyouViewController : UIViewController<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_shareView;//分享视图
    UIWindow *_lastWindow; //当前window
    UIControl *_maskView; //遮罩视图
}
@end
