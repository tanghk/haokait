//
//  BestUserCell.h
//  555
//
//  Created by otouzi on 15/10/21.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "DetailViewController.h"
@interface BestUserCell : UITableViewCell
{
    float i;//圆形进度条的弧度
    CGFloat _scale ;//比例
    CGFloat _difference;//差
    UIBezierPath *_shapePath;
    CAShapeLayer *_shapeLayer; //圆形进度条
    NSTimer *_timer;//定时器
    
   
    UILabel *_remainTitleLabel;//可投资金额标题
    UILabel *_remainMonetyLabel;//可投资金额label
    
    UILabel *_nameLabel;//产品名称
    UIImageView *_typeImageView;//新手标
   // UILabel *_productTypeLabel;//投资类型
    
    UILabel *_revenueLabel;//年化收益
    UILabel *_increaseLabel;// 奖励升级（角标）
    
    UILabel *_deadlineLabel;//投资期限
    
    
    UILabel *_touziButton;//去投资
    UILabel *_way_repaymentLabel; // 还款方式
    DetailViewController *_detailViewController;
  
    NSString *_way_repayment_key;//还款方式
    
    UIView *_prgrossView;//圆环的背景图
    
    UIImageView *_newcomerImageView;//新手标图片
    
    UIImageView *_lineImageView;//进度条中的分割线
    
}
    
    
    @property (nonatomic, strong)ListModel *model;
    

  
    

@property (nonatomic, strong) NSTimer *timer;


@end
