//
//  InvestmentAgreementController.h
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "MBProgressHUD.h"
@interface InvestmentAgreementController : BaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,MBProgressHUDDelegate>
{
    UIWebView *_webView;
}



@property (nonatomic , strong)NSString *product_id;//产品id
@property (nonatomic , strong)NSString *invest;//投资金额

@property (nonatomic,strong)NSString *WANGZHI;


@property (nonatomic ,strong)NSString *investUrl;//投资的网址

@end
