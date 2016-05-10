//
//  InvitationFriendController.h
//  555
//
//  Created by otouzi on 16/4/13.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>



@interface InvitationFriendController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,MBProgressHUDDelegate,MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate>

{
    NSString *_title;
    NSString *_text;
    NSString *bbc;

}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSString *urlStr;
@property (nonatomic, strong)NSString *hrefShare;

@end
