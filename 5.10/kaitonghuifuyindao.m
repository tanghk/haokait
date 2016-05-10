//
//  kaitonghuifuyindao.m
//  555
//
//  Created by 李浩宇 on 15/12/31.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "kaitonghuifuyindao.h"
#import "AFNetworking.h"
#import "CLLockVC.h"
#import "UIImageView+AFNetworking.h"

#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "disafangViewController.h"
#import "UICommons.h"
#import "Masonry.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface kaitonghuifuyindao ()
{
    UILabel *_titleLabel;
    UIWindow *lastwindou;
    UIControl *zhedang;
    UIView *xieyiview;
    UILabel *lijilable;
    UIImageView *logoim;
}

@end

@implementation kaitonghuifuyindao
-(void)viewWillAppear:(BOOL)animated
{[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
        [self yindaoyeqing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
     [self performSelector:@selector(lockView) withObject:nil afterDelay:0.5];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"开通汇付天下";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(huifuyindao:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    //穿透效果
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    
#pragma mark - 引导图
    
    
   logoim = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 620*__kScreenHeight__/1334)];
   
    [logoim setImage:[UIImage imageNamed:@"6OpenRemiImg@2x.png"] ];

    [self.view addSubview:logoim];
    
#pragma mark - 提示图
    UIImageView *xiaosan = [[UIImageView alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 793*__kScreenHeight__/1334,702*__kScreenWidth__/750 , 219*__kScreenHeight__/1334)];
    [xiaosan setImage:[UIImage imageNamed:@"6OpenRemi2@2x.png"]];
    [self.view addSubview:xiaosan];
    
    
#pragma mark - 需知按钮
    UIButton *kaitongxuzhi = [[UIButton alloc]initWithFrame:CGRectMake(514*__kScreenWidth__/750, 926*__kScreenHeight__/1334,164*__kScreenWidth__/750 , 51*__kScreenHeight__/1334)];
    [kaitongxuzhi setBackgroundImage:[UIImage imageNamed:@"huifu_04.png"] forState:UIControlStateNormal];//未按下图片
    [self.view addSubview:kaitongxuzhi];
    [kaitongxuzhi addTarget:self action:@selector(xuzhixiang1:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark - 立即开通
    UIButton *liji = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 1087*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    [liji setBackgroundImage:[UIImage imageNamed:@"huifu_08.png"] forState:UIControlStateNormal];
    [self.view addSubview:liji];
    
    lijilable = [[UILabel alloc]initWithFrame:CGRectMake(0, 1115*__kScreenHeight__/1334, __kScreenWidth__, 31*__kScreenHeight__/1334)];
   
    lijilable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lijilable];
    [liji addTarget:self action:@selector(kaitong:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 暂不开通
    UIButton *bvukaitong = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 1199*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    [bvukaitong setBackgroundImage:[UIImage imageNamed:@"huifu_11.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:bvukaitong];
    [bvukaitong addTarget:self action:@selector(geren:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    zhedang = [[UIControl alloc]
               initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    zhedang.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    zhedang.hidden = YES;
    [zhedang addTarget:self
                action:@selector(maskViewAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    lastwindou = [UIApplication sharedApplication].windows.lastObject;
    
    
    xieyiview = [[UIView alloc]initWithFrame:CGRectMake(75*__kScreenWidth__/750,524*__kScreenHeight__/1334 , 600*__kScreenWidth__/750, 405*__kScreenHeight__/1334)];
    
    
    
    
    xieyiview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:xieyiview];
    
    xieyiview.hidden = YES;
    //    [self.view addSubview:zhedang];
    [self.view insertSubview:zhedang belowSubview:xieyiview];
    
    //画线
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [xieyiview  addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.5);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 211.0/255.0, 74.0/255.0, 89.0/255.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 48*__kScreenWidth__/750,100*__kScreenHeight__/1334);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),552*__kScreenWidth__/750,100*__kScreenHeight__/1334  );   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (__kScreenHeight__ == 568) {
        UILabel *uila = [[UILabel alloc]initWithFrame:CGRectMake(0, 36*__kScreenHeight__/1334, 600*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
        
        
        uila.text = @"开通汇付须知";
        uila.textAlignment = NSTextAlignmentCenter;
        uila.textColor = [UIColor blackColor];
        uila.font = [UIFont systemFontOfSize:18];
        [xieyiview addSubview:uila];
        
        UIView *desew = [[UIView alloc]initWithFrame:CGRectMake(48*__kScreenWidth__/750, 135*__kScreenHeight__/1334, 504*__kScreenWidth__/750, 491*__kScreenHeight__/1334)];
        
        [xieyiview addSubview:desew];
        
        
        UILabel *_genghuanxuzhi = [[UILabel alloc]initWithFrame:CGRectMake(49*__kScreenWidth__/750, 40*__kScreenHeight__/1334, 509*__kScreenWidth__/750, 300*__kScreenHeight__/1334)];
        _genghuanxuzhi.textAlignment = NSTextAlignmentLeft;
        //        _genghuanxuzhi.lineBreakMode = UILineBreakModeClip;
        _genghuanxuzhi.numberOfLines = 0;
        
        _genghuanxuzhi.textColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1];
        NSString *as = [[NSUserDefaults standardUserDefaults]objectForKey:@"kehuzhanghao"];
        
        NSInteger po = as.length;
        NSLog(@"%ld",po);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"汇付天下为独立第三方平台，需要设置独立的登录密码与交易密码，请您妥善保管！为方便记忆，汇付平台登录密码可与沃投资平台登录密码一致。"]];
        
   
        _genghuanxuzhi.attributedText = str;
        
        _genghuanxuzhi.font = [UIFont systemFontOfSize:13];
        [xieyiview addSubview:_genghuanxuzhi];
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,309*__kScreenHeight__/1334,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"6closeBtn@2x.png"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];

        
           }
    
    
    
    
    
    else if(__kScreenHeight__ >= 667)
    {
        UILabel *uila = [[UILabel alloc]initWithFrame:CGRectMake(0, 36*__kScreenHeight__/1334, 600*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
        
        
        uila.text = @"开通汇付需知";
        uila.textAlignment = NSTextAlignmentCenter;
        uila.textColor = [UIColor blackColor];
        uila.font = [UIFont systemFontOfSize:18];
        [xieyiview addSubview:uila];
        
        UIView *desew = [[UIView alloc]initWithFrame:CGRectMake(48*__kScreenWidth__/750, 135*__kScreenHeight__/1334, 504*__kScreenWidth__/750, 491*__kScreenHeight__/1334)];
        
        [xieyiview addSubview:desew];
        
        
        UILabel *_genghuanxuzhi = [[UILabel alloc]initWithFrame:CGRectMake(49*__kScreenWidth__/750, 40*__kScreenHeight__/1334, 509*__kScreenWidth__/750, 300*__kScreenHeight__/1334)];
        _genghuanxuzhi.textAlignment = NSTextAlignmentLeft;
        //    _genghuanxuzhi.lineBreakMode = UILineBreakModeClip;
        _genghuanxuzhi.numberOfLines = 0;
        
        _genghuanxuzhi.textColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1];
        NSString *as =[[NSUserDefaults standardUserDefaults]objectForKey:@"kehuzhanghao"];
        NSInteger po = as.length;
        NSLog(@"%ld",po);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"提示：汇付天下为独立第三方平台，需要设置独立的登录密码与交易密码，请您妥善保管！为方便记忆，汇付平台登录密码可与沃投资平台登录密码一致。"]];
        
        
        _genghuanxuzhi.attributedText = str;
        
        _genghuanxuzhi.font = [UIFont systemFontOfSize:13];
        [xieyiview addSubview:_genghuanxuzhi];
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,309*__kScreenHeight__/1334,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"6enrollBtn1"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];

        
        
        
        
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kaitong:(id)sender
{
    disafangViewController *disanfang= [[disafangViewController alloc]init];
    disanfang.model = _model;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:disanfang animated:NO completion:nil];
    
}
-(void)geren:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
    
}
-(void)huifuyindao:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
}

-(void)yindaoyeqing
{
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate* currentDate = [NSDate date];
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    //
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    NSString *token250 = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (timeExpire >= time||token250 == nil) {
        //重新请求access_token
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSString *udid = [UIDevice currentDevice].model ;
        NSLog(@"************唯一标识符%@",uuid);
        
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp": timeSp,
                        // @" backage_md5": @"1234678998765412374185296395175",
                        
                        @"app_session_token":sb}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    }
    else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        NSLog(@"%@",token);
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    

    [manager POST:@"http://debug.otouzi.com:8012/openload"
       parameters:@{}
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"%@",responseObject);
              NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
              
              objc = responseObject;
              
//              [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"thumb"] forKey:@"yindaotu"];
//              NSString *pic = [[NSUserDefaults standardUserDefaults]objectForKey:@"yindaotu"];
//              NSURL *url = [NSURL URLWithString:pic];
//              [logoim setImageWithURL:url  placeholderImage:[UIImage imageNamed:@""]];
              
              [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"registerAccountButton"] forKey:@"ziti"];
              lijilable.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"ziti"];

              
          } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
              
          }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)lockView{
       
}

-(void)xuzhixiang1:(id)sender
{
    [self showShareView];
}
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = NO;
                         
                         //使用block，来执行一个动画
                         //向下的平移
                         //                         .transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight-1230/3-kNavigationBarHeight));
                         
                         zhedang.hidden = NO;
                     }];
    
}
//隐藏尾部视图
- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = YES;
                     }];
    
}
-(void)maskViewAction:(id)sender
{
    zhedang.hidden = YES;
    [self hideShareView];
}
-(void)xuzhitui:(id)sender
{
    
    zhedang.hidden = YES;
    [self hideShareView];
    
}
- (void)setModel:(ListModel *)model{
    
    _model = model;
    
}


@end
