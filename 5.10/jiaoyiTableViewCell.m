//
//  jiaoyiTableViewCell.m
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "jiaoyiTableViewCell.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@implementation jiaoyiTableViewCell

- (void)awakeFromNib {
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(jiaoyimodel *)model
{
    
    
//    int b = [model.type intValue];
//    if (b == 0) {
//        self.jiaoyiclass.text = @"全部";
//    }
//    else if(b == 1)
//    {
//        self.jiaoyiclass.text = @"充值";
//    }
//    else if (b == 2)
//    {
//        self.jiaoyiclass.text = @"取现";
//    }
//    else if (b == 3)
//    {
//        self.jiaoyiclass.text = @"投资";
//    }
//    else if (b == 4)
//    {
//        self.jiaoyiclass.text = @"放款";
//    }
//    else if (b == 5)
//    {
//        self.jiaoyiclass.text = @"还款";
//    }
//    else if (b == 6)
//    {
//        self.jiaoyiclass.text = @"转账";
//    }
    
    self.jiaoyiclass.text = model.type;
    
    long a = [model.created_at longLongValue];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"YYYY-MM-dd   HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a];

    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];


    
    self.time.text =confromTimespStr;
    self.time.font = [UIFont systemFontOfSize:13];
    self.time.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
    
    self.messge.text = model.respcode;
    if (__kScreenHeight__ == 568) {
         self.messge.font = [UIFont systemFontOfSize:15];
    }
//
    self.messge.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
    
    
    
    //    self.jiaoyijine.textAlignment = NSTextAlignmentRight;
    NSString *sing = model.sign;
    int ci = [sing intValue];
    if (ci == 1) {
        self.jiaoyijine.text =[NSString stringWithFormat:@"+ %@元",model.transamt];
        self.jiaoyijine.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
        if (__kScreenHeight__ == 568) {
            self.jiaoyijine.font = [UIFont systemFontOfSize:15];
        }

    }else if(ci == 2)
    {
        self.jiaoyijine.text =[NSString stringWithFormat:@"- %@元",model.transamt];
        self.jiaoyijine.textColor = [UIColor colorWithRed:162/255.0 green:250/255.0 blue:46/255.0 alpha:1];
        if (__kScreenHeight__ == 568) {
            self.jiaoyijine.font = [UIFont systemFontOfSize:15];
        }

    }
//    self.keyongyue.text = [NSString stringWithFormat:@"可用余额：%@元",model.available];
//    self.keyongyue.textAlignment = NSTextAlignmentRight;
//    self.keyongyue.font = [UIFont systemFontOfSize:13];
//    self.keyongyue.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];

}


@end
