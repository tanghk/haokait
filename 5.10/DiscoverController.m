//
//  DiscoverController.m
//  555
//
//  Created by otouzi on 16/3/8.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "DiscoverController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "OfficialNoticeController.h"
#import "SafeViewController.h"

#import "LatestActivitiesController.h"
#import "RedEnvelopesController.h"

#import "CommonProblemsViewController.h"
#import "DataService.h"
#import "UITabBar+badge.h"
#import "AboutUsControllers.h"
#import "HelperCenterController.h"
#import "NetworkState.h"
//#import "MyInvestController.h"
@interface DiscoverController (){

    UIButton *_noticeButton;//公告中心
    UIButton *_safeButton;//安全保障
    UIButton *_aboutButton;
    UIButton *_helpButton; //帮助中心
    UIButton *_actionButton;//最新活动
    UIButton *_placeImage;
    
    NSString* _activityValue;
    NSString* _noticeValue;
    NSString * _lastActivitySandbox;//沙河
    NSString * _lastNoticeSandbox;//沙河
    
    BOOL noticeState;
    BOOL activitystate;

    
    NSString *_clickActionDate;
    NSString *_clickNoticeDate;
    
    NSString *_notice_url;
    NSString *_about_url;
    NSString *_activity_url;
    
}

@end

@implementation DiscoverController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;//状态栏白色字体


}
- (void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
    [self requestUserInformationData];
    [self creatWithNavGation];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

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
                        _activityValue= [data objectForKey:@"activity"];//@"22";
                        _noticeValue = [data objectForKey:@"notice"];//@"20";//
                        
                        _notice_url = [data objectForKey:@"notice_url"];
                        _about_url = [data objectForKey:@"about_url"];
                        _activity_url = [data objectForKey:@"activity_url"];
                        
                        
                        noticeState = [[[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeBool"]boolValue];
                        activitystate =[[[NSUserDefaults standardUserDefaults] objectForKey: @"clickActionBool"]boolValue];
                        
                        
                        _lastActivitySandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastActivityTime"];
                        _lastNoticeSandbox = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastNoticeTime"];
                        
                        _clickNoticeDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"clickNoticeDate"];
                        _clickActionDate =  [[NSUserDefaults standardUserDefaults]objectForKey:@"clickActionDate"];
                        NSLog(@"_clickNoticeDate = %@ or  _clickActionDate %@",_clickNoticeDate, _clickActionDate);
                        if (![_clickNoticeDate isKindOfClass:[NSString class]]) {
                            _clickNoticeDate = @"0";
                            
                        }
                        if (![_clickActionDate isKindOfClass:[NSString class]]) {
                            _clickActionDate  = @"0";
                            
                            
                        }
                        
                        NSLog(@"_clickNoticeDate = %@ or  _clickActionDate %@",_clickNoticeDate, _clickActionDate);
                        /*
                         *最新活动
                         */
                        if ([_activityValue floatValue]==[_lastActivitySandbox floatValue]||[_noticeValue floatValue]==[_lastNoticeSandbox floatValue]){
                            
                            if ([_noticeValue floatValue]==[_lastNoticeSandbox floatValue]){
                                [_noticeButton setImage:[UIImage imageNamed:@"findNoticeDot"] forState:UIControlStateNormal];
                                
                                if ([_clickNoticeDate floatValue]<[_noticeValue floatValue]) {
                                    
                                    if (noticeState ==YES) {
                                        [_noticeButton setImage:[UIImage imageNamed:@"findNotice"] forState:UIControlStateNormal];
                                    }else{
                                        
                                        [_noticeButton setImage:[UIImage imageNamed:@"findNoticeDot"] forState:UIControlStateNormal];
                                        
                                        
                                    }
                                    
                                }else{
                                    
                                    [_noticeButton setImage:[UIImage imageNamed:@"findNotice"] forState:UIControlStateNormal];
                                    
                                }
                            }
                            
                            if ([_activityValue floatValue]==[_lastActivitySandbox floatValue]) {
                                [_actionButton setImage:[UIImage imageNamed:@"findNewDot"] forState:UIControlStateNormal];
                                
                                if ([_clickActionDate floatValue]<[_activityValue floatValue] ) {
                                    if (activitystate ==YES) {
                                        [_actionButton setImage:[UIImage imageNamed:@"findNew"] forState:UIControlStateNormal];
                                        
                                    }else{
                                        
                                        
                                        [_actionButton setImage:[UIImage imageNamed:@"findNewDot"] forState:UIControlStateNormal];
                                    }
                                    
                                }else{
                                    
                                    [_actionButton setImage:[UIImage imageNamed:@"findNew"] forState:UIControlStateNormal];
                                    
                                    
                                    
                                }
                                
                            }else if ([_activityValue floatValue]>[_lastActivitySandbox floatValue]||[_noticeValue floatValue]>[_lastNoticeSandbox floatValue]){
                                
                                
                                if ([_noticeValue floatValue]>[_lastNoticeSandbox floatValue]){
                                    [_noticeButton setImage:[UIImage imageNamed:@"findNoticeDot"] forState:UIControlStateNormal];
                                    
                                    [[NSUserDefaults standardUserDefaults]setObject:_noticeValue forKey:@"lastNoticeTime"];
                                    
                                    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                                    
                                    
                                }
                                

                                if ([_activityValue floatValue]>[_lastActivitySandbox floatValue]) {
                                    [_actionButton setImage:[UIImage imageNamed:@"findNewDot"] forState:UIControlStateNormal];
                                    [[NSUserDefaults standardUserDefaults]setObject:_activityValue forKey:@"lastActivityTime"];
                                    
                                    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
                                    
                                }
                                
                            }
                            
                            
                            
                            if ([_clickNoticeDate floatValue]>=[_noticeValue floatValue] &&[_clickActionDate floatValue]>=[_activityValue floatValue]) {
                                
                                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                
                                
                            }
                            
                            if ([_clickNoticeDate floatValue]<[_noticeValue floatValue] ||[_clickActionDate floatValue]<[_activityValue floatValue]) {
                                
                                
                                
                                if (activitystate == YES && noticeState  ==YES) {
                                    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                    
                                }
                                if (activitystate == YES &&[_clickNoticeDate floatValue]>=[_noticeValue floatValue] ) {
                                    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                    
                                }
                                if (noticeState  ==YES&&[_clickActionDate floatValue]>=[_activityValue floatValue]) {
                                    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                }];
    
    
    
    
}

- (instancetype)init{
  self = [super init];
    if (self) {
          [self custumSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  //  [self layoutSubviews];

    
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
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"发现";
    titleLabel.font = [UIFont systemFontOfSize:16];
   // titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
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




#pragma mark - 自定义子视图
- (void)custumSubViews{
    
//    
//    
//    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.contentSize = CGSizeMake(kScreenWidth,kScreenHeight-kNavigationBarHeight);
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.pagingEnabled = NO;
//    scrollView.backgroundColor = kColorLightGray;
    
    

    
    /*
     *官方公告
     */
    _noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // _noticeButton.backgroundColor = [UIColor redColor];
 [_noticeButton setAdjustsImageWhenHighlighted:NO];
      [_noticeButton setImage:[UIImage imageNamed:@"findNotice"] forState:UIControlStateNormal];
   // [_noticeButton setImage:[UIImage imageNamed:@"findNotice"] forState:UIControlStateHighlighted];
   // [_noticeButton setImage:[UIImage imageNamed:@"findNotice"] forState:UIControlStateNormal];
    [_noticeButton setTitle:@"官方公告" forState: UIControlStateNormal];
    [_noticeButton addTarget:self action:@selector(noticeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
   

    /*
     *安全保障
     */
    _safeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_safeButton setAdjustsImageWhenHighlighted:NO];
     [_safeButton setImage:[UIImage imageNamed:@"findSafety"] forState:UIControlStateNormal];
   // _safeButton.backgroundColor = kColorBlue;
    //[_safeButton setTitle:@"安全保障" forState: UIControlStateNormal];

    [_safeButton addTarget:self action:@selector(safeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
   
    /*
     *关于我们
     */
    _aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  _aboutButton.backgroundColor = [UIColor lightGrayColor];
    //[_aboutButton setTitle:@"关于我们" forState: UIControlStateNormal];
  [_aboutButton setAdjustsImageWhenHighlighted:NO];
     [_aboutButton setImage:[UIImage imageNamed:@"findAboutUs"] forState:UIControlStateNormal];
    [_aboutButton addTarget:self action:@selector(aboutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     *帮助中心
     */
    _helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_helpButton.backgroundColor = [UIColor redColor];
      [_helpButton setAdjustsImageWhenHighlighted:NO];
     [_helpButton setImage:[UIImage imageNamed:@"findHelp"] forState:UIControlStateNormal];
   // [_helpButton setTitle:@"帮助中心(我的投资)" forState: UIControlStateNormal];

    [_helpButton addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     *最新活动
     */
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // _actionButton.backgroundColor = [UIColor redColor];
      [_actionButton setAdjustsImageWhenHighlighted:NO];
      // [_actionButton setTitle:@"最新活动(红包)" forState: UIControlStateNormal];
    [_actionButton setImage:[UIImage imageNamed:@"findNew"] forState:UIControlStateNormal];
    [_actionButton addTarget:self action:@selector(actionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_noticeButton];
    [self.view addSubview:_safeButton];
    [self.view addSubview:_aboutButton];
    [self.view addSubview:_helpButton];
    [self.view addSubview:_actionButton];
    
    __weak typeof(self) weakSelf = self;
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor = kcolorGrayNew;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kScreenContentHeight);
        make.width.mas_equalTo(1);
        make.top.equalTo(self.view).offset(64);
        
        
    }];
    
    
    //线1
    UILabel *lineGray1 = [UILabel new];
    lineGray1.backgroundColor = kcolorGrayNew;
    [self.view addSubview:lineGray1];
    [lineGray1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_noticeButton.mas_bottom);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth);
        
    }];
    

    //线2
    UILabel *lineGray2 = [UILabel new];
    lineGray2.backgroundColor = kcolorGrayNew;
    [self.view addSubview:lineGray2];
    [lineGray2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_aboutButton.mas_bottom);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth);
        
    }];

    
    [_noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.mas_equalTo((kScreenContentHeight-2)/3);
       make.width.mas_equalTo((kScreenWidth-2)/2);
        
        
    }];
    
    [_safeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(_noticeButton.mas_height);
        make.width.equalTo(_noticeButton.mas_width);
        
        NSLog(@"safe");
    }];
    
    [_aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeButton.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.mas_equalTo(_noticeButton.mas_height);
        make.width.equalTo(_noticeButton.mas_width);
    }];
    
    [_helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_safeButton.mas_bottom);
        make.left.equalTo(_aboutButton.mas_right);
        make.height.mas_equalTo(_aboutButton.mas_height);
        make.width.equalTo(_aboutButton.mas_width);

      
            }];
    
    [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_aboutButton.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.size.equalTo(_noticeButton);

    }];
    


    

}
#pragma mark - 布局
- (void)layoutSubviews{
    
    
    
    


}


#pragma mark - 按钮点击事件

#pragma mark -官方公告
- (void)noticeButtonClicked{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"clickNoticeBool"];

    NSDate *clickNoticeDate = [NSDate date];
    
    NSLog(@"当前时间%@",clickNoticeDate);
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[clickNoticeDate timeIntervalSince1970]];  //转化为UNIX时间戳
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    [[NSUserDefaults standardUserDefaults]setObject:timeSp  forKey:@"clickNoticeDate"];
    
  //  [[NSUserDefaults standardUserDefaults]setObject:@"21"  forKey:@"clickNoticeDate"];

    OfficialNoticeController *officeNotice = [[OfficialNoticeController alloc]init];
    officeNotice.urlStr = _notice_url;
    officeNotice.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:officeNotice animated:YES];
   
  }

#pragma mark -安全保障
- (void)safeButtonClicked{

    SafeViewController *safeVC = [[SafeViewController alloc]init];
    safeVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:safeVC animated:YES];
    

}

#pragma mark -关于我们
- (void)aboutButtonClicked{

    
    
 // AboutOtouziViewController *aboutUsVC = [[AboutOtouziViewController alloc]init];
  
    AboutUsControllers *aboutUsVC = [[AboutUsControllers alloc]init];
    aboutUsVC.urlStr = _about_url;
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];
    
    

}

#pragma mark -帮助中心/我的投资
- (void)helpButtonClicked{
    
    HelperCenterController *helpCenterVC = [[HelperCenterController alloc]init]; 
  // CommonProblemsViewController*helpCenterVC = [[CommonProblemsViewController alloc]init];
    helpCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:helpCenterVC animated:YES];
    

//    MyInvestController *myInvestVC = [[MyInvestController alloc]init];
//    myInvestVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:myInvestVC animated:YES];
    
}

#pragma mark -最新活动
- (void)actionButtonClicked{
   [[NSUserDefaults standardUserDefaults]setBool:YES forKey: @"clickActionBool"];
   // [[NSUserDefaults standardUserDefaults]setObject:@"23" forKey:@"clickActionDate"];
    NSDate *clickActionDate = [NSDate date];
    
    NSLog(@"当前时间%@",clickActionDate);
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[clickActionDate timeIntervalSince1970]];  //转化为UNIX时间戳
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    [[NSUserDefaults standardUserDefaults]setObject:timeSp  forKey:@"clickActionDate"];

    LatestActivitiesController *lastActivitiesVC = [[LatestActivitiesController alloc]init];
    lastActivitiesVC.urlStr = _activity_url;
    lastActivitiesVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lastActivitiesVC animated:YES];
    
//    RedEnvelopesController *redEnvelopes = [[RedEnvelopesController alloc]init];
//    redEnvelopes.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:redEnvelopes animated:YES];
    

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
