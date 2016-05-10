//
//  CashCouponCell.m
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "CashCouponCell.h"
#import "UICommons.h"
#import "UIViewExt.h"
#import "Masonry.h"

@implementation CashCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCouponsContentView];//创建子cell的方法
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setModel:(CashCouponModel *)model{
    _model = model;
    
    _parLabel.text = _model.par;
    _state = [NSString stringWithFormat:@"%@",_model.state];
    _nameLabel.text =[NSString stringWithFormat:@"%@",_model.descriptionDetail];
    //state判断状态，0为未使用，1位使用，2为过期
    if ([_state  isEqualToString:@"0"]) {
        _bgView.image = [UIImage imageNamed:@"redPacketRedBg2"];

        //[_bgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"redPacketRedBg2"]]];
        _nameLabel.textColor = RGB(255, 241, 176, 1);
        
    }else if ([_state isEqualToString:@"1"]){
        _bgView.image = [UIImage imageNamed:@"redPacketusedBg2"];

        //[_bgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"redPacketusedBg2"]]];
        _nameLabel.textColor = RGB(211, 211, 211, 1);

        
    }else if ([_state isEqualToString:@"2"]){
        _bgView.image = [UIImage imageNamed:@"redPacketExpiredBg2"];
        

       // [_bgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"redPacketExpiredBg2"]]];
        _nameLabel.textColor = RGB(235, 235, 235, 1);
        

        
        
        
    }
    
    
    
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[_model.expired_time floatValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *regStr = [df stringFromDate:dt];
    
    
    //  NSString *dateString= [regStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    // NSString *timeStr = [dateString substringFromIndex:2];
    _expired_timeLabel.text = [NSString stringWithFormat:@"有效期至%@", regStr];
    
    
    
    
}

#pragma mark - 子视图的内容
- (void)createCouponsContentView{
    
    /*
     *背景
     */
    _bgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_bgView];

    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(45/2);
        make.left.equalTo(self.contentView).offset(21);
        make.right.equalTo(self.contentView).offset(-21);
        make.height.mas_equalTo(252/2);
        
    }];
    
    
    /*
     *name
     */
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = Font(13);
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(77);
        make.top.equalTo(_bgView.mas_top).offset(18);
        make.height.mas_equalTo(13);
    }];
    
    
    
    /*
     *金额
     */
    
    _parLabel = [[UILabel alloc]init];
    _parLabel.font = [UIFont boldSystemFontOfSize:52/2];
    _parLabel.textAlignment = NSTextAlignmentCenter;
    _parLabel.textColor = kColorWhite;
    [_bgView addSubview:_parLabel];
    
    [_parLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.centerY.equalTo (_bgView.mas_centerY);
        make.height.mas_equalTo(52/2);
    }];
    
    
    /*
     *单位(元)
     */
    
    UILabel *units = [[UILabel alloc]init];
    
    units.font = [UIFont systemFontOfSize:34/2];
    units.textColor = kColorWhite;
    units.text = @"元";
    
    [_bgView addSubview:units];
    
    
    [units mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_parLabel.mas_bottom).offset(-2);
        make.left.equalTo(_parLabel.mas_right).offset(8);
        make.height.mas_equalTo(17);
        
    }];
    /*
     *提示
     */
    
    
    
    /*
     *优惠卷过期时间
     */
    _expired_timeLabel =[[UILabel alloc]init];
    _expired_timeLabel.textColor = kColorWhite;
    
    _expired_timeLabel.font = [UIFont systemFontOfSize:24/2];
    
    [_bgView addSubview:_expired_timeLabel];
    
    
    
    [_expired_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-20);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-18);
        make.height.mas_equalTo(12);
    }];
    
    
    
    /*
     *即将过期button
     */
    //    _expiredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _expiredButton.frame = CGRectMake(kScreenWidth-52*kWidthScale-146/2, _bgView.origin.x+_bgView.frame.size.height+24*kWidthScale, 146/2, 51/2);
    //    [_expiredButton setTitle:@"即将过期" forState:UIControlStateNormal];
    //    _expiredButton.titleLabel.font = [UIFont systemFontOfSize:24/2];
    //    [_expiredButton addTarget:self
    //                       action:@selector(expiredAction:)
    //             forControlEvents:UIControlEventTouchUpInside];
    //    _expiredButton.backgroundColor = kColorRed;
    //    [self.contentView addSubview:_expiredButton];
    
    
    
    /*
     *即将过期时间
     */
    
    //    _expired_time_bottomLabel =[[UILabel alloc]init];
    //    _expired_time_bottomLabel.frame = CGRectMake(_expiredButton.origin.x-17*kWidthScale-196/2, _bgView.origin.x+_bgView.frame.size.height+38*kWidthScale, 196/2, 23/2);
    //    _expired_time_bottomLabel.textColor = kColorWhite;
    //
    //    _expired_time_bottomLabel.font = [UIFont systemFontOfSize:23/2];
    //    _expired_time_bottomLabel.textColor = RGB(145, 145, 145, 1);
    //    [self.contentView addSubview:_expired_time_bottomLabel];
    
    
    
    
    
    
    
    
}



@end
