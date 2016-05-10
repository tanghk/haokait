//
//  addViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/21.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()
{
    UIProgressView *jindu;
    UIWebView *webxinshou;
    
}

@end

@implementation addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    jindu = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 5)];
    [self.view addSubview:jindu];
    UIImage *img = [UIImage imageNamed:@"homePageCTit5.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];;
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];
    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(addddd:) forControlEvents:UIControlEventTouchUpInside];
    
    //穿透效果
    self.navigationController.navigationBar.translucent = NO;
    
    
    NSString *weburl = [[NSUserDefaults standardUserDefaults]objectForKey:@"zhucelibao"];
    NSURL *url = [NSURL URLWithString:weburl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    NSString *value = [NSString stringWithFormat:@"%@",sta];
    NSString *value1 = [NSString stringWithFormat:@"%@",sb];
    NSString *value2 = [NSString stringWithFormat:@"BROWSER"];
    
    [mutableRequest addValue:value forHTTPHeaderField:@"Access-Token"];
    [mutableRequest addValue:value1 forHTTPHeaderField:@"Application-Session"];
    [mutableRequest addValue:value2 forHTTPHeaderField:@"T-User-Agent"];
    
    webxinshou = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, __kScreenHeight__-64)];
    
    request = [mutableRequest copy];
    
    [self.view addSubview:webxinshou];
    
    [webxinshou loadRequest:request];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addddd:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
