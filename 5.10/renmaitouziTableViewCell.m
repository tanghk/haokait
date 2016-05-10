//
//  renmaitouziTableViewCell.m
//  555
//
//  Created by 李浩宇 on 15/12/30.
//  Copyright © 2015年 李浩宇. All rights reserved.
//
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#import "renmaitouziTableViewCell.h"

@implementation renmaitouziTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setModel:(renmaitouzimodel *)model
{
    
    long a = [model.created_at longLongValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd      HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    self.time.text = [NSString stringWithFormat:@"奖励发放时间：%@",confromTimespStr];
    self.time.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    self.time.font = [UIFont systemFontOfSize:12];
    
    
    self.name.text = model.username;
    self.name.font = [UIFont systemFontOfSize:14];

    
    self.jjine.text = [NSString stringWithFormat:@"%@元/",model.in_money];
    if (__kScreenHeight__ == 568) {
        self.jjine.font = [UIFont systemFontOfSize:12];
    }else if (__kScreenHeight__ >= 667)
    {
         self.jjine.font = [UIFont systemFontOfSize:13];
        
    }
    self.jjine.textAlignment = NSTextAlignmentRight;
    self.jjine.textColor = [UIColor colorWithRed:198/255.0 green:52/255.0 blue:71/255.0 alpha:1];
    self.dengji.text = [NSString stringWithFormat:@"%@",model.deadline];
    self.dengji.textAlignment =NSTextAlignmentLeft;
    
    
    self.zhuangtai.text = [NSString stringWithFormat:@"%@元",model.money];
    self.zhuangtai.textAlignment = NSTextAlignmentRight;
    self.zhuangtai.textColor = [UIColor colorWithRed:198/255.0 green:52/255.0 blue:71/255.0 alpha:1];
    
}

@end
