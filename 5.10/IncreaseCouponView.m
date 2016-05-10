//
//  IncreaseCouponView.m
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "IncreaseCouponView.h"
#import "UICommons.h"
#import "Masonry.h"
#import "IncreaseCouponCell.h"
#import "IncreaseCouponModel.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
@implementation IncreaseCouponView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.data = [NSMutableArray array];
        
        self.showsVerticalScrollIndicator = NO;//滑动条隐藏
      //  [self cunstumFooter];
        
    }
    return self;
    
}
- (void)cunstumFooter{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 101)];
    
    
    self.tableFooterView = footerView;
    
    
    
    _investButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_investButton setTitle:@"去投资" forState:UIControlStateNormal];
    
    _investButton.titleLabel.font = [UIFont systemFontOfSize:30/2];
    [_investButton addTarget:self
                      action:@selector(investAction:)
            forControlEvents:UIControlEventTouchUpInside];
    _investButton.backgroundColor = kColorMain;
    [footerView addSubview:_investButton];
    
    [_investButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(footerView.mas_left).offset(12);
        make.right.equalTo(footerView.mas_right).offset(-12);
        make.top.equalTo(footerView.mas_top).offset(24);
        make.height.mas_equalTo(53);
        
        
        
        
        
        
    }];
    
}

- (void)setData:(NSMutableArray *)data {
    
    _data = data;
    
    
    
    [self reloadData];
    
}



#pragma mark - 优质散表用户tableview 代理，代理源方法
//优质散户retailInvestorTableView  dataSorce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"------%ld",self.data.count);
    return self.data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"Increase_Coupon_Cell";
    IncreaseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        
        cell = [[IncreaseCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
        //        cell = [[[NSBundle mainBundle]loadNibNamed:@"BestUserCell"
        //                                             owner:self
        //                                           options:nil]lastObject];
        
    }
    IncreaseCouponModel *model =self.data[indexPath.row];
    //
    cell.model =model;
    //cell.textLabel.text = @"优质散表";
    //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 342/2;
    
    
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 1;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}
//TODO:
- (void)investAction:(UIButton *)sender{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色字体
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backController" object:self];//页面跳转
    
}



@end
