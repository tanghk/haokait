//
//  BestUserTableview.m
//  555
//
//  Created by otouzi on 15/10/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BestUserTableview.h"
#import "BestUserCell.h"
#import "UICommons.h"
#import "DetailViewController.h"
#import "UIView+UIViewController.h"
#import "AFNetworking.h"//网络请求
#import "MJRefresh.h"
#import "NewbieController.h"

#import "HasInvestedBieController.h"
#import "NewUerBieController.h"
#import "Masonry.h"
@implementation BestUserTableview

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
           [self createHeaderView];//头视图
       self.delegate = self;
        self.dataSource = self;
        self.data = [NSMutableArray array];
     
        
        
        
        
        
        
       // [self.data removeObjectsInArray:self.data];//移除筛选的数据
        //[self loadData];
        self.showsVerticalScrollIndicator = NO;//滑动条隐藏
        [self  setSeparatorStyle:UITableViewCellSeparatorStyleNone];//分割线
         }
    return self;

}

//#warning This is 旭哥
//- (void)setData:(NSMutableArray *)data {
//    
//    _data = data;
//   
//    
//   [self reloadData];
//    
//}

//创建头视图，展示活动图片
-(void)createHeaderView{
 
 
}
// 代理
- (void)changeBtnTitle:(NSString *)str{
    
    NSLog(@"==== %@",str);
    
    //headerImageView.backgroundColor = [UIColor magentaColor];
}

#pragma mark - 优质散表用户tableview 代理，代理源方法
//优质散户retailInvestorTableView  dataSorce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//       NSLog(@"------%ld",self.data.count);
    return self.data.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *indentifier = @"Best_User_Cell";
    BestUserCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
//    if (cell==nil) {
    
        cell = [[BestUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"BestUserCell"
//                                             owner:self
//                                           options:nil]lastObject];
        
  //  }
    ListModel *model =self.data[indexPath.row];
    
    cell.model =model;
    //cell.textLabel.text = @"优质散表";
  //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
   

    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 214*kWidthScale;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indexp = indexPath;

    ListModel *model =self.data[indexPath.row];
    NSString * login=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];//是否登录状态
    
    int loginStatus = [login intValue];
   

    if ([model.way_repayment_key intValue] ==4 ) {
        
    
        if (loginStatus ==200) {
            
            
            if ([model.is_novice intValue]==0) {//true 没投资1  false 投了0
                /*
                 HasInvestedBieController *hasInvest  =[[HasInvestedBieController alloc]init];
                 CATransition *animation = [CATransition animation];
                 animation.duration = 0.5;
                 animation.timingFunction = UIViewAnimationCurveEaseInOut;
                 animation.type = @"pageCurl";
                 animation.type = kCATransitionPush;
                 animation.subtype = kCATransitionFromRight;
                 [self.window.layer addAnimation:animation forKey:nil];
                 [self.viewController presentViewController:hasInvest animated:NO completion:nil];
                 
                 */
                HasInvestedBieController *hasInvest  =[[HasInvestedBieController alloc]init];
                hasInvest.hidesBottomBarWhenPushed = YES;
                [self.viewController.navigationController pushViewController:hasInvest animated:YES];
                
            }else{
                /*
                 NewbieController *newbie = [[NewbieController alloc]init];
                 newbie.model = model;
                 CATransition *animation = [CATransition animation];
                 animation.duration = 0.5;
                 animation.timingFunction = UIViewAnimationCurveEaseInOut;
                 animation.type = @"pageCurl";
                 animation.type = kCATransitionPush;
                 animation.subtype = kCATransitionFromRight;
                 [self.window.layer addAnimation:animation forKey:nil];
                 [self.viewController presentViewController:newbie animated:NO completion:nil];
                 */
                NewUerBieController *newUser =[[NewUerBieController alloc]init];
                newUser.model = model;
                newUser.hidesBottomBarWhenPushed = YES;
                [self.viewController.navigationController pushViewController:newUser animated:YES];
                
   
            }
            

        }else{
            

            /*
             *未登录状态
             */
            NewUerBieController *newUser =[[NewUerBieController alloc]init];
            newUser.model = model;
            newUser.hidesBottomBarWhenPushed = YES;
            [self.viewController.navigationController pushViewController:newUser animated:YES];
            
            

            
        
        }
        
        
        
    }else{
    /*
        DetailViewController *detailViewController  = [[DetailViewController alloc]init];
        detailViewController.model = model;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.window.layer addAnimation:animation forKey:nil];
        [self.viewController presentViewController:detailViewController animated:NO completion:nil];

    */
        
        DetailViewController *detailViewController  = [[DetailViewController alloc]init];
        detailViewController.model = model;
        detailViewController.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:detailViewController animated:YES];
        
        

        
 }
  

}


@end
