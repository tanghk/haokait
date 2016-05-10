//
//  ProductInvestViewController.h
//  555
//
//  Created by otouzi on 15/12/4.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "WebViewJavascriptBridge.h"
#import "TouziViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface ProductInvestViewController : UIViewController<UIWebViewDelegate,WebViewJavascriptBridgeBaseDelegate,NJKWebViewProgressDelegate>
{
    UIWebView *_webView;
}
@property (nonatomic, strong)ListModel *model;

@property (nonatomic , strong)NSString *product_id;//产品id
@property (nonatomic , strong)NSString *invest;//投资金额
@property WebViewJavascriptBridge* bridge;
@property (nonatomic,strong)NSString *WANGZHI;
@property (nonatomic ,strong)TouziViewController *touziVC;

@property (nonatomic ,strong)NSString *investUrl;//投资的网址
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
