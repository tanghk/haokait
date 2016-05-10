//
//  HomePageNoticeController.h
//  555
//
//  Created by otouzi on 16/3/23.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "MBProgressHUD.h"
@interface HomePageNoticeController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,MBProgressHUDDelegate>
{
    
    
    UILabel *_titleLabel;
    NSString *_parameter;//参数
    NSString *_event;//事件名称
    UIButton *_backBtn;
    MBProgressHUD *HUD;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    
    
    
    
    
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSString *urlStr;


@end
