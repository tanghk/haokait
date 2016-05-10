//
//  NoramlBankCardCell.m
//  555
//
//  Created by otouzi on 16/4/15.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "NoramlBankCardCell.h"
#import "Masonry.h"
#import "UICommons.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
@implementation NoramlBankCardCell{
    UIImageView *_logoView;
    UILabel *_bankNameLab;
    UILabel *_cardNumberLabel;
    
}

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if ( self) {
        [self custumBankInfoViews];
       
           self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中效果
        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

    }


    return self;
    
}


- (void)setModel:(WithdrawModel *)model{


    _model = model;
    
    
    NSString *logo = _model.logo;
      [_logoView  sd_setImageWithURL:[NSURL URLWithString:logo]];
    
    
    if (![_model.bankname isKindOfClass:[NSString class]]) {
        
    }else{
    
        _bankNameLab.text = _model.bankname;

    
    }
    
    
    
    NSString *card =_model.card;
   // _cardNumberLabel.text = card;
    NSString *heard= [card substringToIndex:4];//截取掉下标7之后的字符串
    NSLog(@"截取的值为：%@",heard);
    NSString *footer=   [card substringFromIndex:card.length-4];//截取掉下标2之前的字符串
    NSLog(@"截取的值为：%@",footer);
    
    _cardNumberLabel.text = [NSString stringWithFormat:@"%@ **** **** %@",heard,footer];
    
   
    


}

- (void)custumBankInfoViews{


    _logoView = [UIImageView new];
    [self.contentView addSubview:_logoView];
    

    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(79/3);
        make.top.equalTo(self.contentView.mas_top).offset(49/3);
        make.width.mas_equalTo(72/3);
        make.height.mas_equalTo(72/3);
    }];
    
    
    
    
    _bankNameLab = [UILabel new];
    _bankNameLab.font =Font(43/3);
    [self.contentView addSubview:_bankNameLab];
   
    [_bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoView.mas_right).offset(41/3);
        make.top.equalTo(self.contentView.mas_top).offset(34/3);
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.height.mas_equalTo(43/3);
    }];
    
    
    
    
    
    _cardNumberLabel = [UILabel new];
    _cardNumberLabel.font = Font(36/3);
    UIColor *fontColor =RGB(150, 150, 150, 1);
    _cardNumberLabel.textColor = fontColor;
    [self.contentView addSubview:_cardNumberLabel];
    
    [_cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankNameLab.mas_left);
        make.right.equalTo(_bankNameLab.mas_right);
        make.top.equalTo(_bankNameLab.mas_bottom).offset(33/3);
        make.height.mas_equalTo(36/3);
    }];
    
    
    
    







}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
