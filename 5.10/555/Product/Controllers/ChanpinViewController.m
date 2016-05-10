 //
//  ChanpinViewController.m
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
//#import "UIViewExt.h"
#import "ChanpinViewController.h"

#import "AFNetworking.h"      //网络请求
#import "BestUserTableview.h" //优质散标表视图
#import "DataService.h"       //封装网络请求
#import "FilterModel.h"       //筛选model
#import "ListModel.h"         //产品列表
#import "MJRefresh.h"
#import "Reachability.h"      //判断当前网络
#import "SelectedModel.h"     // 内容model
#import "TransferTableView.h" //转让专区表视图
#import "UICommons.h"
#import "UIViewExt.h"

#import "Reachability.h" //网络你状态
#import "CLLockVC.h" //手势密码
#import "UIImageView+WebCache.h"
#import "BannerViewController.h"
#import "Masonry.h"
#import "NetworkState.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UITabBar+badge.h"
//#import "ChooseTypeViewController.h"//筛选视图控制器
@interface ChanpinViewController () {

    NSString *repayMentString; //还款方式请求
    NSString *revenueString;   //年华收益率请求
    NSString *deadlineString;  //投资期限请求
    NSString *riskString;     //风险请求
    
    DataService *_manager;
    
#pragma mark - 视图创建
    UIColor* textColorB;
    UIColor* textColorR;
    
    
    
    
    
    
    NSString* _activityValue;
    NSString* _noticeValue;
    NSString * _lastActivitySandbox;//沙河
    NSString * _lastNoticeSandbox;//沙河
    
    
    BOOL noticeState; // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBtn"];
    BOOL   activitystate;  //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionButton"];
    
    NSString * _clickNoticeDate; //[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
    NSString * _clickActionDate;  // [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
    
    UIImageView *_bgView ;


}
@property (nonatomic, strong) BestUserTableview* bestUserTableView; //优质散标表视图
@end

@implementation ChanpinViewController
static NSString* RepayIndentifier = @"Repay_Cell"; //还款方式
static NSString* AnnualYieldIndentifier = @"AnnualYield_Cell"; //年化收益

//视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
 
    
    
    
    pageCont = 1;
    freshState = NO;
    
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestFRESH) name:@"investSucess" object:nil];
    

    NSString *investSucess = [[NSUserDefaults standardUserDefaults]objectForKey:@"investSucess"];
    NSLog(@"invest%@",investSucess);
    if ([investSucess intValue] == 1) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"investSucess"];
        
        
    }else{
        
        
    }

   
    
    
    [self requestUserInformationData];
    
}

-(void)dealloc{

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"investSucess" object:nil];

}
- (void)viewDidLoad
{
  [self creatWithNavGation];//导航栏
   

    
     self.view.backgroundColor = kColorWhite;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    textColorB = RGB(212, 218, 255, 1);
    textColorR = RGB(211, 74, 89, 1);
    [super viewDidLoad];
        // baseUrl =  @"http://192.168.1.14:8013";
    baseUrl = @"http://debug.otouzi.com:8012";
    repayMentString = @"0";
    revenueString = @"0";
    deadlineString = @"0";
    riskString = @"0";
   
   

   [self requestMoreData];
      //[self creatWithNavGation];
    [self loadFilterData]; //筛选数据
    
  
    [self createBestUserTableView]; //优质散标用户视图
      [self createMaskView]; //创建遮罩视图
    
    [self createFooterView];//筛选视图

    __weak ChanpinViewController* weakSelf = self;
 
    
    //下拉刷新的头视图
    self.bestUserTableView.header =
        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //[self.data removeObjectsInArray:
                      //     self.data]; //下拉刷新将原有数据移除｜｜重新加载数据
            //[weakSelf requestData];
        
            if ([_fiterType isEqualToString:@"1"]) {
                fiterCont =1;
                fiterFreshState = NO;
                 [weakSelf requesFilterData];//请求筛选数据

            }else{
            
            pageCont = 1;
            freshState = NO;
            
         
          
            [weakSelf requestMoreData];
           
            }
                 }];

    self.data = [NSMutableArray array];
    self.selectedRepayData = [[NSMutableArray alloc] initWithCapacity:0];
    self.selectedRevenueData = [[NSMutableArray alloc] initWithCapacity:0];
    self.selectedDeadlineData = [[NSMutableArray alloc] initWithCapacity:0];
    self.selectedRiskData = [[NSMutableArray alloc]initWithCapacity:0];
      //[self creatWithNavGation];
    
    
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

    

 

}

- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
   
    _bgView = [UIImageView new];
    [_bgView setImage:[UIImage imageNamed:@"6myMess6"]];
    
    [self.view addSubview:_bgView];
    
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(self.view);
        make.right.equalTo( self.view);
        make.bottom.equalTo(self.view).offset(kTabBarHeight);
    }];

    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"产品列表";
    titleLabel.font = [UIFont systemFontOfSize:16];
    //titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(navigationgView.width-24/2-128/2, 30, 128/2, 25);
    [rightBtn setTitle:@"列表筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kColorMain forState:UIControlStateNormal];
    [rightBtn setAdjustsImageWhenHighlighted:NO];
    rightBtn.titleLabel.font = Font(15);
   // rightBtn.layer.borderWidth = 1;

    //[rightBtn setImage:[UIImage imageNamed:@"uCFilter"] forState:UIControlStateNormal];
    [rightBtn addTarget:self
                 action:@selector(rightItemButtonAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:rightBtn];
    
    
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
- (void)viewDidDisappear:(BOOL)animated{



}
//视图消失的时候
- (void)viewDidAppear:(BOOL)animated
{
 
    
    
}

#pragma mark - 加载数据




//加载更多数据
- (void)requestMoreData
{
    
 
    
    NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page, // 分页，可选
                                     @"limit" : @"10",
                                     @"code" : @"0000"
                                     }];
    NSLog(@"#######请求更多数据%@",params);
    [DataService requestWithURL:@"/product/list"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    
                    [self loadMoreListData:result];
                    
                    pageCont ++;
                }];
    
    if(!isExistenceNetwork){
    
    
    
    
        [self.bestUserTableView.mj_header endRefreshing];
        [self.bestUserTableView.mj_footer endRefreshing];
    }
  

    
 
}

-(void)loadMoreListData:(id)result{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    NSDictionary* responseDic = result;
    
    NSLog(@"产品列表：%@",responseDic);
    NSNumber* codeNumber = [responseDic objectForKey:@"code"];
    if ([codeNumber isEqualToNumber:@2343]||[codeNumber isEqualToNumber:@2344]) {
        NSLog(@"已没有可投资的产品。");
        
        
        [HUD hide:YES afterDelay:0.5];
        [self.bestUserTableView.mj_footer endRefreshingWithNoMoreData];
        //[self.bestUserTableView.footer endRefreshingWithNoMoreData];
    }
    else {
        if ([[[responseDic objectForKey:@"data"] class]
             isSubclassOfClass:[NSDictionary class]]) {
            
            
            NSDictionary* listDic = [responseDic objectForKey:@"data"];
          

                    NSArray* array = [listDic objectForKey:@"list"];
            for (NSDictionary* dataDic in array) {
                ListModel* model = [[ListModel alloc] initWithDataDic:dataDic];
                if (freshState == NO) {
                    
                    [self.data removeAllObjects];
                    
                    freshState = YES;
                }
                [self.data addObject:model];
                self.bestUserTableView.data = self.data;
                
            }
            
            
            //刷新表视图，回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.bestUserTableView reloadData];
                __weak ChanpinViewController* weakSelf = self;
                
                //上拉加载更多
                self.bestUserTableView.mj_footer =
                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    
                    if ([_fiterType isEqualToString:@"1"]) {
                        hasData = YES;
                        
                        [weakSelf requesFilterData];//请求筛选数据
                        
                    }else{
                        
                        
                        [weakSelf requestMoreData];
                        
                    }
                }];
                
          [HUD hide:YES afterDelay:0.5];
                
                [self.bestUserTableView.mj_header endRefreshing];
                if (self.data.count ==0  ||self.data.count<10) {
                    [self.bestUserTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.bestUserTableView.mj_footer endRefreshing];
                    
                    
                    
                }
            });
            
            
            
        }
        else {
            NSLog(@"结果为%@", [result objectForKey:@"data"]);
        }
    }
    
    
    
}




#pragma mark -加载筛选数据
//加载筛选数据
- (void)loadFilterData
{

    [DataService requestWithURL:@"/product/list/filter"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {

                    [self loadFilterDataDidFinish:result];

                }];
}

- (void)loadFilterDataDidFinish:(id)result
{
    NSDictionary* responseDic = result;

    NSArray* filterArr = [responseDic objectForKey:@"data"];

    // NSLog(@"filterArr= %@",filterArr);

    FilterModel* riskModel = [[FilterModel alloc]initWithDataDic:filterArr[0]];//
    FilterModel* repayModel = [[FilterModel alloc] initWithDataDic:filterArr[1]];
    FilterModel* revenueModel = [[FilterModel alloc] initWithDataDic:filterArr[2]];
    FilterModel* deadlineModel =[[FilterModel alloc] initWithDataDic:filterArr[3]];
#pragma mark - 请求筛选数据
       _riskLabel.text = riskModel.name;
       _repaymentLabel.text = repayModel.name;
       _revenueLabel.text =revenueModel.name;
    _deadlineLabel.text = deadlineModel.name;

    
    
#pragma mark -信用等级
    NSMutableArray *selectedRiskArr = [NSMutableArray array];
    selectedRiskArr = riskModel.selected;
    for (NSDictionary *riskSelectedDic in selectedRiskArr) {
        SelectedModel *riskSelectedModel = [[SelectedModel alloc]initWithDataDic:riskSelectedDic];
        [self.selectedRiskData addObject:riskSelectedModel];
        NSLog(@"selectedRiskData------%@",self.selectedRiskData);
     
        
        

    }
    
#pragma mark -还款方式
    NSMutableArray* selectedRepaymentArr = [NSMutableArray array];
    selectedRepaymentArr = repayModel.selected;

    for (NSDictionary* repaySelectedDic in selectedRepaymentArr) {
        SelectedModel* repaySelectedModel =
            [[SelectedModel alloc] initWithDataDic:repaySelectedDic];

        [self.selectedRepayData addObject:repaySelectedModel];
        
        
    
    }
#pragma mark -年化收益率
    //年化收益率
    NSMutableArray* selectedRevenueArr = [NSMutableArray array];
    selectedRevenueArr = revenueModel.selected;
    for (NSDictionary* revenueSelectedDic in selectedRevenueArr) {
        SelectedModel* revenueSelectedModel =
            [[SelectedModel alloc] initWithDataDic:revenueSelectedDic

        ];

        [self.selectedRevenueData addObject:revenueSelectedModel];
#pragma mark -投资期限
        //投资期限
    }
    
    NSMutableArray* selectedDeadlineArr = [NSMutableArray array];
    selectedDeadlineArr = deadlineModel.selected;
        for (NSDictionary* deadlineSelectedDic in selectedDeadlineArr) {
            SelectedModel* deadlineSelectedModel =
                [[SelectedModel alloc] initWithDataDic:deadlineSelectedDic

            ];

              [self.selectedDeadlineData addObject:deadlineSelectedModel];
            NSLog(@"投资期限%@",self.selectedDeadlineData);
        }
    
//  
    if (iphone5x_4_0) {
    
        /*
         *风险级别
         */
        
        
        CGFloat e = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        
        for (int n = 0; n<self.selectedRiskData.count; n++) {
            _riskButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRiskData[n];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36/3 andHeight:77/3];
            if (n==0) {
                
                _riskButton.frame = CGRectMake((44/3)+ e, (247) * kPlusHeightScale, 188/3, 77/3);
            }
            else {
                
                _riskButton.frame = CGRectMake((33 / 3) + e, (247) * kPlusHeightScale,
                                               strWidth + 44/3, 77/3);
            }
            
            [_riskButton setTitle:selectedModel.name forState:UIControlStateNormal];
            [_riskButton setTitleColor:textColorB forState:UIControlStateNormal];
            [_riskButton setTitleColor:textColorR forState:UIControlStateSelected];
            _riskButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _riskButton.layer.borderWidth = 1;
            _riskButton.layer.cornerRadius = 3;
            _riskButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_riskButton addTarget:self
                            action:@selector(riskButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            _riskButton.tag = 4000 + n;
            
            e = _riskButton.frame.size.width + _riskButton.frame.origin.x;
            
            if (n==0) {
                [self riskButtonAction:_riskButton];
                
            }
            [_footerView addSubview:_riskButton];
            
        }
        
        
        /*
         *还款方式
         */
        CGFloat w = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        for (int i = 0; i < self.selectedRepayData.count; i++) {
            _repayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRepayData[i];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36 / 3
                                          andHeight:77 / 3];
            if (strWidth < 188 / 3) {
                _repayButton.frame = CGRectMake((44 / 3) + w, (247 - 32+326) * kPlusHeightScale, 188/3, 77/3);
            }
            else {
                
                _repayButton.frame = CGRectMake((33 / 3) + w, (247 - 32+326) * kPlusHeightScale,
                                                strWidth + 44/3, 77/3);
            }
            
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if ((44 / 3) + w + strWidth + 44 / 3 > kScreenWidth) {
                
                _repayButton.frame = CGRectMake((44 + 188 + 33) / 3, (247 + 77+326) * kPlusHeightScale,
                                                strWidth + 44 / 3, 77 / 3); //重设button的frame
            }
            
            [_repayButton setTitle:selectedModel.name forState:UIControlStateNormal];
            [_repayButton setTitleColor:textColorB forState:UIControlStateNormal];
            [_repayButton setTitleColor:textColorR forState:UIControlStateSelected];
            _repayButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _repayButton.layer.borderWidth = 1;
            _repayButton.layer.cornerRadius = 3;
            _repayButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_repayButton addTarget:self
                             action:@selector(repayButtonAction:)
                   forControlEvents:UIControlEventTouchUpInside];
            _repayButton.tag = 1000 + i;
            
            w = _repayButton.frame.size.width + _repayButton.frame.origin.x;
            if (i == 0) {
                
                [self repayButtonAction:_repayButton];
            }
            
            [_footerView addSubview:_repayButton];
        }
        
        
        
        /*
         *年华收益
         */
        CGFloat m = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        for (int i = 0; i < self.selectedRevenueData.count; i++) {
            
            _revenueButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRevenueData[i];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36 / 3
                                          andHeight:77 / 3];
            if (strWidth < 100 / 3) {
                _revenueButton.frame = CGRectMake((44 / 3) + m, (572 - 32+326) * kPlusHeightScale+20, 188 / 3, 77 / 3);
            }
            else {
                
                _revenueButton.frame = CGRectMake((33 / 3) + m, (572 - 32+326) * kPlusHeightScale+20, 266 / 3, 77 / 3);
            }
            
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if ((44 / 3) + m + 266 * kPlusScale + 44 / 3 > kScreenWidth) {
                
                _revenueButton.frame = CGRectMake((44 + 188 + 33) / 3, (572 + 77+326) * kPlusHeightScale+20, 266 / 3,
                                                  77 / 3); //重设button的frame
            }
            
            UIColor* textColor = RGB(212, 218, 255, 1);
            [_revenueButton setTitle:selectedModel.name
                            forState:UIControlStateNormal];
            [_revenueButton setTitleColor:textColor forState:UIControlStateNormal];
            [_revenueButton setTitleColor:textColorR forState:UIControlStateSelected];
            _revenueButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _revenueButton.layer.borderWidth = 1;
            _revenueButton.layer.cornerRadius = 3;
            _revenueButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_revenueButton addTarget:self
                               action:@selector(revenueButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
            _revenueButton.tag = 2000 + i;
            
            m = _revenueButton.frame.size.width + _revenueButton.frame.origin.x;
            
            [_footerView addSubview:_revenueButton];
            
            if (i == 0) {
                
                [self revenueButtonAction:_revenueButton];
            }
        }
        
        /*
         *投资期限
         */
        
        UILabel* lineLabel = [[UILabel alloc] init];
        lineLabel.frame = CGRectMake(0, (898 + 70 /2+326) * kPlusHeightScale+30, kScreenWidth, 8);
        lineLabel.backgroundColor = RGB(71, 69, 114, 1);
        // lineLabel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        [_footerView addSubview:lineLabel];
        
        CGFloat f = (kScreenWidth - ((104 * 2) * kPlusScale) - ((_selectedDeadlineData.count) * (68 / 3))) / (_selectedDeadlineData.count-1);
        NSLog(@"%ld",_selectedDeadlineData.count);
        for (int i = 0; i < self.selectedDeadlineData.count; i++) {
            
            UIButton* deadlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedDeadlineData[i];
            
            deadlineButton.frame = CGRectMake(104 * kPlusScale + ((68 / 3) + f) * i,
                                              (898+326) * kPlusHeightScale+30, 68 / 3, 70 / 3);
            deadlineButton.tag = 3000 + i;
            [deadlineButton setImage:[UIImage imageNamed:@"screen@3x_41"]
                            forState:UIControlStateNormal];
            [deadlineButton setImage:[UIImage imageNamed:@"screen@3x_39"]
                            forState:UIControlStateSelected];
            
            [deadlineButton addTarget:self
                               action:@selector(deadlineButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [self deadlineButtonAction:deadlineButton];
            }
            
            [_footerView addSubview:deadlineButton];
            
            UILabel* deadlineTimeLabel = [[UILabel alloc] init];
            deadlineTimeLabel.font = [UIFont systemFontOfSize:36 / 3];
            deadlineTimeLabel.frame = CGRectMake(0 + (kScreenWidth / (_selectedDeadlineData.count)) * i, (1017 +326)* kPlusScale+30,
                                                 kScreenWidth / (_selectedDeadlineData.count), 36 / 2);
            deadlineTimeLabel.text = selectedModel.name;
            deadlineTimeLabel.textAlignment = NSTextAlignmentCenter;
            UIColor* deadlineColor = RGB(211, 218, 255, 1);
            deadlineTimeLabel.textColor = deadlineColor;
            deadlineTimeLabel.tag = 5000 + i;
            //                SingleObject *singObject = [SingleObject
            //                sharedObject];
            //                [singObject.array addObject:_deadlineTimeLabel];
            [_footerView addSubview:deadlineTimeLabel];
        }
    }else{
    
        /*
         *风险级别
         */
        
        
        CGFloat e = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        
        for (int n = 0; n<self.selectedRiskData.count; n++) {
            _riskButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRiskData[n];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36/3 andHeight:77/3];
            if (n==0) {
                
                _riskButton.frame = CGRectMake((44/3)+ e, (247) * kPlusHeightScale, 188/3, 77/3);
            }
            else {
                
                _riskButton.frame = CGRectMake((33 / 3) + e, (247) * kPlusHeightScale,
                                               strWidth + 44/3, 77/3);
            }
            
            [_riskButton setTitle:selectedModel.name forState:UIControlStateNormal];
            [_riskButton setTitleColor:textColorB forState:UIControlStateNormal];
            [_riskButton setTitleColor:textColorR forState:UIControlStateSelected];
            _riskButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _riskButton.layer.borderWidth = 1;
            _riskButton.layer.cornerRadius = 3;
            _riskButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_riskButton addTarget:self
                            action:@selector(riskButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            _riskButton.tag = 4000 + n;
            
            e = _riskButton.frame.size.width + _riskButton.frame.origin.x;
            
            if (n==0) {
                [self riskButtonAction:_riskButton];
                
            }
            [_footerView addSubview:_riskButton];
            
        }
        
        
        /*
         *还款方式
         */
        CGFloat w = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        for (int i = 0; i < self.selectedRepayData.count; i++) {
            _repayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRepayData[i];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36 / 3
                                          andHeight:77 / 3];
            if (strWidth < 188 / 3) {
                _repayButton.frame = CGRectMake((44 / 3) + w, (247 - 32+326) * kPlusHeightScale, 188/3, 77/3);
            }
            else {
                
                _repayButton.frame = CGRectMake((33 / 3) + w, (247 - 32+326) * kPlusHeightScale,
                                                strWidth + 44/3, 77/3);
            }
            
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if ((44 / 3) + w + strWidth + 44 / 3 > kScreenWidth) {
                
                _repayButton.frame = CGRectMake((44 + 188 + 33) / 3, (247 + 77+326) * kPlusHeightScale,
                                                strWidth + 44 / 3, 77 / 3); //重设button的frame
            }
            
            [_repayButton setTitle:selectedModel.name forState:UIControlStateNormal];
            [_repayButton setTitleColor:textColorB forState:UIControlStateNormal];
            [_repayButton setTitleColor:textColorR forState:UIControlStateSelected];
            _repayButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _repayButton.layer.borderWidth = 1;
            _repayButton.layer.cornerRadius = 3;
            _repayButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_repayButton addTarget:self
                             action:@selector(repayButtonAction:)
                   forControlEvents:UIControlEventTouchUpInside];
            _repayButton.tag = 1000 + i;
            
            w = _repayButton.frame.size.width + _repayButton.frame.origin.x;
            if (i == 0) {
                
                [self repayButtonAction:_repayButton];
            }
            
            [_footerView addSubview:_repayButton];
        }
        
        
        
        /*
         *年华收益
         */
        CGFloat m = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        for (int i = 0; i < self.selectedRevenueData.count; i++) {
            
            _revenueButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedRevenueData[i];
            CGFloat strWidth = [self widthForString:selectedModel.name
                                           fontSize:36 / 3
                                          andHeight:77 / 3];
            if (strWidth < 100 / 3) {
                _revenueButton.frame = CGRectMake((44 / 3) + m, (572 - 32+326) * kPlusHeightScale, 188 / 3, 77 / 3);
            }
            else {
                
                _revenueButton.frame = CGRectMake((33 / 3) + m, (572 - 32+326) * kPlusHeightScale, 266 / 3, 77 / 3);
            }
            
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if ((44 / 3) + m + 266 * kPlusScale + 44 / 3 > kScreenWidth) {
                
                _revenueButton.frame = CGRectMake((44 + 188 + 33) / 3, (572 + 77+326) * kPlusHeightScale, 266 / 3,
                                                  77 / 3); //重设button的frame
            }
            
            UIColor* textColor = RGB(212, 218, 255, 1);
            [_revenueButton setTitle:selectedModel.name
                            forState:UIControlStateNormal];
            [_revenueButton setTitleColor:textColor forState:UIControlStateNormal];
            [_revenueButton setTitleColor:textColorR forState:UIControlStateSelected];
            _revenueButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3];
            _revenueButton.layer.borderWidth = 1;
            _revenueButton.layer.cornerRadius = 3;
            _revenueButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [_revenueButton addTarget:self
                               action:@selector(revenueButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
            _revenueButton.tag = 2000 + i;
            
            m = _revenueButton.frame.size.width + _revenueButton.frame.origin.x;
            
            [_footerView addSubview:_revenueButton];
            
            if (i == 0) {
                
                [self revenueButtonAction:_revenueButton];
            }
        }
        
        /*
         *投资期限
         */
        
        UILabel* lineLabel = [[UILabel alloc] init];
        lineLabel.frame = CGRectMake(0, (898 + 70 /2+326) * kPlusHeightScale, kScreenWidth, 8);
        lineLabel.backgroundColor = RGB(71, 69, 114, 1);
        // lineLabel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        [_footerView addSubview:lineLabel];
        
        CGFloat f = (kScreenWidth - ((104 * 2) * kPlusScale) - ((_selectedDeadlineData.count) * (68 / 3))) / (_selectedDeadlineData.count-1);
        NSLog(@"%ld",_selectedDeadlineData.count);
        for (int i = 0; i < self.selectedDeadlineData.count; i++) {
            
            UIButton* deadlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SelectedModel* selectedModel = [[SelectedModel alloc] init];
            
            selectedModel = self.selectedDeadlineData[i];
            
            deadlineButton.frame = CGRectMake(104 * kPlusScale + ((68 / 3) + f) * i,
                                              (898+326) * kPlusHeightScale, 68 / 3, 70 / 3);
            deadlineButton.tag = 3000 + i;
            [deadlineButton setImage:[UIImage imageNamed:@"screen@3x_41"]
                            forState:UIControlStateNormal];
            [deadlineButton setImage:[UIImage imageNamed:@"screen@3x_39"]
                            forState:UIControlStateSelected];
            
            [deadlineButton addTarget:self
                               action:@selector(deadlineButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [self deadlineButtonAction:deadlineButton];
            }
            
            [_footerView addSubview:deadlineButton];
            
            UILabel* deadlineTimeLabel = [[UILabel alloc] init];
            deadlineTimeLabel.font = [UIFont systemFontOfSize:36 / 3];
            deadlineTimeLabel.frame = CGRectMake(0 + (kScreenWidth / (_selectedDeadlineData.count)) * i, (1017 +326)* kPlusScale,
                                                 kScreenWidth / (_selectedDeadlineData.count), 36 / 2);
            deadlineTimeLabel.text = selectedModel.name;
            deadlineTimeLabel.textAlignment = NSTextAlignmentCenter;
            UIColor* deadlineColor = RGB(211, 218, 255, 1);
            deadlineTimeLabel.textColor = deadlineColor;
            deadlineTimeLabel.tag = 5000 + i;
            //                SingleObject *singObject = [SingleObject
            //                sharedObject];
            //                [singObject.array addObject:_deadlineTimeLabel];
            [_footerView addSubview:deadlineTimeLabel];

        }
   }
//  
//      }

    
    
    



    //刷新表视图，回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{

                   });
}



#pragma mark - 筛选视图

-(void)createFooterView{

    if (iphone5x_4_0) {
        //筛选视图
        _footerView = [[UIView alloc]
                       initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,
                                                (kScreenHeight - kNavigationBarHeight - (685* kPlusScale)+326* kPlusScale)+30)];
        //[self.view  addSubview:_footerView];
        _footerView.backgroundColor = RGB(35, 34, 57, 1);
        
        _lastWindow = [UIApplication sharedApplication].windows.lastObject;
        // NSLog(@"%@", [UIApplication sharedApplication].windows);
        [_lastWindow addSubview:_footerView];
        
        UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.frame = CGRectMake(kScreenWidth - 88/3, 0, 88/3, 88/3);
        
        [closeButton setBackgroundImage:[UIImage imageNamed:@"6screen_03"]
                               forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(closeAction:)
              forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:closeButton];
        
        
        
#pragma mark--信用等级
        _riskLabel = [[UILabel alloc]init];
        _riskLabel.frame = CGRectMake(44/3, 100*kPlusScale, 262/3, 84/3);
        //_riskLabel.text = riskModel.name;
        _riskLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //_repaymentLabel.layer.borderWidth = 1;
        
        _riskLabel.layer.cornerRadius = 84 / 3 / 2;
        _riskLabel.backgroundColor = RGB(71, 69, 114, 1);
        _riskLabel.textAlignment = NSTextAlignmentCenter;
        _riskLabel.textColor = [UIColor whiteColor];
        _riskLabel.clipsToBounds = YES;
        [_footerView addSubview:_riskLabel];
        
        //画线
        UIImageView* riskImageView =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:riskImageView];
        
        UIGraphicsBeginImageContext(riskImageView.frame.size);
        [riskImageView.image drawInRect:CGRectMake(0, 0, riskImageView.frame.size.width,
                                                   riskImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (141) * kPlusScale); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (141) * kPlusScale); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        riskImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--还款方式
        //还款方式label
        _repaymentLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(44/3, (100+326) * kPlusScale-10, 262/3, 84/3)];
        
        _repaymentLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //_repaymentLabel.layer.borderWidth = 1;
        
        _repaymentLabel.layer.cornerRadius = 84 / 3 / 2;
        _repaymentLabel.backgroundColor = RGB(71, 69, 114, 1);
        _repaymentLabel.textAlignment = NSTextAlignmentCenter;
        _repaymentLabel.textColor = [UIColor whiteColor];
        _repaymentLabel.clipsToBounds = YES;
        [_footerView addSubview:_repaymentLabel];
        
        //分割线
        
        UIImageView* imageView =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView];
        
        UIGraphicsBeginImageContext(imageView.frame.size);
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width,
                                               imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (141+326) * kPlusScale-10); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (141+326) * kPlusScale-10); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--年化收益率
        // 年化收益率label
        _revenueLabel = [[UILabel alloc]
                         initWithFrame:CGRectMake(44 / 3, (426+326) * kPlusScale+10, 262 / 3, 84 / 3)];
        
        _revenueLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //    _revenueLabel.layer.borderWidth = 1;
        _revenueLabel.layer.cornerRadius = 84 / 3 / 2;
        _revenueLabel.backgroundColor = RGB(71, 69, 114, 1);
        _revenueLabel.textAlignment = NSTextAlignmentCenter;
        _revenueLabel.textColor = [UIColor whiteColor];
        _revenueLabel.clipsToBounds = YES;
        
        [_footerView addSubview:_revenueLabel];
        
        //画线
        UIImageView* imageView1 =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView1];
        
        UIGraphicsBeginImageContext(imageView1.frame.size);
        [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width,
                                                imageView1.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44)/3,
                             (468+326) * kPlusScale+10); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (468+326) * kPlusScale+10); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--投资期限
        
        // 投资期限label
        _deadlineLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(44 * kPlusScale,
                                                   (572 + 77 + 100+326) * kPlusScale+30, 262 / 3,
                                                   84 / 3)];
        _deadlineLabel.text = @"投资期限";
        _deadlineLabel.font = [UIFont boldSystemFontOfSize:36 / 3];
        //  _deadlineLabel.layer.borderWidth = 1;
        _deadlineLabel.layer.cornerRadius = 84 / 3 / 2;
        _deadlineLabel.backgroundColor = RGB(71, 69, 114, 1);
        _deadlineLabel.textAlignment = NSTextAlignmentCenter;
        _deadlineLabel.textColor = [UIColor whiteColor];
        _deadlineLabel.clipsToBounds = YES;
        
        [_footerView addSubview:_deadlineLabel];
        
        //画线
        UIImageView* imageView2 =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView2];
        
        UIGraphicsBeginImageContext(imageView2.frame.size);
        [imageView2.image drawInRect:CGRectMake(0, 0, imageView2.frame.size.width,
                                                imageView2.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (794+326) * kPlusScale+30); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (794+326) * kPlusScale+30); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView2.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        //确认按钮
        UIButton* okButton = [UIButton buttonWithType:UIButtonTypeSystem];
        okButton.frame = CGRectMake(0, _footerView.height - 146 * kPlusScale,
                                    kScreenWidth, 146 * kPlusScale);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
        okButton.backgroundColor = RGB(211, 74, 89, 1);
        
        [okButton addTarget:self
                     action:@selector(okButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_footerView addSubview:okButton];
        
        _maskView = [[UIControl alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        //根据RGB设置颜色
        //[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#>
        //blue:<#(CGFloat)#>
        // alpha:<#(CGFloat)#>]
        
        //根据灰度设置颜色
        //灰度，0为纯黑，1为纯白
        _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
        _maskView.hidden = YES;
        [_maskView addTarget:self
                      action:@selector(maskViewAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        //在某个子视图上面插入一个视图
        //[self insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
        
        //在某个子视图下面插入一个视图
        _lastWindow = [UIApplication sharedApplication].windows.lastObject;
        
        [_lastWindow insertSubview:_maskView belowSubview:_footerView];
        
        //根据下标插入
        //[self insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>];
        
        // NSLog(@"%@", _footerView.subviews);
        
        

    }else{
    
        //筛选视图
        _footerView = [[UIView alloc]
                       initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,
                                                (kScreenHeight - kNavigationBarHeight - (685* kPlusScale)+326* kPlusScale))];
        //[self.view  addSubview:_footerView];
        _footerView.backgroundColor = RGB(35, 34, 57, 1);
        
        _lastWindow = [UIApplication sharedApplication].windows.lastObject;
        // NSLog(@"%@", [UIApplication sharedApplication].windows);
        [_lastWindow addSubview:_footerView];
        
        UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.frame = CGRectMake(kScreenWidth - 88/3, 0, 88/3, 88/3);
        
        [closeButton setBackgroundImage:[UIImage imageNamed:@"6screen_03"]
                               forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(closeAction:)
              forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:closeButton];
        
        
        
#pragma mark--信用等级
        _riskLabel = [[UILabel alloc]init];
        _riskLabel.frame = CGRectMake(44/3, 100*kPlusScale, 262/3, 84/3);
        //_riskLabel.text = riskModel.name;
        _riskLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //_repaymentLabel.layer.borderWidth = 1;
        
        _riskLabel.layer.cornerRadius = 84 / 3 / 2;
        _riskLabel.backgroundColor = RGB(71, 69, 114, 1);
        _riskLabel.textAlignment = NSTextAlignmentCenter;
        _riskLabel.textColor = [UIColor whiteColor];
        _riskLabel.clipsToBounds = YES;
        [_footerView addSubview:_riskLabel];
        
        //画线
        UIImageView* riskImageView =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:riskImageView];
        
        UIGraphicsBeginImageContext(riskImageView.frame.size);
        [riskImageView.image drawInRect:CGRectMake(0, 0, riskImageView.frame.size.width,
                                                   riskImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (141) * kPlusScale); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (141) * kPlusScale); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        riskImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--还款方式
        //还款方式label
        _repaymentLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(44/3, (100+326) * kPlusScale, 262/3, 84/3)];
        
        _repaymentLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //_repaymentLabel.layer.borderWidth = 1;
        
        _repaymentLabel.layer.cornerRadius = 84 / 3 / 2;
        _repaymentLabel.backgroundColor = RGB(71, 69, 114, 1);
        _repaymentLabel.textAlignment = NSTextAlignmentCenter;
        _repaymentLabel.textColor = [UIColor whiteColor];
        _repaymentLabel.clipsToBounds = YES;
        [_footerView addSubview:_repaymentLabel];
        
        //分割线
        
        UIImageView* imageView =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView];
        
        UIGraphicsBeginImageContext(imageView.frame.size);
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width,
                                               imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (141+326) * kPlusScale); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (141+326) * kPlusScale); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--年化收益率
        // 年化收益率label
        _revenueLabel = [[UILabel alloc]
                         initWithFrame:CGRectMake(44 / 3, (426+326) * kPlusScale, 262 / 3, 84 / 3)];
        
        _revenueLabel.font = [UIFont boldSystemFontOfSize:40 / 3];
        //    _revenueLabel.layer.borderWidth = 1;
        _revenueLabel.layer.cornerRadius = 84 / 3 / 2;
        _revenueLabel.backgroundColor = RGB(71, 69, 114, 1);
        _revenueLabel.textAlignment = NSTextAlignmentCenter;
        _revenueLabel.textColor = [UIColor whiteColor];
        _revenueLabel.clipsToBounds = YES;
        
        [_footerView addSubview:_revenueLabel];
        
        //画线
        UIImageView* imageView1 =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView1];
        
        UIGraphicsBeginImageContext(imageView1.frame.size);
        [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width,
                                                imageView1.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44)/3,
                             (468+326) * kPlusScale); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (468+326) * kPlusScale); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
#pragma mark--投资期限
        
        // 投资期限label
        _deadlineLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(44 * kPlusScale,
                                                   (572 + 77 + 100+326) * kPlusScale, 262 / 3,
                                                   84 / 3)];
     
        _deadlineLabel.font = [UIFont boldSystemFontOfSize:36 / 3];
        //  _deadlineLabel.layer.borderWidth = 1;
        _deadlineLabel.layer.cornerRadius = 84 / 3 / 2;
        _deadlineLabel.backgroundColor = RGB(71, 69, 114, 1);
        _deadlineLabel.textAlignment = NSTextAlignmentCenter;
        _deadlineLabel.textColor = [UIColor whiteColor];
        _deadlineLabel.clipsToBounds = YES;
        
        [_footerView addSubview:_deadlineLabel];
        
        //画线
        UIImageView* imageView2 =
        [[UIImageView alloc] initWithFrame:self.view.frame];
        [_footerView addSubview:imageView2];
        
        UIGraphicsBeginImageContext(imageView2.frame.size);
        [imageView2.image drawInRect:CGRectMake(0, 0, imageView2.frame.size.width,
                                                imageView2.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1); //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 71.0 / 255.0,
                                   69.0 / 255.0, 114.0 / 255.0, 1.0); //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), (44 + 262 + 44) / 3,
                             (794+326) * kPlusScale); //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth,
                                (794+326) * kPlusScale); //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView2.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        //确认按钮
        UIButton* okButton = [UIButton buttonWithType:UIButtonTypeSystem];
        okButton.frame = CGRectMake(0, _footerView.height - 146 * kPlusScale,
                                    kScreenWidth, 146 * kPlusScale);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
        okButton.backgroundColor = RGB(211, 74, 89, 1);
        
        [okButton addTarget:self
                     action:@selector(okButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_footerView addSubview:okButton];
        
        _maskView = [[UIControl alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        //根据RGB设置颜色
        //[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#>
        //blue:<#(CGFloat)#>
        // alpha:<#(CGFloat)#>]
        
        //根据灰度设置颜色
        //灰度，0为纯黑，1为纯白
        _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
        _maskView.hidden = YES;
        [_maskView addTarget:self
                      action:@selector(maskViewAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        //在某个子视图上面插入一个视图
        //[self insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
        
        //在某个子视图下面插入一个视图
        _lastWindow = [UIApplication sharedApplication].windows.lastObject;
        
        [_lastWindow insertSubview:_maskView belowSubview:_footerView];
        
        //根据下标插入
        //[self insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>];
        
        // NSLog(@"%@", _footerView.subviews);
        
        

    
    }

    

}







#pragma mark - 优质散表用户表视图
//创建优质散表用户表视图
- (void)createBestUserTableView
{ //散标用户
   
   

    _bestUserTableView = [[BestUserTableview alloc]
        initWithFrame:CGRectMake(0, 64.5, kScreenWidth,
                          kScreenHeight - kTabBarHeight-0.5)
                style:UITableViewStylePlain];
    _bestUserTableView.backgroundColor = [UIColor clearColor];
   // _bestUserTableView.hidden = NO;
    [self.view addSubview:_bestUserTableView];
  //    _headerImageView = [[UIImageView alloc]init];
//    _headerImageView.frame = CGRectMake(0, 0, kScreenWidth, 192*kHeightScale);
//    _bestUserTableView.tableHeaderView = _headerImageView;
//  
//    _headerImageView.userInteractionEnabled = YES;
//    
//    /*
//     *列表图片可点击
//     */
//   _headerControl = [[UIButton alloc]init];
//    _headerControl.frame = CGRectMake(0, 0, kScreenWidth, 192*kHeightScale);
//    
//    
//  
//        [_headerControl addTarget:self
//                              action:@selector(presentVC)
//                    forControlEvents:UIControlEventTouchUpInside];
//        
// 
//        
//        
//    
//    [_bestUserTableView addSubview:_headerControl];
   // _headerImageView.backgroundColor = [UIColor blueColor];
//    [_headerImageView setImage:[UIImage imageNamed:@"productBanner"]];
//    
}


#pragma mark
//创建遮盖视图
- (void)createMaskView
{
}

//创建筛选表视图
//显示尾部视图
- (void)showFooterView
{
    if (iphone5x_4_0) {
        [UIView animateWithDuration:.35
                         animations:^{
                             //使用block，来执行一个动画
                             //向下的平移
                             _footerView.transform = CGAffineTransformMakeTranslation(
                                                                                      0, -(kScreenHeight - kNavigationBarHeight - (685) * kPlusScale)-326*kPlusScale-30);
                             _maskView.hidden = NO; //遮罩显示
                         }];

    }else{
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                         _footerView.transform = CGAffineTransformMakeTranslation(
                             0, -(kScreenHeight - kNavigationBarHeight - (685) * kPlusScale)-326*kPlusScale);
                         _maskView.hidden = NO; //遮罩显示
                     }];
    }
}

//隐藏尾部视图
- (void)hideFooterView
{

    [UIView animateWithDuration:.35
                     animations:^{
                         _footerView.transform = CGAffineTransformIdentity;
                     }];
}
#pragma mark - 按钮点击事件
//导航栏按钮点击方法
- (void)rightItemButtonAction:(UIButton*)sender
{
    
    
    

               [self showFooterView]; //显示尾部视图
           
    

    //[self isConnectionAvailable];
 
        //_bestUserTableView.tableHeaderView = nil;
}

//关闭按钮点击事件
- (void)closeAction:(UIButton*)sender
{

    [self hideFooterView];
    _maskView.hidden = YES;
}

//遮盖视图点击事件
- (void)maskViewAction:(UIControl*)sender
{

    [self hideFooterView];
    sender.hidden = YES;
}
//确认按钮点击事件
- (void)completeAction:(UIButton*)sender
{

    [self hideFooterView];
    _maskView.hidden = YES;
}

#pragma mark - -筛选视图点击事件
- (void)riskButtonAction:(UIButton *)sender{

    [UIView animateWithDuration:.5
                     animations:^{
                         if (_otherButton == nil) {
                             sender.selected = YES;
                             sender.layer.borderColor = [kColorRed CGColor];
                             
                             _otherButton = sender;
                         }
                         else if (_otherButton != nil && _otherButton == sender) {
                             sender.selected = YES;
                         }
                         else if (_otherButton != sender && _otherButton != nil) {
                             _otherButton.selected = NO;
                             _otherButton.layer.borderColor = [[UIColor whiteColor] CGColor];
                             sender.selected = YES;
                             _otherButton = sender;
                             sender.layer.borderColor = [kColorRed CGColor];
                         }
                     }
                     completion:^(BOOL finished) {
                         ;
                     }];
    
    switch (sender.tag) {
        case 4000:
            riskString = @"0";
            break;
        case 4001:
            riskString = @"1";
            break;
        case 4002:
            riskString = @"2";
            break;
        case 4003:
            riskString = @"3";
            break;
        case 4004:
            riskString = @"4";
            break;
        case 4005:
            riskString = @"5";
        default:
            break;
    }



}



//还款方式
- (void)repayButtonAction:(UIButton*)sender
{
    UIColor* textColorR = RGB(211, 74, 89, 1);

    [UIView animateWithDuration:.5
        animations:^{
            if (_tmpBtn == nil) {
                sender.selected = YES;
                sender.layer.borderColor = [textColorR CGColor];

                _tmpBtn = sender;
            }
            else if (_tmpBtn != nil && _tmpBtn == sender) {
                sender.selected = YES;
            }
            else if (_tmpBtn != sender && _tmpBtn != nil) {
                _tmpBtn.selected = NO;
                _tmpBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
                sender.selected = YES;
                _tmpBtn = sender;
                sender.layer.borderColor = [textColorR CGColor];
            }
        }
        completion:^(BOOL finished) {
            ;
        }];

    switch (sender.tag) {
    case 1000:
        repayMentString = @"0";
        break;
    case 1001:
        repayMentString = @"1";
        break;
    case 1002:
        repayMentString = @"2";
        break;
    case 1003:
        repayMentString = @"3";
    default:
        break;
    }
}

//年化收益
- (void)revenueButtonAction:(UIButton*)sender
{
    // sender.selected = !sender.selected;
    UIColor* textColorR = RGB(211, 74, 89, 1);
    [UIView animateWithDuration:.5
        animations:^{

            if (_staticButton == nil) {
                sender.selected = YES;
                sender.layer.borderColor = [textColorR CGColor];

                _staticButton = sender;
            }
            else if (_staticButton != nil && _staticButton == sender) {
                sender.selected = YES;
            }
            else if (_staticButton != sender && _staticButton != nil) {
                _staticButton.selected = NO;
                _staticButton.layer.borderColor = [[UIColor whiteColor] CGColor];
                sender.selected = YES;
                _staticButton = sender;
                sender.layer.borderColor = [textColorR CGColor];
            }

        }
        completion:^(BOOL finished) {
            ;
        }];

    switch (sender.tag) {
    case 2000:
        revenueString = @"0";
        break;
    case 2001:
        revenueString = @"1";
        break;
    case 2002:
        revenueString = @"2";
        break;
    case 2003:
        revenueString = @"3";
        break;
    default:
        break;
    }
}
//投资期限
- (void)deadlineButtonAction:(UIButton*)sender
{
    // sender.selected = !sender.selected;
    UIColor* textColorR = RGB(211, 74, 89, 1);
    UIColor* deadlineColor = RGB(211, 218, 255, 1);

    //    SingleObject *singObject =[SingleObject sharedObject];
    //    for (int i=0 ; singObject.array.count; i++) {
    //        UILabel *label = singObject.array[i];
    //
    //        if (sender.tag-3000 ==i) {
    //            label.textColor = textColorR;
    //
    //        }else{
    //
    //         label.textColor = deadlineColor;
    //        }
    //
    //
    //    }
    [UIView animateWithDuration:.5
        animations:^{

            if (sender != self.juButton) {

                self.juButton.selected = NO;
                self.juButton = sender;
            }
            self.juButton.selected = YES;

        }
        completion:^(BOOL finished) {
            for (int i = 0; i < 5; i++) {
                UILabel* la = (UILabel*)[_footerView viewWithTag:5000 + i];
                if (la.tag == sender.tag - 3000 + 5000) {
                    la.textColor = textColorR;
                    [_footerView setNeedsDisplay];
                    [_footerView setNeedsLayout];
                }
                else {
                    la.textColor = deadlineColor;
                }
            }
        }];
    switch (sender.tag) {
    case 3000:
        deadlineString = @"0";

        break;
    case 3001:
        deadlineString = @"1";
        break;
    case 3002:
        deadlineString = @"2";
        break;
    case 3003:
        deadlineString = @"3";
        break;
    case 3004:
        deadlineString = @"4";
        break;

    default:
        break;
    }
}
/*
 全局 的self.starButton
 - (void)click:(UIButton *)button{
 if(button!=self.starButton){
 self.starButton.selected=NO;
 self.starButton=button;
 }
 self.starButton.selected=YES;
 }


 */

#pragma mark - 发送post请求获取数据

- (void)okButtonAction:(UIButton*)sender
{
    
    [_bgView setImage:[UIImage imageNamed:@""]];
    
    _fiterType = @"1";
    [self hideFooterView];
    _maskView.hidden = YES;
    _postStr = [NSString stringWithFormat:@"%@%@%@%@",riskString,repayMentString,
                revenueString, deadlineString]; //
    fiterCont =1;
    fiterFreshState = NO;
    [self requesFilterData];
    
    
    
    if ([_postStr isEqualToString:@"0000"]) {
        [_bgView setImage:[UIImage imageNamed:@"6myMess6"]];
    }else{
        
        
        
        
    }



}
    
    


- (void)requesFilterData{

      NSString *page =[NSString stringWithFormat:@"%ld",fiterCont];
    NSLog(@"筛选第几页数据%@",page);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   
                                   
                                   @{
                                     @"p" : page, // 分页，可选
                                     @"limit" : @"10",
                                     @"code" : _postStr
                                     }
              
                                   ];
    NSLog(@"%@",_postStr);
    
  
        
        
        [ DataService requestWithURL:@"/product/list"
                              params:params
                          httpMethod:@"post"
                     completionBlock:^(id result) {
                         [self loadFilterData:result];
                     }];
        
    
    

}

#pragma mark 请求筛选后的列表
- (void)loadFilterData:(id)result{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    
    [HUD show:YES];

    NSDictionary* responseDic =result;
    NSNumber* codeNumber = [responseDic objectForKey:@"code"];

        if ([[[responseDic objectForKey:@"data"] class]
             isSubclassOfClass:[NSDictionary class]]) {
            
            _headerControl.hidden = NO;
            [_images removeFromSuperview];
            _images = nil;

            NSDictionary* listDic = [responseDic objectForKey:@"data"];
            NSArray* array = [listDic objectForKey:@"list"];
            for (NSDictionary* dataDic in array) {
                ListModel* model = [[ListModel alloc] initWithDataDic:dataDic];
                if (fiterFreshState == NO) {
                    [self.data removeAllObjects];
                    fiterFreshState = YES;
            }

                [self.data addObject:model];
                _bestUserTableView.data = self.data;
            }
       
                      //刷新表视图，回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak ChanpinViewController* weakSelf = self;
                
                //上拉加载更多
                self.bestUserTableView.mj_footer =
                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    
                    if ([_fiterType isEqualToString:@"1"]) {
                        hasData = YES;
                        
                        [weakSelf requesFilterData];//请求筛选数据
                        
                    }else{
                        
                        
                        [weakSelf requestMoreData];
                        
                    }
                }];

                [self.bestUserTableView reloadData];
                fiterCont++;
                [HUD hide:YES afterDelay:0.5];
                [self.bestUserTableView.mj_header endRefreshing];
                if (self.data.count ==0  ||self.data.count<10) {
                    [self.bestUserTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.bestUserTableView.mj_footer endRefreshing];
        }
  
            });

        }
        else {
            
               NSLog(@"结果为%@", [result objectForKey:@"data"]);
            if (hasData == YES) {
                
                  [HUD hide:YES afterDelay:0.5];
                if (self.data.count ==0  ||self.data.count<10) {
                    [self.bestUserTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.bestUserTableView.mj_footer endRefreshing];
                    hasData = NO;

                 
                }
                
            }else{
            
                
                [self.data removeAllObjects];
                
                [self.bestUserTableView reloadData];
                [HUD hide:YES afterDelay:0.5];
                
                [self.bestUserTableView.mj_header endRefreshing];
                if (self.data.count ==0  ||self.data.count<10) {
                    [self.bestUserTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.bestUserTableView.mj_footer endRefreshing];
                    
         
                }

                /*
                 *   背景图拍
                 */
                if (!_images) {
                    
                    
                    
                    _images = [[UIImageView alloc]init];
                    _images.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
                    _images.image = [UIImage imageNamed:@"6PTINothingBg"];
                    
                    [self.view addSubview:_images];
                }
                
                

            }
                   }
  
    
   

}

#pragma mark - －label自适应
//是宽度不变，动态改变高度
- (float)heightForString:(NSString*)value
                fontSize:(float)fontSize
                andWidth:(float)width
{

    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByCharWrapping];

    return sizeToFit.height;
}

//是宽度不变，动态改变高度
- (float)widthForString:(NSString*)value
               fontSize:(float)fontSize
              andHeight:(float)height
{

    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                             lineBreakMode:NSLineBreakByCharWrapping];

    return sizeToFit.width;
}


#pragma mark - 第一版不上
/*
 //优质散标左边button
 -(void)createLeftButton{
 UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
 leftButton.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth/2, 30);
 [leftButton setTitle:@"优质散标" forState:UIControlStateNormal];
 leftButton.tintColor = [UIColor blackColor];
 leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
 [leftButton addTarget:self action:@selector(leftButtonAction:)
 forControlEvents:UIControlEventTouchUpInside];

 [self.view addSubview:leftButton];

 }

 //创建左侧按钮
 -(void)createRightButton{ //createTableView
 UIButton *rightButton= [UIButton buttonWithType:UIButtonTypeSystem];
 rightButton.frame = CGRectMake(kScreenWidth/2, kNavigationBarHeight,
 kScreenWidth/2, 30);
 [rightButton setTitle:@"转让专区" forState:UIControlStateNormal];
 rightButton.tintColor = [UIColor blackColor];
 rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
 [rightButton addTarget:self action:@selector(rightButtonAction:)
 forControlEvents:UIControlEventTouchUpInside];

 [self.view addSubview:rightButton];

 }

 -(void)createChooseButton{
 NSArray *classesArray = @[
 @"全部",
 @"新手标",
 @"高收益",
 @"超短期",
 ];

 for (int i=0 ; i<4; i++) {
 UIButton *titleButton =[UIButton buttonWithType:UIButtonTypeSystem];
 titleButton.frame = CGRectMake((kScreenWidth/4)*i, kNavigationBarHeight+30,
 kScreenWidth/4, 30);
 [titleButton setTitle:classesArray[i] forState:UIControlStateNormal];
 titleButton.tag = 1000+i;
 [titleButton addTarget:self action:@selector(classButtonAction:)
 forControlEvents:UIControlEventTouchUpInside];

 [self.view addSubview: titleButton];

 }

 }

 //创建优质散表用户表视图
 -(void)createBestUserTableView{//散标用户

 _bestUserTableView =[[BestUserTableview alloc]initWithFrame:CGRectMake(0,
 kNavigationBarHeight+30+50, kScreenWidth,
 kScreenHeight-kNavigationBarHeight-kTabBarHeight-30-50)style:UITableViewStylePlain];//30为选择按钮的高度；
 _bestUserTableView.hidden = NO;

 [self.view addSubview:_bestUserTableView];


 }
 //创建转让专区用户表视图
 -(void)createTransferTableView{
 _transfertableview =[[TransferTableView alloc]initWithFrame:CGRectMake(0,
 kNavigationBarHeight+30+50, kScreenWidth,
 kScreenHeight-kNavigationBarHeight-kTabBarHeight-30)style:UITableViewStylePlain];//30为选择按钮的高度；
 _transfertableview.hidden = YES;
 [self.view addSubview:_transfertableview];


 }

 #pragma mark -－选择不同的类别button

 // TODO:分类按钮的点击事件， 通过不同的按钮来requeset请求
 -(void)classButtonAction:(UIButton*)sender{

 if (sender.tag == 1000) {
 NSLog(@"全部产品");
 }else if (sender.tag == 1001){
 NSLog(@"新手标");
 }else if (sender.tag == 1002){
 NSLog(@"高收益");
 }else if (sender.tag == 1003){
 NSLog(@"超短期");
 }
 }

 //优质散户点击事件
 -(void)leftButtonAction:(UIButton *)sendder{
 _bestUserTableView.hidden = NO;
 _transfertableview.hidden = YES;
 }

 //转让点击事件
 -(void)rightButtonAction:(UIButton *)sendder{
 _bestUserTableView.hidden = YES;
 _transfertableview.hidden = NO;


 }
 */
/*
 *
 */

-(void)presentVC{

    NSLog(@"banner");
    
    if (_bannerUrl.length >9) {
        
        
        BannerViewController *bannerVC = [[BannerViewController alloc]init];
        
        bannerVC.urlStr = _bannerUrl;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:bannerVC animated:NO completion:nil];

    
    
    }else{
        
        
        NSLog(@"没有图片的情况");
    }
    




}



- (void)requestUserInformationData{
    [DataService requestWithURL:@"/v2/user/information"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    NSDictionary *responceDic = result;
                    NSLog(@"----------userInformation----:%@",result);
                    NSNumber *code = [responceDic objectForKey:@"code"];
                    if ([code isEqualToNumber:@200]) {
                        
                        NSDictionary *data = [responceDic objectForKey:@"data"];
                        
                        NSDate* currentDate = [NSDate date];
                        NSLog(@"当前时间：%@",currentDate);
                        
                        
                                           noticeState = [[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBool"]boolValue];
                        activitystate =[[[NSUserDefaults standardUserDefaults] objectForKey: @"clickActionBool"]boolValue];
                        
                        
                        _activityValue= [data objectForKey:@"activity"];//@"22";
                        _noticeValue = [data objectForKey:@"notice"];//@"20";//
                        
                        _lastActivitySandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastActivityTime"];
                        _lastNoticeSandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastNoticeTime"];
                        
                        NSLog(@"%@-----%@",_lastNoticeSandbox,_lastActivitySandbox);
                        if (![_lastNoticeSandbox isKindOfClass:[NSString class]]) {
                            _lastActivitySandbox = @"0";
                            _lastNoticeSandbox = @"0";
                            
                        }
                        
                        _clickNoticeDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
                        _clickActionDate =  [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
                        
                        
                        if (![_clickNoticeDate isKindOfClass:[NSString class]]) {
                            _clickNoticeDate = @"0";
                            
                        }
                        if (![_clickActionDate isKindOfClass:[NSString class]]) {
                            _clickActionDate  = @"0";
                            
                            
                        }
                        
                        //如果有最新的活动
                        if ([_activityValue floatValue]>[_lastActivitySandbox floatValue]||[_noticeValue floatValue]>[_lastNoticeSandbox floatValue]) {
                            [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                            [[NSUserDefaults standardUserDefaults]setObject:_activityValue forKey:@"lastActivityTime"];
                            [[NSUserDefaults standardUserDefaults]setObject:_noticeValue forKey:@"lastNoticeTime"];
                            
                            [[NSUserDefaults standardUserDefaults]setBool:NO forKey: @"clickActionBool"];
                            
                            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"clickNoticeBool"];

                            
                        }else if ([_activityValue floatValue]==[_lastActivitySandbox floatValue]||[_noticeValue floatValue]==[_lastNoticeSandbox floatValue])
                            
                        {
                            //
                            
                            
                            if ([_clickNoticeDate floatValue]>=[_noticeValue floatValue]&&[_clickActionDate floatValue]>=[_activityValue floatValue]) {
                                
                                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                
                                
                            }else{
                                if (noticeState ==YES && activitystate ==YES) {
                                    
                                    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                    
                                }else{
                                    
                                    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                                }
                                
                                
                                
                            }
                            
                            
                        }else
                            
                            
                            
                        {
                            
                            //隐藏
                            [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    else{
                        
                        
                        
                        NSLog(@"没有新消息");
                        
                        
                    }
                    
                }];
    
    
    
}

-(void)requestFRESH{
    pageCont = 1;
    freshState = NO;

    NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page, // 分页，可选
                                     @"limit" : @"10",
                                     @"code" : @"0000"
                                     }];
    NSLog(@"#######请求更多数据%@",params);
    [DataService requestWithURL:@"/product/list"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    
                    [self loadMoreListData:result];
                    
                    pageCont ++;
                }];
    
    if(!isExistenceNetwork){
        
        
        
        
        [self.bestUserTableView.mj_header endRefreshing];
        [self.bestUserTableView.mj_footer endRefreshing];
    }
    
    
    



}

@end
