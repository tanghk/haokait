//
//  NewUSerBieInvestController.h
//  555
//
//  Created by otouzi on 16/4/21.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface NewUSerBieInvestController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    
    UIWebView *_webView;
    
    UILabel *_titleLabel;
    
    NSString *_parameter;//参数
    NSString *_event;//事件名称
    UIButton *_backBtn;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    
    
    
}


@property (nonatomic , strong)NSString *product_id;//产品id
@property (nonatomic , strong)NSString *invest;//投资金额
@property (nonatomic ,strong)NSString *investUrl;//投资的网址


@end
