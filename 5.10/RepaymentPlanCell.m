//
//  RepatmentPlanCell.m
//  555
//
//  Created by otouzi on 16/3/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "RepaymentPlanCell.h"
#import "Masonry.h"
#import "UICommons.h"
@implementation RepaymentPlanCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custumRepaymentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
    
}
#pragma mark - set方法
- (void)setModel:(RepaymentModel *)model{
    
    
    _model = model;
    _paytimeLab.text = [NSString stringWithFormat:@"%@",_model.paytime];
    _profitLal.text = [NSString stringWithFormat:@"%@",_model.totalmoney];
    
  _stateStr =[NSString stringWithFormat:@"%@",_model.state];
    _stateLab.text = _stateStr;
    
    if ([_stateStr isEqualToString:@"未支付"]) {
        _stateLab.textColor =kcolorFontGray;
    }
    

//    _paytimeLab.text = _model.paytime;
//    _profitLal.text = _model.profit;
//    _stateLab.text = _model.state ;
//
//

}

#pragma mark - 自定义
- (void)custumRepaymentView{
    _paytimeLab = [UILabel new];
    _paytimeLab.textColor = kcolorFontGray;
    _paytimeLab.font = Font(0.019*kScreenHeight);
    _paytimeLab.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:_paytimeLab];
    
    _profitLal = [UILabel new];
    _profitLal.font = Font(0.019*kScreenHeight);

    _profitLal.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_profitLal];
    
    _stateLab = [UILabel new];
    _stateLab.font = Font(0.019*kScreenHeight);

    
    
    
    
    _stateLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_stateLab];

    
    
    
    
    [_paytimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(0.019*kScreenHeight);
        make.width.mas_equalTo(kScreenWidth/3);
        
    }];
    
    
    [_profitLal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_paytimeLab.mas_right);
       make.top.equalTo(self.contentView).offset(0.019*kScreenHeight);
        //make.right.equalTo(_stateLab.mas_left);
        make.width.equalTo(_paytimeLab);
        
        
    }];

    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
       make.top.equalTo(self.contentView).offset(0.019*kScreenHeight);
        make.width.equalTo(_paytimeLab);
    }];
    

    

    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
