//
//  NoticeCenterCell.m
//  555
//
//  Created by otouzi on 15/11/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "NoticeCenterCell.h"
#import "UICommons.h"
#import "UIViewExt.h"
@implementation NoticeCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
      
    }
    
    return self;
    
}

- (void)setModel:(NoticeModel *)model{

    _model = model;
   
    
    _titleLabel.text = model.title;
    
    //if (_titleLabel.text.length>=15) {
        //titleLabel 字数大于15，顶图标的frame为
        _titleLabel.frame =CGRectMake(48*kPlusScale, 72*kPlusHeightScale, 820*kPlusScale, 48*kPlusHeightScale);
    if (iphone5x_4_0) {
        _titleLabel.frame =CGRectMake(48*kPlusScale, 72*kPlusHeightScale, 790*kPlusScale, 48*kPlusHeightScale);

    }
       // _upImageView.frame = CGRectMake(_titleLabel.width+22*kPlusScale, 72*kPlusHeightScale, 40/3, 40/3);
        
//        
//        //        [_titleLabel setNumberOfLines:1];
//        //        [_titleLabel sizeToFit];
//        //        [self.contentView addSubview:_titleLabel];
//        
//        
//    }else if (_titleLabel.text.length <15) {
//        
//        _titleLabel.frame = CGRectMake(43*kPlusScale, 72*kPlusHeightScale, 50, 50);
//        
//        //titleLabel的长度小于15的时候，upimageView的frame值
//        
//        
//        [_titleLabel setNumberOfLines:1];
//        [_titleLabel sizeToFit];
//        _upImageView.frame = CGRectMake(_titleLabel.width+(46+22)*kPlusScale, 80*kPlusHeightScale, 40*kPlusScale, 40*kPlusHeightScale);
//        
//        
// 
//        
//    }


    _contentLabel.text = model.seo_description;
//    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[model.created_at floatValue]];
//    NSDateFormatter * df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd"];
//    NSString *regStr = [df stringFromDate:dt];
    //_timeLabel.text = regStr;
    NSString *dateString= [model.created_at stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
 // NSString *timeStr = [dateString substringFromIndex:2];
    _timeLabel.text = dateString;

    
}
//自定义分割线

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    ///Users/otouzi/Desktop/沃 投资1202（toghter）/CLLockVC.xib
    UIColor *lineColor = RGB(210, 210, 210, 1);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextStrokeRect(context, CGRectMake(44*kPlusScale, rect.size.height, rect.size.width - 2*44*kPlusScale, 1));

}
//创建子视图
- (void)createSubViews{
    //标题label
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(43*kPlusScale, 72*kPlusHeightScale, 50, 50);
    //_titleLabel.text = @"瓦匠工购买家具短期资金周转";
    
    _titleLabel.font = [UIFont systemFontOfSize:48/3                                                                                                                                                                                                                                                                                                                                                                                                                             ];
//    _upImageView  =[[UIImageView alloc]init];
//    [_upImageView setImage:[UIImage imageNamed:@"moreNoticeCIcon"]];
//    
//    [self.contentView addSubview:_upImageView];
    [self.contentView addSubview:_titleLabel];
    
    NSLog(@"%ld",_titleLabel.text.length);
    
    
    //时间label
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:45/3];
    //_timeLabel.text = @"2015/11/15";
  
    _timeLabel.frame = CGRectMake(kScreenWidth -(62+33)*kPlusScale-88, 75*kPlusHeightScale, 88, 48*kPlusHeightScale);
    
    
    [self.contentView addSubview:_timeLabel];//80位label的宽度
    
    
    //时间后的图片
    
    UIImageView *pointImageView = [[UIImageView alloc]init];
    pointImageView.frame = CGRectMake(kScreenWidth -(62)*kPlusScale, 75*kPlusHeightScale, 22*kPlusScale, 45*kPlusHeightScale);
    pointImageView.image = [UIImage imageNamed:@"moreNoticeSJIcon"];
    // pointImageView.layer.borderWidth = 1;
    [self.contentView addSubview:pointImageView];
    
    
    //内容label
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(46*kPlusScale, 190*kPlusHeightScale, kScreenWidth-(46+62)*kPlusScale, 150*kPlusHeightScale);//150为label的高度
    _contentLabel.font = [UIFont systemFontOfSize:24/2];
    //    _contentLabel.text = @"我今年52岁，家住辽宁省绥中县。妻子今年53岁，在家附近打零工，儿子开出租车。我们一家三口生活在一起，日子过的,ninnninininiin";
    
    _contentLabel.numberOfLines = 2;
    [self.contentView addSubview:_contentLabel];
   
}

//label 高度自适应
/*
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
 label.font = [UIFont boldSystemFontOfSize:20.0f];  //UILabel的字体大小
 label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
 label.textColor = [UIColor whiteColor];
 label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
 [label setBackgroundColor:[UIColor redColor]];
 
 //高度固定不折行，根据字的多少计算label的宽度
 NSString *str = @"高度不变获取宽度，获取字符串不折行单行显示时所需要的长度";
 CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
 NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
 //根据计算结果重新设置UILabel的尺寸
 [label setFrame:CGRectMake(0, 10, size.width, 20)];
 label.text = str;
 
 [self.view addSubview:label];
 
 
 */

@end
