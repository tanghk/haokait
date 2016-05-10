//
//  renmaiTableViewCell.m
//  555
//
//  Created by 李浩宇 on 15/12/29.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "renmaiTableViewCell.h"

@implementation renmaiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(renmaimodle *)model
{
    
    
    _model =model;
    long a = [_model.created_at longLongValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd      HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    self.time.text =[NSString stringWithFormat:@"邀请时间：%@",confromTimespStr];
    self.time.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    self.time.font = [UIFont systemFontOfSize:12];

    self.name.text = model.username;
    self.name.font = [UIFont systemFontOfSize:14];
    
    int b = [model.touzi intValue];
    
    if (b== 0) {
        self.zhaungtai.text = @"未投资";

        self.zhaungtai.textAlignment = NSTextAlignmentRight;
        self.zhaungtai.textColor = [UIColor colorWithRed:198/255.0 green:52/255.0 blue:71/255.0 alpha:1];
    }
    else if(b == 1)
    {
        self.zhaungtai.text = @"已投资";
        self.zhaungtai.textAlignment = NSTextAlignmentRight;
        self.zhaungtai.textColor = [UIColor colorWithRed:78/255.0 green:134/255.0 blue:12/255.0 alpha:1];
    }
    
    int c = [model.contacts intValue];
    if (c == 1) {
        self.dengji.text = @"一级人脉";
        
    }
    else if(c == 2)
    {
        self.dengji.text = @"二级人脉";
    }
    else if (c == 3)
    {
        self.dengji.text = @"三级人脉";
    }
}
@end
