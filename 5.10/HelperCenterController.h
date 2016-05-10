//
//  HelperCenterController.h
//  555
//
//  Created by otouzi on 16/3/23.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "YCRequestDataService.h"
#import "MBProgressHUD.h"
@interface HelperCenterController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UIActivityIndicatorView *_indicatorView; //加载控件
    YCRequestDataService *_manager;            //网络请求

    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    MBProgressHUD *HUD;
    
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSString *urlStr;

@end
