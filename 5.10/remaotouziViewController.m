//
//  remaotouziViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "remaotouziViewController.h"
#import "renmaitouzitable.h"
#import "MJRefresh.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UICommons.h"
#import "UIViewExt.h"  
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface remaotouziViewController ()
{
    UILabel *jiangjin;
    UILabel *sanji;
    UILabel *erji;
    UILabel *yiji;
    UILabel *jializhanshi ;
    UILabel *renshu;
    UILabel *yaoqingma;
}
@property(nonatomic,strong)renmaitouzitable *table;
@end


@implementation remaotouziViewController
-(void)viewWillAppear:(BOOL)animated{
  
    pageCont =1;
    freshState = NO;
    
    
    [self renmaitouzimo];
    [super viewWillAppear:animated];
    
      [self createShareView];
    self.data = [NSMutableArray array];
    __weak remaotouziViewController* weakSelf = self;
    //下拉刷新的头视图
    self.table.header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.data removeObjectsInArray:
//         self.data]; //下拉刷新将原有数据移除｜｜重新加载数据
        
        pageCont =1;
        freshState = NO;
        
        [weakSelf renmaitouzimo];
    }];
    
    //上拉加载更多
    self.table.footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [weakSelf renmaitouzimo];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;

    _table = [[renmaitouzitable alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__,1270*__kScreenHeight__/1334 )];

    [self.view addSubview:_table];
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 1260*__kScreenHeight__/1334)];
    
    //背景图
    
    UIImageView *imtu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 259*__kScreenHeight__/1334)];
    [imtu setImage:[UIImage imageNamed:@"6ConneRecord@2x_02.png"]];
    
    [head addSubview:imtu];

    //人数lable
   
    renshu = [[UILabel alloc]initWithFrame:CGRectMake(0, 76*__kScreenHeight__/1334, __kScreenWidth__*0.5,57*__kScreenHeight__/1334)];

    
    renshu.textColor = [UIColor colorWithRed:243/255.0 green:210/255.0 blue:78/255.0 alpha:1];
    
    renshu.textAlignment = NSTextAlignmentCenter;
    [head addSubview:renshu];
    
    
    UILabel *ren = [[UILabel alloc]initWithFrame:CGRectMake(0, 158*__kScreenHeight__/1334, __kScreenWidth__*0.5, 57*__kScreenHeight__/1334)];
    
    ren.text = @"成功投资人数（人）";
    ren.textAlignment = NSTextAlignmentCenter;
    ren.textColor = [UIColor colorWithRed:243/255.0 green:210/255.0 blue:78/255.0 alpha:1];
    [head addSubview:ren];
    
   
    jiangjin = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5, 76*__kScreenHeight__/1334, __kScreenWidth__*0.5, 57*__kScreenHeight__/1334)];
    
    jiangjin.textColor = [UIColor colorWithRed:197/255.0 green:51/255.0 blue:70/255.0 alpha:1];
    
    jiangjin.textAlignment = NSTextAlignmentCenter;
   
    [head addSubview:jiangjin];
    
    _table.tableHeaderView = head;
    
    
    UILabel *jingli = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.5, 158*__kScreenHeight__/1334, __kScreenWidth__*0.5, 57*__kScreenHeight__/1334)];
    
    jingli.text = @"累计奖励（元）";
    jingli.textAlignment = NSTextAlignmentCenter;
    jingli.textColor = [UIColor colorWithRed:197/255.0 green:51/255.0 blue:70/255.0 alpha:1];
    [head addSubview:jingli];
    
    if (__kScreenHeight__ == 568) {
        renshu.font = [UIFont systemFontOfSize:30];
        ren.font = [UIFont systemFontOfSize:13];
        jiangjin.font = [UIFont systemFontOfSize:30];
        jingli.font = [UIFont systemFontOfSize:13];
    }else if (__kScreenHeight__ >=667)
    {
        renshu.font = [UIFont systemFontOfSize:35];
        ren.font = [UIFont systemFontOfSize:15];
        jiangjin.font = [UIFont systemFontOfSize:35];
        jingli.font = [UIFont systemFontOfSize:15];
    }

    
    //展示图
    UIImageView *zhanshitu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 259*__kScreenHeight__/1334, __kScreenWidth__, 442*__kScreenHeight__/1334)];
    UIImage *zhanshiim = [UIImage imageNamed:@"ConneRecordSJ.png"];
    [zhanshitu setImage:zhanshiim];
    [head addSubview:zhanshitu];
    
    //专属
    UIImageView *zhuanshu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 701*__kScreenHeight__/1334, __kScreenWidth__, 356*__kScreenHeight__/1334)];
    
    UIImage *zhuanshuim = [UIImage imageNamed:@"6ConneRecord2@2x_03.png"];
    
    [zhuanshu setImage:zhuanshuim];
    
    [head addSubview:zhuanshu];
    
    //头标
    UIImageView *toubiao =[[UIImageView alloc]initWithFrame:CGRectMake(0, 1057*__kScreenHeight__/1334, __kScreenWidth__,84*__kScreenHeight__/1334 )];
    UIImage *tou = [UIImage imageNamed:@"6ConneRecord@2x_05.png"];
    [toubiao setImage:tou];
    [head addSubview:toubiao];
    
    //分类提示
    UIImageView *fenlei = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1141*__kScreenWidth__/750, __kScreenWidth__, 106*__kScreenHeight__/1334)];
    UIImage *feileiim = [UIImage imageNamed:@"ConneRecord22_05.png"];
    [fenlei setImage:feileiim];
    [head addSubview:fenlei];
    
    
    //展示数据
    
    
    jializhanshi = [[UILabel alloc]initWithFrame:CGRectMake(0, 437*__kScreenHeight__/1334, 170*__kScreenWidth__/750, 40*__kScreenHeight__/1334)];
    
    jializhanshi.textAlignment = NSTextAlignmentCenter;
    jializhanshi.textColor = [UIColor colorWithRed:224/255.0 green:26/255.0 blue:61/255.0 alpha:1];
    jializhanshi.font = [UIFont systemFontOfSize:14];
    [head addSubview:jializhanshi];
    
    
    
    
    yiji = [[UILabel alloc]initWithFrame:CGRectMake(462*__kScreenWidth__/750, 345*__kScreenHeight__/1334, 121*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
    yiji.textColor =[UIColor colorWithRed:224/255.0 green:26/255.0 blue:61/255.0 alpha:1];
    
    yiji.textAlignment = NSTextAlignmentCenter;
    
    yiji.font = [UIFont systemFontOfSize:12];
    
    
    [head addSubview:yiji];
    
    
    
     erji= [[UILabel alloc]initWithFrame:CGRectMake(516*__kScreenWidth__/750, 442*__kScreenHeight__/1334, 121*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
    erji.textColor =[UIColor colorWithRed:224/255.0 green:26/255.0 blue:61/255.0 alpha:1];
    
    erji.textAlignment = NSTextAlignmentCenter;
    
    erji.font = [UIFont systemFontOfSize:12];
    
 
    
    [head addSubview:erji];
    

    
    sanji = [[UILabel alloc]initWithFrame:CGRectMake(577*__kScreenWidth__/750, 546*__kScreenHeight__/1334, 121*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
    sanji.textColor =[UIColor colorWithRed:224/255.0 green:26/255.0 blue:61/255.0 alpha:1];
    
    sanji.textAlignment = NSTextAlignmentCenter;
    
    sanji.font = [UIFont systemFontOfSize:12];
    
    
    [head addSubview:sanji];
    
    
    //我的专属
    
    UILabel *zhuanshu1 = [[UILabel alloc]initWithFrame:CGRectMake(177*__kScreenWidth__/750, 795*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
    
    zhuanshu1.text = @"我的专属邀请码：";
    zhuanshu1.font = [UIFont systemFontOfSize:15];
    [head addSubview:zhuanshu1];
    
    
    //邀请码
    
        if (__kScreenHeight__ == 568) {
            yaoqingma = [[UILabel alloc]initWithFrame:CGRectMake(446*__kScreenWidth__/750,795*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
            
            yaoqingma.font = [UIFont systemFontOfSize:15];
            
            yaoqingma.textColor = [UIColor colorWithRed:247/255.0 green:56/255.0 blue:39/255.0 alpha:1];
            [head addSubview:yaoqingma];

        
    }else if(__kScreenHeight__ >= 667)
    {
        yaoqingma = [[UILabel alloc]initWithFrame:CGRectMake(416*__kScreenWidth__/750,795*__kScreenHeight__/1334, 300*__kScreenWidth__/750, 35*__kScreenHeight__/1334)];
        
        yaoqingma.font = [UIFont systemFontOfSize:15];
        
        yaoqingma.textColor = [UIColor colorWithRed:247/255.0 green:56/255.0 blue:39/255.0 alpha:1];
        [head addSubview:yaoqingma];

    }
    
    //分享给好友
    
    UIButton *fenxiang = [[UIButton alloc]initWithFrame:CGRectMake(227*__kScreenWidth__/750,873*__kScreenHeight__/1334 , 297*__kScreenWidth__/750, 66*__kScreenHeight__/1334)];
//    [fenxiang addTarget:self
//                 action:@selector(showShareView)
//       forControlEvents:UIControlEventTouchUpInside];

    
    
    [fenxiang setImage:[UIImage imageNamed:@"6inviteFriends_13@2x.png"] forState:UIControlStateNormal];
    [head addSubview:fenxiang];
    

    
    
    
    
    
    
    
    
    
    UIImage *img = [UIImage imageNamed:@"6ConneRecord@2x_01.png"];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 64)];
    [im setImage:img];
    [self.view addSubview:im];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    //返回按钮
    UIButton *chehuizhaohuimiam = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334)];
    UIImage *chehui = [UIImage imageNamed:@"6moreCentreSJ@2x.png"];
    [chehuizhaohuimiam setBackgroundImage:chehui forState:UIControlStateNormal];
    [self.view addSubview:chehuizhaohuimiam];
    [chehuizhaohuimiam addTarget:self action:@selector(renmaitouzi:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)renmaitouzi:(id)sender
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

-(void)renmaitouzimo
{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate =self;
    [HUD show:YES];
    
    
    
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
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    
    if (timeExpire >= time) {
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
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    
 NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    [manager POST:@"http://debug.otouzi.com:8012/user/investmentNetwork"
       parameters:@{@"p": page,              // 基本分页
                    @"limit": @"10"          // 记录数，默认 10
                    }
                    success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
                    
                        NSLog(@"%@",responseObject);
                        
                        NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
                        gerenzhongxin = responseObject;
                        
                        
                        
                        
                        
                        NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                        
                        
                        
                        NSMutableArray *yonghuming1= [yonghuming objectForKey:@"list"];
                        
                        
                        for (NSDictionary *dataDic in yonghuming1) {
                            
                            renmaitouzimodel *model1 =[[renmaitouzimodel alloc]initWithDataDic:dataDic];
                            
                            if (freshState == NO) {
                               
                                [self.data removeAllObjects];
                                
                                freshState =YES;
                            }
                            [self.data addObject:model1];
                            self.table.data = self.data;
                            
                        }
                        
                        [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"other"][@"investmentNumber"]forKey:@"chenggongtouzirenshu"];
                        
                        renshu.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"chenggongtouzirenshu"]];
                         yaoqingma.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"yaoqingluanma"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"other"][@"level"][@"1"] forKey:@"yijirenmai"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"other"][@"level"][@"2"] forKey:@"erjirenmai"];
                        
                        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"erjirenmai"]);
                        
                        [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"other"][@"level"][@"3"] forKey:@"sanjirenmai"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:yonghuming[@"other"][@"money"]forKey:@"zhanshizonge"];
                        jiangjin.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"zhanshizonge"];
                        
                        sanji.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"yijirenmai"];
                        
                        NSString * a = [[NSUserDefaults standardUserDefaults]objectForKey:@"erjirenmai"];
                        erji.text = [NSString stringWithFormat:@"%@",a];
                        
                        yiji.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"sanjirenmai"]];
                        
                        jializhanshi.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"zhanshizonge"];

                        
                        //刷新表视图，回到主线程
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.table reloadData];
                            [HUD hide:YES afterDelay:0.45];
                            
                            NSLog(@"############# %@",self.table.data
                                  );
                            //结束下拉刷新
                            [self.table.header endRefreshing];
                            
                            [self.table.footer endRefreshing];
                            pageCont++;
                            
                        });

                        
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

#pragma mark - 分享视图

- (void)createShareView{
    _shareView = [[UIView alloc]init];
    _shareView.frame = CGRectMake(48*kPlusScale, kScreenHeight, kScreenWidth - (48+48)*kPlusScale, (341+18+88)/2);
    _shareView.backgroundColor = [UIColor whiteColor];
    [_lastWindow addSubview:_shareView];
    
    
    //    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    btn.frame = CGRectMake(20, 20, 100, 60);
    //    [btn setTitle:@"点我" forState:UIControlStateNormal];
    //    [btn addTarget:self
    //            action:@selector(buttonAc:)
    //  forControlEvents:UIControlEventTouchUpInside];
    //
    //    [_shareView addSubview:btn];
    //
    NSArray *shareImages = @[
                             @"6moreShareQQ@2x",
                             @"6moreShareKJ@2x",
                             @"6moreShareWB@2x",
                             @"6moreShareWX@2x",
                             @"6moreSharePR@2x",
                             @"6moreShareDX@2x"
                             
                             ];
    NSArray *titles = @[
                        @"QQ",
                        @"QQ空间",
                        @"新浪微博",
                        @"微信",
                        @"微信朋友圈",
                        @"短信"
                        
                        ];
    for (int i = 0; i<2; i++) {
        
        for (int j= 0; j<3; j++) {
            
            
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat  spaceValue = (_shareView.width -100*kWidthScale*2 -(80/2)*3)/2;
            shareButton.frame = CGRectMake(100*kWidthScale+(spaceValue+80/2)*j, 36*kWidthScale+154*kWidthScale*i, 80/2, 80/2);
            
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateNormal];
            [shareButton setImage:[UIImage imageNamed:shareImages[j+3*i] ]forState:UIControlStateSelected];
            
            [shareButton addTarget:self
                            action:@selector(shareAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            shareButton.tag =1000+j+3*i;
            [_shareView addSubview:shareButton];
            
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.frame = CGRectMake(34*kWidthScale+j *((_shareView.width-(34+34)*kWidthScale)/3),130*kWidthScale+ 150*kWidthScale*i, ((_shareView.width-(34+34)*kWidthScale)/3), 22/2);
            titleLabel.text = titles[j+3*i];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:22/2];
            //titleLabel.layer.borderWidth = 1;
            [_shareView addSubview:titleLabel];
            
        }
        
    }
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = CGRectMake(0, _shareView.height - (88+18)*kWidthScale, _shareView.width, 18*kWidthScale);
    bgView.backgroundColor = RGB(163, 163, 163, 1);
    
    [_shareView addSubview:bgView];
    
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, _shareView.height-88*kWidthScale, _shareView.width, 88/2);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self
                     action:@selector(shareCancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:kColorRed];
    [_shareView addSubview:cancleButton];
    
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [_lastWindow insertSubview:_maskView belowSubview:_shareView];
    
    
}

- (void)maskViewAction:(UIControl *)sender{
    _maskView.hidden = YES;
    [self hideShareView];
    
    
    
}
- (void)shareAction:(UIButton*)sender{
    
    switch (sender.tag ) {
        case 1000:
            
            break;
        case 1001:
            
            break;
        case 1002:
            [self sinaWeiboAlertView];
            
            break;
        case 1003:
            ;
            break;
        case 1004:
            ;
            break;
        case 1005:
            [self showMessageView];
        default:
            break;
    }
    
    
}
- (void)shareCancleAction:(UIButton *)sender{
    [self hideShareView];
    
    
    
    
}







//显示尾部视图
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                         _shareView.transform = CGAffineTransformMakeTranslation(0, -(341+18+88)/2);
                         _maskView.hidden = NO;//遮罩显示
                     }];
    
}

//隐藏尾部视图
- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         _shareView.transform = CGAffineTransformIdentity;
                         _maskView.hidden = YES;
                     }];
    
}





#pragma mark - 提示显示是否打开微博alertview

- (void)sinaWeiboAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"\"沃投资\"想要打开\"微博\""
                              delegate:self
                              cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    /*
     
     
     // 初始化一个一个UIAlertController
     // 参数preferredStyle:是IAlertController的样式
     // UIAlertControllerStyleAlert 创建出来相当于UIAlertView
     // UIAlertControllerStyleActionSheet 创建出来相当于 UIActionSheet
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"\"沃投资\"想要打开\"微博\"" preferredStyle:(UIAlertControllerStyleAlert)];
     
     // 创建按钮
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
     [self sinaWeiboShare];
     
     }];
     // 创建按钮
     // 注意取消按钮只能添加一个
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
     // 点击按钮后的方法直接在这里面写
     }];
     
     
     // 添加按钮 将按钮添加到UIAlertController对象上
     [alertController addAction:okAction];
     [alertController addAction:cancelAction];
     
     
     
     // 将UIAlertController模态出来 相当于UIAlertView show 的方法
     [self presentViewController:alertController animated:YES completion:nil];
     
     */
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        [self sinaWeiboShare];
    }
    
    
    
    
}


#pragma mark -  sinaWeibo分享
- (void)sinaWeiboShare{
    
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //使用客户端分享
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:@"沃 touzi "
                                     images:nil
                                        url:[NSURL URLWithString:@"https://api.weibo.com/oauth2/default.html"]
                                      title:@"沃 touzi"
                                       type: SSDKContentTypeAuto  ];
    
    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"分享失败"
                                           message:[NSString stringWithFormat:@"%@", error]
                                           delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"分享已取消"
                                           message:nil
                                           delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
         
     }];
    
    
    
}

#pragma mar - 短信分享

/*
 *短信
 */

- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10010"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [self presentModalViewController:controller animated:YES];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}





@end
