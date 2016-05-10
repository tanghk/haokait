//
//  BestUserCell.m
//  555
//
//  Created by otouzi on 15/10/21.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BestUserCell.h"
//#import "UIImageView+WebCache.h"//加载网络图片
#import "UICommons.h"
#import<QuartzCore/QuartzCore.h>
#import "DetailViewController.h"
#import "UIView+UIViewController.h"
@implementation BestUserCell
#define pi 3.14159265359


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self createProgressView];//圆形进度条
        [self createSubViews];//产品类型 ，
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中效果
        //_nameLabel.text = self.model.name;
    }

    return self;

}
- (void)setModel:(ListModel *)model{
    _model = model;
    

    //可投资金额
    CGFloat st = [_model.money floatValue];
    CGFloat sr =[_model.total_invest_money floatValue];
    _difference = (st - sr);
    _scale =sr/st;
    NSLog(@"比例%.2f",_scale);
    _shapePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake((122*kWidthScale)/2, (122*kWidthScale)/2) radius:((122*kWidthScale)/2)-1 startAngle:-M_PI/2 endAngle:2*(M_PI)*_scale*i/2-(M_PI/2) clockwise:YES];
    /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
    _shapeLayer.path=_shapePath.CGPath;
    
//    [self setNeedsDisplay];

    _nameLabel.text = model.name;
    
    
    double revenue =  [model.revenue  doubleValue];
    _revenueLabel.text = [NSString stringWithFormat:@"%.1f%%",revenue];
    _deadlineLabel.text = model.deadline;
   
    _remainMonetyLabel.text =[NSString stringWithFormat:@"%d",(int)_difference];//取整形
    
    
    NSString*increase = [NSString stringWithFormat:@"%@",model.increase] ;
    
    double increasenum =  [increase  doubleValue];
    _increaseLabel.text = [NSString stringWithFormat:@" +%.1f%%",increasenum];
    _increaseLabel.textAlignment = NSTextAlignmentCenter;

    
    
    
    if ([increase isEqualToString:@"0"]||[increase isEqualToString:@"0.0"]||[increase isEqualToString:@"0.00"]) {
        _increaseLabel.hidden = YES;
    }

    
    _way_repaymentLabel.text = model.way_repayment;
    _way_repayment_key = model.way_repayment_key;;
    if ([_way_repayment_key intValue] ==4) {
       
        _touziButton.backgroundColor =RGB(255, 81, 50, 1);
        _nameLabel.textColor = RGB(255, 81, 50, 1);
        _newcomerImageView.hidden = NO;
        _shapeLayer.lineWidth = 0;
        _prgrossView.layer.borderWidth =0;
        _remainMonetyLabel.text = @"";
         _remainTitleLabel.text = @"";
        _lineImageView.hidden = YES;
        _revenueLabel.textColor = kColorOrange;
         _typeImageView.frame = CGRectMake((24+122+38+134+16)*kWidthScale, 38*kWidthScale, 72*kWidthScale, 28*kWidthScale);
        _increaseLabel.hidden = YES;
       //_way_repaymentLabel.text = @"";
    _typeImageView.image =[UIImage imageNamed:@"newIcon"];
    }else{
        _touziButton.backgroundColor =kColorRed;
        _nameLabel.textColor = [UIColor blackColor];
        _newcomerImageView.hidden = YES;
        _shapeLayer.lineWidth = 3;
        _prgrossView.layer.borderWidth =3;
        // _way_repaymentLabel.text = model.way_repayment;
         _remainTitleLabel.text = @"可投金额";
        UIImage *lineImage = [UIImage imageNamed:@"roundBorderBg"];
        _lineImageView.image = lineImage;
        _revenueLabel.textColor = kColorRed;
        _increaseLabel.hidden = NO;
 _typeImageView.frame = CGRectMake((24+122+38+264+16)*kWidthScale, 38*kWidthScale, 72*kWidthScale, 28*kWidthScale);
     
        if ([increase isEqualToString:@"0"]||[increase isEqualToString:@"0.0"]) {
              _increaseLabel.hidden = YES;
        }
        
    }
    
    
    
}


//创建页面子视图
- (void)createSubViews{

   
    //圆形进度条
    _prgrossView = [[UIView alloc]initWithFrame:CGRectMake(24*kWidthScale, 42*kWidthScale, 122*kWidthScale, 122*kWidthScale)];
    _prgrossView.backgroundColor = [UIColor whiteColor];
    UIColor *grayColor = RGB(180, 180, 180, 1);
    _prgrossView.layer.borderColor = grayColor.CGColor;
    _prgrossView.layer.masksToBounds = YES;
        _prgrossView.layer.cornerRadius =(122*kWidthScale)/2;
    
    [self.contentView addSubview:_prgrossView];

    i = 0;
    /**创建带形状的图层*///CAShapeLayer
    _shapeLayer=[CAShapeLayer layer];
    _shapeLayer.frame=_prgrossView.frame;
    _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    
   // _shapePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake((122*kWidthScale)/2 ,(122*kWidthScale)/2) radius:((122*kWidthScale)/2)-1.5 startAngle:0 endAngle:0 clockwise:YES];
    //  (50,50) _prgrossView的中心点   radius 半径 _prgrossView.layer.borderWidth = 5 会有一半2.5占用_prgrossView的半径50的圆面积  另外一半在圆外面  个人认为  50 - 2.5 = 47.5  startAngle  开始 endAngle 结束 clockwise 顺时针
    
    /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
    _shapeLayer.path=_shapePath.CGPath;
   
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    UIColor *coloer =RGB(212, 73, 85, 1);
    _shapeLayer.strokeColor = coloer.CGColor;
    
    _shapeLayer.fillColor=[UIColor clearColor].CGColor;
    
    [self.contentView.layer addSublayer:_shapeLayer];

    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];

    
    //可投资金额
    
    _remainMonetyLabel = [[UILabel alloc]init];
    _remainMonetyLabel.frame = CGRectMake(24*kWidthScale, (42+30)*kWidthScale, 122*kWidthScale, 20*kWidthScale);
    _remainMonetyLabel.textColor = RGB(212, 73, 85, 1);
    //_remainMonetyLabel.layer.borderWidth = 1;
    _remainMonetyLabel.font = [UIFont systemFontOfSize:20*kWidthScale];
    _remainMonetyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_remainMonetyLabel];
    
    //进度条中的分割线
    _lineImageView = [[UIImageView alloc]init];
    _lineImageView.frame = CGRectMake((24+24)*kWidthScale, (42+30+20+11)*kWidthScale, 72*kWidthScale, 1*kWidthScale);
      [self.contentView addSubview:_lineImageView];
    
    
    //可投资金额标题
    _remainTitleLabel = [[UILabel alloc]init];
    _remainTitleLabel.frame = CGRectMake(24*kWidthScale, (42+30+20+12+10)*kWidthScale, 122*kWidthScale, 18*kWidthScale);
    _remainTitleLabel.textColor = RGB(212, 73, 85, 1);
   // _remainTitleLabel.layer.borderWidth = 1;
   
    _remainTitleLabel.textAlignment = NSTextAlignmentCenter;
    _remainTitleLabel.font = [UIFont systemFontOfSize:18*kWidthScale];
    [self.contentView addSubview:_remainTitleLabel];
  
    
    
    _newcomerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24*kWidthScale, 42*kWidthScale, 122*kWidthScale, 122*kWidthScale)];
    [_newcomerImageView setImage:[UIImage imageNamed:@"ProductsList91"]];

    [self.contentView insertSubview:_newcomerImageView aboveSubview:_prgrossView];
    

    
    
    
    
    //产品名称
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake((24+122+38)*kWidthScale, 38*kWidthScale, kScreenWidth-42*kWidthScale-(24+122+38)*kWidthScale, 24*kWidthScale);
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:24/2];
    
    [self.contentView addSubview:_nameLabel];
    
    
    //新手标图片
//    _typeImageView = [[UIImageView alloc]init];
//    //_typeImageView.frame = CGRectMake((24+122+38+264+16)*kWidthScale, 38*kWidthScale, 72*kWidthScale, 28*kWidthScale);
//   
//    
//    [self.contentView addSubview:_typeImageView];
    

    //年华收益
    _revenueLabel = [[UILabel alloc]init];
    _revenueLabel.frame = CGRectMake((24+122+38)*kWidthScale, (10+38+42)*kWidthScale, 142*kWidthScale, 42*kWidthScale);
    
    _revenueLabel.font = [UIFont systemFontOfSize:42*kWidthScale];
    //_revenueLabel.textAlignment = NSTextAlignmentCenter;
    //_revenueLabel.layer.borderWidth=1;
    _revenueLabel.textColor = RGB(212, 75, 90, 1);
    [self.contentView addSubview:_revenueLabel];
    
 
    
    //年化收益textlabel
    UILabel *revenueTextLabel = [[UILabel alloc]init];
    revenueTextLabel.frame = CGRectMake((24+122+38)*kWidthScale,(24+38+43+42)*kHeightScale, 82/2, 20*kHeightScale);
    revenueTextLabel.text = @"年化收益";
    revenueTextLabel.textColor = RGB(180, 180, 180, 1);
    revenueTextLabel.font = [UIFont systemFontOfSize:20/2];
    revenueTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:revenueTextLabel];
    
    if (iphone4x_3_5) {
          revenueTextLabel.frame = CGRectMake((24+122+38)*kWidthScale,(48+38+43+42)*kHeightScale, 82/2, 20*kHeightScale);
    }else{
        
        revenueTextLabel.frame = CGRectMake((24+122+38)*kWidthScale,(24+38+43+42)*kHeightScale, 82/2, 20*kHeightScale);
        
    }
    
    
    
    
   // 奖励升级（角标）
    _increaseLabel = [[UILabel alloc]init];
    _increaseLabel.frame = CGRectMake((24+122+38+142+4)*kWidthScale, (10+38+43+8)*kWidthScale, 76/2, 31/2);
    //_increaseLabel.text = @"  +0.2%";
    _increaseLabel.font = [UIFont systemFontOfSize:18/2];
    _increaseLabel.textColor = RGB(255, 255, 255, 1);
    //_increaseLabel.textAlignment = NSTextAlignmentRight;
    _increaseLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"percentBg"]];
    


    [self.contentView addSubview:_increaseLabel];
    
    
    //投资期限
    
    _deadlineLabel = [[UILabel alloc]init];
    _deadlineLabel.frame = CGRectMake((24+122+38+72+190-15)*kWidthScale, (28+28+40)*kWidthScale, 105/2, 32*kWidthScale);
    _deadlineLabel.font = [UIFont systemFontOfSize:32/2];
    _deadlineLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_deadlineLabel];
    
    
    //投资期限textlabel
    
    UILabel *delineTextLabel = [[UILabel alloc]init];
    delineTextLabel.frame = CGRectMake((24+122+38+72+190)*kWidthScale, (24+38+43+42)*kHeightScale, 80/2, 20*kHeightScale);
    delineTextLabel.text = @"投资期限";
    delineTextLabel.textColor = RGB(180, 180, 180, 1);
    delineTextLabel.font = [UIFont systemFontOfSize:20/2];
    [self.contentView addSubview:delineTextLabel];
    
    if (iphone4x_3_5) {
         delineTextLabel.frame = CGRectMake((24+122+38+72+190)*kWidthScale, (48+38+43+42)*kHeightScale, 80/2, 20*kHeightScale);
    }else{
    
     delineTextLabel.frame = CGRectMake((24+122+38+72+190)*kWidthScale, (24+38+43+42)*kHeightScale, 80/2, 20*kHeightScale);
    
    
    }
    //去投资button

    
//    _touziButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _touziButton.frame = CGRectMake(kScreenWidth-42*kWidthScale-115*kWidthScale, 88*kWidthScale, 115/2, 47/2);
//    
//    _touziButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"productListRBg"]];
//    
//    [_touziButton setTitle:@"去投资" forState:UIControlStateNormal];
//    _touziButton.titleLabel.font = [UIFont systemFontOfSize: 12.0];
//    [_touziButton addTarget:self
//                     action:@selector(touziButtonAction:)
//           forControlEvents:UIControlEventTouchUpInside];
//
    
        _touziButton = [[UILabel alloc]init];
        _touziButton.frame = CGRectMake(kScreenWidth-42*kWidthScale-115*kWidthScale, 80*kHeightScale, 115/2, 47/2);
    
        _touziButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"productListRBg"]];
        _touziButton.text = @"去投资";
        _touziButton.textColor = [UIColor whiteColor];
        _touziButton.textAlignment = NSTextAlignmentCenter;
        _touziButton.font = [UIFont systemFontOfSize:12.0];
       [self.contentView addSubview:_touziButton];

    
    //还款方式
    _way_repaymentLabel = [[UILabel alloc]init];
    _way_repaymentLabel.frame = CGRectMake(kScreenWidth-24*kWidthScale-150*kWidthScale, (88+47+14)*kHeightScale, 150/2, 20*kHeightScale);
    _way_repaymentLabel.font=[UIFont systemFontOfSize:18/2];
    _way_repaymentLabel.textColor = RGB(103, 101, 113, 1);
    _way_repaymentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_way_repaymentLabel];
    
    if (iphone5x_4_0) {
        _way_repaymentLabel.frame = CGRectMake(kScreenWidth-32*kWidthScale-150*kWidthScale, (88+47+14)*kHeightScale, 150/2, 20*kHeightScale);
    }else if (iphone4x_3_5){
    
    
        _way_repaymentLabel.frame = CGRectMake(kScreenWidth-24*kWidthScale-150*kWidthScale, (48+64+47+14)*kHeightScale, 150/2, 20*kHeightScale);

    
    }
    //cell底部颜色
    UIImageView *footerImageView =[[UIImageView alloc]init];
    footerImageView.frame = CGRectMake(0, (214-10)*kWidthScale, kScreenWidth, 10*kWidthScale);
    footerImageView.backgroundColor = RGB(245, 245, 245, 1);
    
    [self.contentView addSubview:footerImageView];


}


//圆形进度条
- (void)updateProgressCircle
{
    //控制一下i的值  把i的值跟弧度起始位置进行关联  就能控制弧度的时间   这个是瞬间的
    i = i + 1;
    
    if (i > 2)
    {
        [_timer invalidate];
//        i = 0;
    }
    else
    {
         _shapePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake((122*kWidthScale)/2, (122*kWidthScale)/2) radius:((122*kWidthScale)/2)-1 startAngle:-M_PI/2 endAngle:2*(M_PI)*_scale*i/2-(M_PI/2) clockwise:YES];
        /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
        _shapeLayer.path=_shapePath.CGPath;
    }
    
}

//投资按钮点击事件
- (void)touziButtonAction:(UIButton *)sender {
    
//   _detailViewController  = [[DetailViewController alloc]init];
//    _detailViewController.model = _model;
//    
//    NSLog(@"detailViewController.model=%@",_detailViewController.model);
//    _detailViewController.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:_detailViewController animated:YES];
//   
//    
//    NSLog(@"加载网页");
//    
//    
//    
//    
//    //    NSLog(@"detailViewController.model=%@",detailViewController.model);
//    //    detailViewController.hidesBottomBarWhenPushed = YES;
//    //    [self.viewController.navigationController pushViewController:detailViewController animated:YES];
//    //
//    
//    NSLog(@"加载网页");
//    
//    
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromRight;
//    [self.window.layer addAnimation:animation forKey:nil];
//    
//    [self.viewController presentViewController:_detailViewController  animated:NO completion:nil];
//    
    
   }
@end
