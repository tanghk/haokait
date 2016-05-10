//
//  RedConponViewController.m
//  555
//
//  Created by otouzi on 16/4/13.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "RedConponViewController.h"
#import "UICommons.h"
#import "RFSegmentView.h"
#import "Masonry.h"
#import "DataService.h"
#import "ExprienceModel.h"
#import "CashCouponModel.h"
#import "IncreaseCouponModel.h"
#import "Reachability.h" //网络你状态
#import "AppDelegate.h"

#import "ExchangeConponViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface RedConponViewController (){

    UIButton *_experienceButton;//体验金按钮
    UIButton *_principalButton;//本金卷
    UIButton *_interestRateButton;//加息券
    BOOL isExistenceNetwork;        //判断网络状态
  //  RFSegmentView* segmentView;
    UIButton *_investButton;
    
    NSInteger pageCont;
    BOOL freshState;
 
    MBProgressHUD *HUD;
    
    
    BOOL freshStateCA;
    NSInteger pageContCA;
    
    
    
    BOOL freshStateIN;
    NSInteger pageContIN;
    
    
    
    
    UIImageView *_noCashView;
    UIImageView *_noExpierenceView;
    UIImageView *_noIncreaseView;
    

    
    UIView *segmentView;
    UISegmentedControl  *_segmented;

}

@end

@implementation RedConponViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
    
    pageCont = 1;
    freshState = NO;
    
    pageContCA = 1;
    freshStateCA = NO;
    
    pageContIN = 1;
    freshStateIN = NO;
    
    
    [self creatWithNavGation];
    
    /*
     *判断网络状态
     */
    isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            NSLog(@"正在使用wifi网络");
            break;
    }
    
    if (!isExistenceNetwork){
        
        
        
    }else{
        
       
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(235, 235, 235, 1);
    self.data = [NSMutableArray array];
    self.cashData = [NSMutableArray array];
    self.increaseData = [NSMutableArray array];
     [self requestExprienceData];
    [self custumViews];
    
    
    
    __weak RedConponViewController* weakSelf = self;
    //下拉刷新的头视图
    _exprienceView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageCont = 1;
        freshState = NO;
        [weakSelf requestExprienceData];
        
    }];
    
    
    
    
    _cashCouponView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageContCA = 1;
        freshStateCA = NO;
        
        [weakSelf requestCashCouponData];
        
    }];
    
    
    
    
    _increaseCouponView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageContIN = 1;
        freshStateIN = NO;
        
        [weakSelf requestIncreaseCouponData];
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = kColorWhite;
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = RGB(245, 245, 245, 1);
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"我的红包";
    titleLabel.font = [UIFont systemFontOfSize:16];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(backBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    UIButton *exchangeBtn = [[UIButton alloc]init];
    UIImage *exchangeImage = [UIImage imageNamed:@"redPacketTopRight"];
    [exchangeBtn  setBackgroundImage:exchangeImage forState:UIControlStateNormal];
    [exchangeBtn  setBackgroundImage:exchangeImage forState:UIControlStateHighlighted];
    
    [exchangeBtn  addTarget:self
                     action:@selector(exchangekBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:exchangeBtn];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(navigationgView.mas_right);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(148/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =kColorNaviLine ;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationgView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 创建子视图
- (void)custumViews{
    
//    CGFloat initX           = 0;
//    CGFloat initY           = 64.5;
//    CGFloat viewWidth       = kScreenWidth;
//    CGFloat viewHeight      = 55;
//    
//    
//    segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(initX, initY, viewWidth, viewHeight) items:@[@"体验金",@"本金券",@"加息券"]];
//    segmentView.backgroundColor = RGB(235, 235, 235, 1);
//    segmentView.tintColor       = kColorMain;
//    segmentView.delegate      = self;
//    segmentView.selectedIndex   = 0;
//    segmentView.itemHeight      = 28.f;
//    //        segmentView.leftRightMargin = 50.f;
//    //        segmentView.cornerRadius    = 5.f;
//    segmentView.handlder = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
//        NSLog(@"view:%@ selectedIndex: %ld",view,selectedIndex);
//        
//        
//        
//        if (selectedIndex == 0) {
//            [self requestExprienceData];
//            _exprienceView.hidden = NO;
//            _cashCouponView.hidden = YES;
//            _increaseCouponView.hidden = YES;
//        }else if (selectedIndex == 1){
//            [self requestCashCouponData];//现金券
//            _exprienceView.hidden = YES;
//            _cashCouponView.hidden = NO;
//            _increaseCouponView.hidden = YES;
//            
//        }else if (selectedIndex == 2){
//            [self requestIncreaseCouponData];
//            _exprienceView.hidden = YES;
//            _cashCouponView.hidden = YES;
//            _increaseCouponView.hidden = NO;
//            
//        }
//    };
//    
//    [self.view addSubview:segmentView];
//   
//    
//    
//    
    
    
    segmentView = [[UIView alloc]init];
    
    segmentView.backgroundColor = RGB(235, 235, 235, 1);
    segmentView.frame = CGRectMake(0, 64.5, kScreenWidth, 55);
    
    [self.view addSubview:segmentView];
    
    NSArray *arr=@[@"体验金",@"本金券",@"加息券"];
    
    _segmented=[[UISegmentedControl alloc]initWithItems:arr];
    _segmented.backgroundColor = kColorWhite;
    _segmented.tintColor  = kColorMain;
    
    _segmented.frame=CGRectMake(82*kWidthScale,14,kScreenWidth-2*82*kWidthScale,28);
    
    
    
    [segmentView addSubview:_segmented];
    //设置默认选中的位置
    
    _segmented.selectedSegmentIndex=0;
    
    //给segment控件添加事件
    
    [_segmented addTarget:self action:@selector(segmentView:) forControlEvents:UIControlEventValueChanged];
    
    
    
    

    
    
    
    
    /*
     
     
     UIView *invest = [UIView new];
     invest.backgroundColor = kcolorGrayNew;
     [self.view addSubview:invest];
     
     
     [invest mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left .equalTo(self.view);
     make.right.equalTo(self.view);
     make.bottom.equalTo(self.view);
     make.height.mas_equalTo(150/2);
     }];
     
     
     
     
     UIButton *investBtn = [UIButton new];
     investBtn.backgroundColor = kColorMain;
     investBtn.layer.cornerRadius = 5;
     [investBtn setTitle:@"立即投资" forState:UIControlStateNormal];
     investBtn.titleLabel.font = Font(35/2);
     [investBtn addTarget:self
     action:@selector(investAction:)
     forControlEvents:UIControlEventTouchUpInside];
     
     [invest addSubview:investBtn];
     
     
     [investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left .equalTo(self.view).offset(12);
     make.right.equalTo(self.view).offset(-12);
     make.bottom.equalTo(self.view).offset(-(45/2));
     make.height.mas_equalTo(105*kHeightScale);
     }];
     
     
     
     */
    
    _investButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_investButton setTitle:@"去投资" forState:UIControlStateNormal];
    _investButton.layer.cornerRadius = 5;
    _investButton.titleLabel.font = [UIFont systemFontOfSize:32/2];
    [_investButton addTarget:self
                      action:@selector(investAction:)
            forControlEvents:UIControlEventTouchUpInside];
    _investButton.backgroundColor = kColorMain;
    [self.view addSubview:_investButton];
    
    [_investButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.height.mas_equalTo(53);
        
        
        
        
        
        
    }];
    
    /*
     *体验券
     */
    _exprienceView = [[ExprienceView alloc]initWithFrame:CGRectZero style: UITableViewStylePlain];
    _exprienceView.hidden = NO;
    [self.view addSubview:_exprienceView];
    [_exprienceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_investButton.mas_top).offset(-5);
        
    }];
    
    /*
     *本金券
     */
    _cashCouponView = [[CashCouponView alloc]initWithFrame:CGRectZero style: UITableViewStylePlain];
    _cashCouponView.hidden = YES;
    [self.view addSubview:_cashCouponView];
    [_cashCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_investButton.mas_top).offset(-5);
        
    }];
    
    /*
     *加息券
     */
    _increaseCouponView = [[IncreaseCouponView alloc]initWithFrame:CGRectZero style: UITableViewStylePlain];
    _increaseCouponView.hidden = YES;
    [self.view addSubview:_increaseCouponView];
    [_increaseCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_investButton.mas_top).offset(-5);
        
    }];
    
    
    
}




- (void)segmentView:(RFSegmentView * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex
{
    NSLog(@"current index is %lu",(unsigned long)index);
    
    
}


#pragma mark - 请求网络数据

#pragma mark -请求体验金
- (void)requestExprienceData{
    
    [self  showImageView:@""];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    
    NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page,          // 分页，可选
                                     @"limit": @"8"      // 可选，查询个数，默认 10,
                                     
                                     }];
    NSLog(@"#######%@",params);
    
    
    
    [DataService requestWithURL:@"/ExperienceCoupon"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    NSLog(@"%@",result);
                    
                    
                    NSDictionary *responseDic = result;
                    NSNumber *code = [responseDic objectForKey:@"code"];
                    
                    if ([code isEqualToNumber:@200]) {
                        
                        NSArray *dataArr = [responseDic objectForKey:@"data"];
                        
                        for (NSDictionary *experienceDic in dataArr) {
                            ExprienceModel *model = [[ExprienceModel alloc]initWithDataDic:experienceDic];
                            if (freshState == NO) {
                                
                                [self.data removeAllObjects];
                                
                                freshState = YES;
                            }
                            
                            
                            [self.data addObject:model];
                            _exprienceView.data = self.data;
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [HUD hide:YES afterDelay:0.5];
                            
                            pageCont++;
                            [_exprienceView reloadData];
                            
                            if (self.data.count ==8) {
                                
                                __weak RedConponViewController* weakSelf = self;
                                
                                //上拉加载更多
                                _exprienceView.mj_footer =
                                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                                    
                                    [weakSelf requestExprienceData];
                                    
                                    
                                }];
                                
                            }
                            //结束下拉刷新
                            [_exprienceView.mj_header endRefreshing];
                            [_exprienceView.mj_footer endRefreshing];
                            
                        });
                        
                    }else if ([code isEqualToNumber:@2370]){
                        
                        [HUD hide:YES afterDelay:0.5];
                        
                        
                        if (self.data.count ==0) {
                            
                            [_exprienceView removeFromSuperview];
                            _exprienceView = nil;
                            
                            [self  showImageView:@"redPacketNothing"];
                            
                            
                            
                            
                            
                            
                            
                        }
                        [_exprienceView.mj_header endRefreshing];
                        [_exprienceView.mj_footer endRefreshing];
                        
                        
                        
                        
                    }
                    
                }];
}

#pragma mark - 请求现金红包
- (void)requestCashCouponData{
    [self  showImageView:@""];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    
    
    NSString *page =[NSString stringWithFormat:@"%ld",pageContCA];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page,          // 分页，可选
                                     @"limit": @"8"      // 可选，查询个数，默认 10,
                                     
                                     }];
    NSLog(@"#######%@",params);
    
    
    [DataService requestWithURL:@"/CashCoupon"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    NSLog(@"现金：%@",result);
                    
                    [self  showImageView:@""];
                    
                    
                    NSDictionary *responseDic = result;
                    NSNumber *code = [responseDic objectForKey:@"code"];
                    
                    if ([code isEqualToNumber:@200]) {
                        
                        NSArray *dataArr = [responseDic objectForKey:@"data"];
                        
                        for (NSDictionary *cashCouponDic in dataArr) {
                            CashCouponModel *model = [[CashCouponModel alloc]initWithDataDic:cashCouponDic];
                            
                            if (freshStateCA == NO) {
                                
                                [self.cashData removeAllObjects];
                                
                                freshStateCA = YES;
                            }
                            
                            
                            [self.cashData addObject:model];
                            
                            _cashCouponView.data = self.cashData;
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            pageContCA++;
                            [HUD hide:YES afterDelay:0.5];
                            
                            
                            if (self.cashData.count ==8) {
                                __weak RedConponViewController* weakSelf = self;
                                
                                //上拉加载更多
                                _cashCouponView.mj_footer =
                                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                                    
                                    
                                    [weakSelf requestCashCouponData];
                                    
                                    
                                }];
                                
                            }
                            
                            
                            
                            [_cashCouponView reloadData];
                            //结束下拉刷新
                            [_cashCouponView.mj_header endRefreshing];
                            [_cashCouponView.mj_footer endRefreshing];
                            
                        });
                        
                        
                        
                    }else if ([code isEqualToNumber:@2370]){
                        [HUD hide:YES afterDelay:0.5];
                        
                        
                        if (self.cashData.count ==0) {
                            
                            [_cashCouponView removeFromSuperview];
                            _cashCouponView  =nil;
                            
                            [self showImageView:@"redPacketNothingCapital"];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        [_cashCouponView.mj_header endRefreshing];
                        [_cashCouponView.mj_footer endRefreshing];
                        
                    }
                    
                }];
    
    
    
    
    
    
}
#pragma mark -加息券
- (void)requestIncreaseCouponData{
    
    [self  showImageView:@""];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    
    NSString *page =[NSString stringWithFormat:@"%ld",pageContIN];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page,          // 分页，可选
                                     @"limit": @"8"      // 可选，查询个数，默认 10,
                                     
                                     }];
    NSLog(@"#######%@",params);
    
    
    
    [DataService requestWithURL:@"/IncreaseCoupon"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    NSLog(@"%@",result);
                    
                    
                    
                    NSDictionary *responseDic = result;
                    NSNumber *code = [responseDic objectForKey:@"code"];
                    
                    if ([code isEqualToNumber:@200]) {
                        
                        NSArray *dataArr = [responseDic objectForKey:@"data"];
                        
                        for (NSDictionary *increaseCouponDic in dataArr) {
                            IncreaseCouponModel *model = [[IncreaseCouponModel alloc]initWithDataDic:increaseCouponDic];
                            
                            if (freshStateIN == NO) {
                                
                                [self.increaseData removeAllObjects];
                                
                                freshStateIN = YES;
                            }
                            
                            
                            [self.increaseData addObject:model];
                            _increaseCouponView.data = self.increaseData;
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            pageContIN ++;
                            [HUD hide:YES afterDelay:0.5];
                            
                            [_increaseCouponView reloadData];
                            
                            if (self.increaseData.count ==8) {
                                __weak RedConponViewController* weakSelf = self;
                                //上拉加载更多
                                _increaseCouponView.mj_footer =
                                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                                    
                                    
                                    [weakSelf requestIncreaseCouponData];
                                    
                                    
                                }];
                                
                                
                            }
                            
                            //结束下拉刷新
                            [_increaseCouponView.mj_header endRefreshing];
                            [_increaseCouponView.mj_footer endRefreshing];
                            
                        });
                        
                        
                        
                    }else if ([code isEqualToNumber:@2370]){
                        [HUD hide:YES afterDelay:0.2];
                        if (self.increaseData.count ==0) {
                            [_increaseCouponView removeFromSuperview];
                            _increaseCouponView = nil;
                            
                            [self showImageView:@"redPacketNothingHike"];
                            
                            
                        }
                        
                        //结束下拉刷新
                        [_increaseCouponView.mj_header endRefreshing];
                        [_increaseCouponView.mj_footer endRefreshing];
                        
                    }
                    
                }];
    
    
    
    
}
#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
      [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)exchangekBtnAction:(UIButton *)sender{
    
    ExchangeConponViewController *exchangeConponVC = [[ExchangeConponViewController alloc]init];
    exchangeConponVC.delegate = self;
        exchangeConponVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:exchangeConponVC animated:YES];
    
    
    
}

- (void)changeIndex:(NSUInteger)index{
    
    //segmentView.selectedIndex = index - 1;
    _segmented.selectedSegmentIndex = index - 1;
    [self segmentView:_segmented index:(NSInteger *)(index-1)];

    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//TODO:
- (void)investAction:(UIButton *)sender{
    
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
    
    
    
    
}
-(void)showImageView:(NSString*)imageName{
    
    
    
    [_noIncreaseView removeFromSuperview];
    
    _noIncreaseView  = [[UIImageView alloc]init];
    _noIncreaseView.frame = CGRectMake((kScreenWidth- 0.501*kScreenWidth)/2, 64+110*kHeightScale+342*kHeightScale, 0.501*kScreenWidth, 0.178*kScreenHeight);
    _noIncreaseView.image = [UIImage imageNamed:imageName];
    [self.view insertSubview:_noIncreaseView belowSubview:HUD];
    
    //    [_noIncreaseView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(self.view.mas_centerX);
    //        make.centerY.equalTo(self.view.mas_centerY);
    //        make.height.mas_equalTo(0.178*kScreenHeight);
    //        make.width.mas_equalTo(0.501*kScreenWidth);
    //        
    //        
    //    }];
    
    
    
    
    
    
}


-(void)segmentView:(UISegmentedControl*)sg

{
    
    NSLog(@"%ld",sg.selectedSegmentIndex);;
    
    
    
    if (sg.selectedSegmentIndex == 0) {
        [self requestExprienceData];
        _exprienceView.hidden = NO;
        _cashCouponView.hidden = YES;
        _increaseCouponView.hidden = YES;
    }else if (sg.selectedSegmentIndex == 1){
        [self requestCashCouponData];//现金券
        _exprienceView.hidden = YES;
        _cashCouponView.hidden = NO;
        _increaseCouponView.hidden = YES;
        
    }else if (sg.selectedSegmentIndex == 2){
        [self requestIncreaseCouponData];
        _exprienceView.hidden = YES;
        _cashCouponView.hidden = YES;
        _increaseCouponView.hidden = NO;
        
    }
    
    
}

-(void)segmentView:(UISegmentedControl*)sg index:(NSInteger *)index

{
    
   
    
    
    
    if (sg.selectedSegmentIndex == 0) {
        pageCont =1;
        freshState =NO;
        [self requestExprienceData];
        _exprienceView.hidden = NO;
        _cashCouponView.hidden = YES;
        _increaseCouponView.hidden = YES;
    }else if (sg.selectedSegmentIndex == 1){
        
        freshStateCA = NO;
        pageContCA=1;
        

        [self requestCashCouponData];//现金券
        _exprienceView.hidden = YES;
        _cashCouponView.hidden = NO;
        _increaseCouponView.hidden = YES;
        
    }else if (sg.selectedSegmentIndex == 2){
         pageContIN = 1;
        freshStateIN =NO;
        
        [self requestIncreaseCouponData];
       
        _exprienceView.hidden = YES;
        _cashCouponView.hidden = YES;
        _increaseCouponView.hidden = NO;
        
    }
    
    
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
