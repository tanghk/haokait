//
//  MyInvestController.m
//  555
//
//  Created by otouzi on 16/3/11.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "MyInvestController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "InvestCell.h"
#import "MyInvestModel.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
@interface MyInvestController (){
    
    NSInteger pageCont;
    BOOL freshState;
    MBProgressHUD *HUD;
    UITableView *_investView;
    UIButton *_investButton;
    BOOL statues;
    
}


@end

@implementation MyInvestController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    pageCont = 1;
    freshState = NO;
   // self.data = [NSMutableArray array];
  
    
    [self creatWithNavGation];
   
    statues = [[NSUserDefaults standardUserDefaults]objectForKey:@"PorAstatues"];
  
         if (statues == YES) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PorAstatues"];

        
    }else{
     [self requestMyInvestData];
       // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PorAstatues"];
    
    }
    NSLog(@"状态：－－－－－%d",statues);
    
 
  
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     //[self requestMyInvestData];

    [self custumInvestView];

    _data = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    __weak MyInvestController* weakSelf = self;
    //下拉刷新的头视图
    _investView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageCont = 1;
        freshState = NO;

        [weakSelf requestMyInvestData];
        
    }];
    
    
    

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
    titleLabel.text = @"我的投资";
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


#pragma mark - 创建视图
-(void)custumInvestView{
    
    _investView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _investView.showsVerticalScrollIndicator = NO;
    _investView.delegate = self;
    _investView.dataSource = self;
    _investView.showsVerticalScrollIndicator = NO;//滑动条隐藏

    [_investView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//分割线
    [self.view addSubview:_investView];
    
    
    
    _investButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_investButton setTitle:@"继续投资" forState:UIControlStateNormal];
    _investButton.layer.cornerRadius = 5;
//    _investButton.titleLabel.font = [UIFont systemFontOfSize:0.027*kScreenHeight];
     _investButton.titleLabel.font = [UIFont systemFontOfSize:32/2];
    [_investButton addTarget:self
                      action:@selector(investAction:)
            forControlEvents:UIControlEventTouchUpInside];
    _investButton.backgroundColor = kColorMain;
    [self.view addSubview:_investButton];

    
   
    
    [_investView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64.5);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-53-10-5);
        
    }];
    [_investButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
      // make.height.mas_equalTo(0.08*kScreenHeight);
        make.height.mas_equalTo(53);

        
    }];

    
    
    
    
    
}


#pragma mark -  请求我的投资数据
-(void)requestMyInvestData{
    
    
    NSString *page =[NSString stringWithFormat:@"%ld",pageCont];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"p" : page,          // 分页，可选
                                     @"startdate": @"",    // 可选，筛选开始时间，默认全部
                                     @"endstart": @"",     // 可选，筛选结束时间，默认全部
                                     @"limit": @"6",      // 可选，查询个数，默认 10,
                                     @"code" : @"0"
                                     }];
    NSLog(@"#######%@",params);
    
    
    [DataService requestWithURL:@"/v2/product/list"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    [self loadMyInvestData:result];
                    
                }];
    
    
}

-(void)loadMyInvestData:(id)result{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    NSDictionary* responseDic = result;
    NSLog(@"投资记录%@",responseDic);
    
    NSNumber* codeNumber = [responseDic objectForKey:@"code"];
    if ([codeNumber isEqualToNumber:@200]) {
        
        

        
        [HUD hide:YES afterDelay:0.5];
        NSDictionary *dataDic = [responseDic objectForKey:@"data"];
        NSMutableArray *listArr = [dataDic objectForKey:@"list"];
        
        for (NSDictionary *investDetailDic in listArr) {
            MyInvestModel *model = [[MyInvestModel alloc]initWithDataDic:investDetailDic];
            if (freshState == NO) {
                
                [self.data removeAllObjects];
                
                freshState = YES;
            }

            [self.data addObject:model];
            
            NSLog(@"我的投资个数：%ld",self.data.count);

                   }
        
        
        
        //刷新表视图，回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [_investView reloadData];
            pageCont++;
             [HUD hide:YES afterDelay:0.5];
                    //结束下拉刷新
            [_investView.mj_header endRefreshing];
            [_investView.mj_footer endRefreshing];
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            if (self.data.count==0) {
                
                
                [_investView removeFromSuperview];
                _investView =nil;
                
                
                UILabel *noInvest = [UILabel new];
                
                noInvest.text = @"暂无投资记录!";
                noInvest.font = Font(18);
                noInvest.textColor = RGB(145, 145, 145, 1);
                
                [self.view addSubview:noInvest];
                
                [noInvest mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.centerY.equalTo(self.view.mas_centerY).offset(-kScreenContentHeight/4+18);
                    
                }];
  
            }else if (self.data.count ==6){
            
            
                __weak MyInvestController* weakSelf = self;
                //上拉加载更多
                _investView.mj_footer =
                [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    
                    
                    [weakSelf requestMyInvestData];
                    
                    
                }];

            
            }
            
            //[HUD hide:YES afterDelay:0.5];
        });

        
    }else {
        
        
        [HUD hide:YES afterDelay:0.5];
        
        
    }
    
}


#pragma mark - TableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"My_Invest_Cell";
    InvestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InvestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    MyInvestModel *model = self.data[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 0.361*kScreenHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

#pragma mark - 投资按钮
- (void)investAction:(UIButton *)sender{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
    
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
