//
//  repaymentPlanController.m
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "RepaymentPlanController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "RepaymentModel.h"
#import "RepaymentPlanCell.h"
#import "UIViewExt.h"
@interface RepaymentPlanController ()
{
    UILabel *_nameLabel;
    UILabel *_moneyLabel;
    UILabel *_invest_annualLabel;
    UILabel *_invest_stateLabel;
    UILabel *_total_incomeLabel;
    UILabel *_investment_release_start_timeLabel;
    UILabel *_investment_release_end_timeLabel;
    NSString *_project_id;
    NSString *_investment_id;
    
    UITableView *_bottomView;
    

    NSString *_moneyValue;
    NSString *_revenueValue;
    NSString *_progressValue;
    NSString *_estimate_total_interestValue;
    NSString *_release_start_timeValue;
    NSString *_release_end_timeValue;
    NSString *_increaseValue;
    


}

@end

@implementation RepaymentPlanController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.data = [NSMutableArray array];
    [self creatWithNavGation];
  [self requestRepaymentPlanData];
   
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;//状态栏黑色字体
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"PorAstatues"];
    [self custumTopView];
    // Do any additional setup after loading the view.
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



#pragma mark - 请求还款计划数据
- (void)requestRepaymentPlanData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"investment_id" :_investment_id,
                                     @"project_id":_project_id
                                     
                                     }];
    
[DataService requestWithURL:@"/user/repaymentPlan"
                     params:params
                 httpMethod:@"post"
            completionBlock:^(id result) {
                [self loadRepaymentPlanData:result];
                NSLog(@"还款计划%@",result);
}];



}


#pragma mark - 加载
- (void)loadRepaymentPlanData:(id)result{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];
    

    NSDictionary *response = result;
    
    NSNumber *codeNumber = [response objectForKey:@"code"];
    
    if ([codeNumber intValue]==200) {
        
//        
    //        _nameLabel.text = [NSString stringWithFormat:@"项目名称：%@",[data objectForKey :@"name" ]];
//        _moneyLabel.text = [NSString stringWithFormat:@"投资金额：%@",[data objectForKey :@"money"]];
//        _invest_annualLabel.text = [NSString stringWithFormat:@"年化收益：%@%%",[data objectForKey :@"revenue"]];
//        _invest_stateLabel.text = [NSString stringWithFormat:@"投资状态(元)：%@",[data objectForKey :@"progress"]];
//        _total_incomeLabel.text =[NSString stringWithFormat:@"预计收益：%@",[data objectForKey :@"estimate_total_interest"]];
//        _investment_release_start_timeLabel.text = [NSString stringWithFormat:@"计息日期：%@",[data objectForKey :@"release_start_time"]];
//        _investment_release_end_timeLabel.text = [NSString stringWithFormat:@"到期日期：%@",[data objectForKey :@"release_end_time"]];
//      
        NSDictionary *data = [response objectForKey:@"data"];
        NSLog(@"还款计划%@",data);
        _moneyValue = [data objectForKey :@"money"];
        _revenueValue = [data objectForKey :@"revenue"];
        _progressValue = [data objectForKey :@"progress"];
        _estimate_total_interestValue = [data objectForKey :@"estimate_total_interest"];
        _release_start_timeValue = [data objectForKey :@"release_start_time"];
        _release_end_timeValue = [data objectForKey :@"release_end_time"];
        _increaseValue = [data objectForKey :@"increase"];
        
        
        
        
        
        
        
        NSString *const Invest_Money = @"投资金额(元):";
        NSString *const Invest_Annual = @"预期年化收益:";
        NSString *const Total_Income = @"预计收益(元):";
        NSString *const Invest_State = @"状态:";
        NSString *const Investment_Release_Start_Time = @"计息日期:";
        NSString *const Investment_Release_End_Time = @"到期日期:";

        
        _nameLabel.text = [NSString stringWithFormat:@"项目名称：%@",[data objectForKey :@"name"]];
        
        
      
        
        //_moneyLabel.text = [NSString stringWithFormat:@"投资金额：%@",_model.money];
        NSString *prompt = [NSString stringWithFormat:@"%@%@",Invest_Money,_moneyValue];
        NSMutableAttributedString *mulFullStr = [[NSMutableAttributedString alloc] initWithString:prompt];
        NSRange range = [[mulFullStr string] rangeOfString:_moneyValue];
        [mulFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:range];
        
        _moneyLabel.attributedText = mulFullStr;
        
        
        
        NSString *investment_increase;
        //_invest_annualLabel.text = [NSString stringWithFormat:@"年化收益：%@%%",_model.invest_annual];
        double revenue=  [_revenueValue  doubleValue];
        double increase =  [_increaseValue  doubleValue];
        investment_increase = [NSString stringWithFormat:@"%.1f%%+%.1f%%",revenue,increase];
        
        if ([_increaseValue  isEqualToString:@"0"]||[_increaseValue  isEqualToString:@"0.0"]||[_increaseValue  isEqualToString:@"0.00"]) {
            
            investment_increase = [NSString stringWithFormat:@"%.f%%",revenue];
            
        }
        
        NSString *annual = [NSString stringWithFormat:@"%@%@",Invest_Annual,investment_increase];
        NSMutableAttributedString *annualFullStr = [[NSMutableAttributedString alloc] initWithString:annual];
        NSRange rangeAnnual = [[annualFullStr string] rangeOfString:investment_increase];
        [annualFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:rangeAnnual];
        
        _invest_annualLabel.attributedText = annualFullStr;
        
        
        
        
        
        
        //_total_incomeLabel.text =[NSString stringWithFormat:@"预计收益：%@",_model.total_income];
        NSString *income = [NSString stringWithFormat:@"%@%@",Total_Income,_estimate_total_interestValue];
        NSMutableAttributedString *incomeFullStr = [[NSMutableAttributedString alloc] initWithString:income];
        NSRange incomeRange = [[incomeFullStr string] rangeOfString:_estimate_total_interestValue];
        [incomeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:incomeRange];
        
        _total_incomeLabel.attributedText = incomeFullStr;
        
        
        
        if ([_progressValue isMemberOfClass:[NSNull class]]) {
            ;
        }else{
        // _invest_stateLabel.text = [NSString stringWithFormat:@"投资状态：%@",_model.invest_state];
        if ([_progressValue isEqualToString:@"募集失败"]) {
            NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_progressValue];
            NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
            NSRange stateRange = [[stateFullStr string] rangeOfString:_progressValue];
            [stateFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:stateRange];
            
            _invest_stateLabel.attributedText = stateFullStr;
        }else if([_progressValue isEqualToString:@"已结束"]){
            
            NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_progressValue];
            NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
            NSRange stateRange = [[stateFullStr string] rangeOfString:_progressValue];
            [stateFullStr addAttribute:NSForegroundColorAttributeName value:kcolorGreen range:stateRange];
            
            _invest_stateLabel.attributedText = stateFullStr;
            
            
            
            
        }else{
        /*
         *待审核', '募集中', '还款中'
         */
            
            NSString *state = [NSString stringWithFormat:@"%@%@",Invest_State,_progressValue];
            NSMutableAttributedString *stateFullStr = [[NSMutableAttributedString alloc] initWithString:state];
            NSRange stateRange = [[stateFullStr string] rangeOfString:_progressValue];
            [stateFullStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:stateRange];
            
            _invest_stateLabel.attributedText = stateFullStr;
            

        }
        
        }
        //_investment_release_start_timeLabel.text = [NSString stringWithFormat:@"计息日期：%@",_model.investment_release_start_time];
        
        NSString *start_time = [NSString stringWithFormat:@"%@%@",Investment_Release_Start_Time,_release_start_timeValue];
        NSMutableAttributedString *start_timeFullStr = [[NSMutableAttributedString alloc] initWithString:start_time];
        NSRange start_timeRange = [[start_timeFullStr string] rangeOfString:_release_start_timeValue];
        [start_timeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:start_timeRange];
        
        _investment_release_start_timeLabel.attributedText = start_timeFullStr;
        
        
        
        
        
        
        //_investment_release_end_timeLabel.text = [NSString stringWithFormat:@"到期日期：%@",_model.investment_release_end_time];
        
        NSString *end_time = [NSString stringWithFormat:@"%@%@",Investment_Release_End_Time,_release_end_timeValue];
        NSMutableAttributedString *end_timeFullStr = [[NSMutableAttributedString alloc] initWithString:end_time];
        NSRange end_timeRange = [[end_timeFullStr string] rangeOfString:_release_end_timeValue];
        [end_timeFullStr addAttribute:NSForegroundColorAttributeName value:kcolorFontGray range:end_timeRange];
        
        _investment_release_end_timeLabel.attributedText = end_timeFullStr;
        
        
        
              
        
        
        
        if ([[data objectForKey:@"list"]isKindOfClass:[NSArray class]]) {
            NSArray *listArr = [data objectForKey:@"list"];
            for (NSDictionary *lisDic in listArr) {
                RepaymentModel *model = [[RepaymentModel alloc]initWithDataDic:lisDic];
                
                [self.data addObject:model];
                NSLog(@"model%@",self.data);
                
            }
            NSLog(@"还款计划%@",self.data);
            //刷新表视图，回到主线程
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bottomView reloadData];
                
                
                [HUD hide:YES afterDelay:0.5];
                
            });
            
            
        }
        
    }else{
        
        [HUD hide:YES afterDelay:0.5];
        
    }
    
    [HUD hide:YES afterDelay:0.5];
    
 
    
    
    
        
        
       }

#pragma mark 创建上半部分视图
- (void)custumTopView{

    
    _bottomView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64.5, kScreenWidth, kScreenHeight-kNavigationBarHeight-0.5) style:UITableViewStylePlain];
    _bottomView.delegate = self;
    _bottomView.dataSource = self;
    //_bottomView.scrollEnabled = NO;
    [self.view addSubview:_bottomView];
//    
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(64);
//        make.bottom.equalTo(self.view);
//        
//    }];
//    
//
    
    
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 0.327*kScreenHeight);
    _bottomView.tableHeaderView = headerView;
    //[self.view addSubview:headerView];
//    
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_bottomView);
//        make.right.equalTo(_bottomView);
//        make.top.equalTo(_bottomView);
//        make.height.mas_equalTo(0.327*kScreenHeight);
//    }];
//    
    
    
    
    int padding;
    int rightPadding =0.031*kScreenWidth;
    int height = 0.019*kScreenHeight;
    //int fontHeight =  0.019*kScreenHeight;
    int fontHeight;
    if (kScreenWidth == 320) {
        padding = 0.031*kScreenWidth;
        fontHeight =36/3;
    }else{
        padding = 0.056*kScreenWidth;
        fontHeight =41/3;
    }
    
    
    
    
    UIView *topView =[UIView new];
    topView.backgroundColor =RGB(235, 235, 235, 1);
    
    [headerView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left);
        make.right.equalTo(headerView.mas_right);
        make.top.equalTo(headerView.mas_top);
        make.height.mas_equalTo(0.018*kScreenHeight);
    }];
    
    
    
    //名称
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:48/3];
    [headerView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(0.029*kScreenHeight);
        make.left.equalTo(headerView).offset(0.056*kScreenWidth);
        make.right.equalTo(headerView).offset(-0.031*kScreenWidth);
        make.height.mas_equalTo(0.022*kScreenHeight);
        
    }];
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor = kcolorGrayNew;
    [headerView addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(0.029*kScreenHeight);
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.height.mas_equalTo(@1);
        
        
    }];
    
    
    
    
    
    /*
     *投资金额
     */
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.font = Font(fontHeight);
    [headerView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineGray.mas_bottom).offset(0.034*kScreenHeight);
        make.left.equalTo(headerView).offset(padding);
        make.right.equalTo(headerView.mas_centerX);
        make.height.mas_equalTo(0.019*kScreenHeight);
        
    }];
    
    
    //    /*
    //     *预计年化收益
    //     */
    //
    _invest_annualLabel = [[UILabel alloc]init];
    _invest_annualLabel.font = Font(fontHeight);
    [headerView addSubview:_invest_annualLabel];
    [_invest_annualLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineGray.mas_bottom).offset(0.034*kScreenHeight);
        make.left.equalTo(headerView.mas_centerX).offset(padding);
        make.right.equalTo(headerView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
        
    }];
    
    
    
    /*
     *预计收益
     */
    _total_incomeLabel =  [UILabel new];
    _total_incomeLabel.font = Font(fontHeight);
    [headerView addSubview:_total_incomeLabel];
    
    [_total_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(padding);
        make.top.equalTo(_moneyLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.right.equalTo(headerView.mas_centerX);
        make.height.mas_equalTo(height);
        
        
    }] ;
    
    /*
     *还款状态
     */
    _invest_stateLabel =  [UILabel new];
    _invest_stateLabel.font = Font(fontHeight);
    [headerView addSubview:_invest_stateLabel];
    
    [_invest_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_invest_annualLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(headerView.mas_centerX).offset(padding);
        make.right.equalTo(headerView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
    }] ;
    
    /*
     *计息开始时间
     */
    _investment_release_start_timeLabel =  [UILabel new];
    _investment_release_start_timeLabel.font = Font(fontHeight);
    [headerView addSubview:_investment_release_start_timeLabel];
    
    [_investment_release_start_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_total_incomeLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(headerView).offset(padding);
        make.right.equalTo(headerView.mas_centerX);
        make.height.mas_equalTo(height);
        
        
        
        //
    }] ;
    
    /*
     *计息结束
     */
    _investment_release_end_timeLabel =  [UILabel new];
    _investment_release_end_timeLabel.font = Font(fontHeight);
    [headerView addSubview:_investment_release_end_timeLabel];
    
    [_investment_release_end_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_invest_stateLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.left.equalTo(headerView.mas_centerX).offset(padding);
        make.right.equalTo(headerView).offset(rightPadding);
        make.height.mas_equalTo(height);
        
        //
    }] ;
  
    //线
    UILabel *lineTop = [UILabel new];
   lineTop.backgroundColor = kcolorGrayNew;
    [headerView addSubview:lineTop];
    [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_investment_release_start_timeLabel.mas_bottom).offset(0.035*kScreenHeight);
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.height.mas_equalTo(@1);
        
        
    }];
    
    
    
    

    NSArray *typeArr = @[@"还款日期",@"还款金额",@"支付状态"];
    for (int i = 0; i<3; i++) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font =Font(0.02*kScreenHeight);
        lab.frame = CGRectMake(((kScreenWidth-2)/3)*i+i, 0.289*kScreenHeight, (kScreenWidth-2)/3, 0.02*kScreenHeight);
        lab.text = typeArr[i];
      
        [headerView addSubview:lab];
        
    }
    
    
    for (int j = 1; j<3; j++) {
        UILabel *labline = [[UILabel alloc]init];
        labline.backgroundColor =kcolorGrayNew;
        labline.frame = CGRectMake(((kScreenWidth-2)/3)*j+j-1, 0.271*kScreenHeight, 1, 0.056*kScreenHeight);
        
        [headerView addSubview:labline];
    }
    
    //线
    UILabel *lineBottom = [UILabel new];
    lineBottom .backgroundColor = kcolorGrayNew;
    [headerView addSubview:lineBottom ];
    [lineBottom  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTop.mas_bottom).offset(0.056*kScreenHeight);
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.height.mas_equalTo(@1);
        
        
    }];

    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"Repayment_Plan_Cell";
    
    RepaymentPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        cell = [[RepaymentPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    RepaymentModel *model = self.data[indexPath.row];
    cell.model = model;
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 0.071*kScreenHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1;
    

}
#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
