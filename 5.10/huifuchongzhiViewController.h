//
//  huifuchongzhiViewController.h
//  555
//
//  Created by 浩宇李 on 15/12/14.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
@interface huifuchongzhiViewController : ViewController<UIWebViewDelegate,WebViewJavascriptBridgeBaseDelegate>
@property WebViewJavascriptBridge* bridge;
@end
