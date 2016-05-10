//
//  AboutUsControllers.h
//  555
//
//  Created by otouzi on 16/3/18.
//  Copyright © 2016年 李浩宇. All rights reserved.
//


#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "MBProgressHUD.h"

@interface AboutUsControllers : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSString *urlStr;


@end
