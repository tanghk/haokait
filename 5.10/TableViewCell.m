//
//  TableViewCell.m
//  555
//
//  Created by 李浩宇 on 15/12/4.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {

   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BankModel *)model{

    self.backname.text = model.name;
    self.backname.font = [UIFont systemFontOfSize:13];
    self.logiurl = model.logo;
    
    //单笔
    NSString *danbi;
    int danbi2 = [model.single intValue];
    
    if (danbi2 == 0 )
    {
        danbi = @"无限额";
    }
    else
    {
        if ( danbi2 >10000) {
            
       
        float danbi1 =[model.single intValue]/10000;
        danbi = [NSString stringWithFormat:@"%.0f万", danbi1];
        }
        else
        {
            float danbi1 =[model.single intValue]/1000;
            danbi = [NSString stringWithFormat:@"%.0f千", danbi1];
        }
    }
    //单日
    NSString *danri;
    if ([model.day intValue]==0)
    {
        danri = @"无限额";
    }
    else
    {
        if ( [model.day intValue] >10000) {
            
            
            float danri1 =[model.day intValue]/10000;
            danri = [NSString stringWithFormat:@"%.0f万", danri1];
        }
        else
        {
            float danri1 =[model.day intValue]/1000;
            danri = [NSString stringWithFormat:@"%.0f千", danri1];
        }
    }
        //单月
    NSString *danyue;
    if ([model.month intValue]==0)
    {
        danyue = @"无限额";
    }
    else
    {
        if ( [model.month intValue] >10000) {
            
            
            float danyue1 =[model.month intValue]/10000;
            danyue = [NSString stringWithFormat:@"%.0f万", danyue1];
        }
        else
        {
            float danyue1 =[model.month intValue]/1000;
            danyue = [NSString stringWithFormat:@"%.0f千", danyue1];
        }
    }

    
    NSString *pinjie =[NSString stringWithFormat:@"单笔限额%@，单日限额%@",danbi,danri];
    
    self.some.text = pinjie;
    self.some.textAlignment = UITextAlignmentRight;
    
    if(__kScreenHeight__ == 568)
    { self.some.font = [UIFont systemFontOfSize:10];
        
    }else{
         self.some.font = [UIFont systemFontOfSize:12];
    }
   
    self.some.textColor = [UIColor grayColor];
    NSURL *  url1 = [NSURL URLWithString:self.logiurl];
    [self.logo setImageWithURL:url1 placeholderImage:nil];
}
@end
