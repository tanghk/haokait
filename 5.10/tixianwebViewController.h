//
//  tixianwebViewController.h
//  555
//
//  Created by 李浩宇 on 15/12/18.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
@interface tixianwebViewController : UIViewController<WebViewJavascriptBridgeBaseDelegate,UIWebViewDelegate>

@property(nonatomic,strong)NSString *withdraw;


@end
