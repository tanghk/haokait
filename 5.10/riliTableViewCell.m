//
//  riliTableViewCell.m
//  555
//
//  Created by 李浩宇 on 16/3/17.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "riliTableViewCell.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@implementation riliTableViewCell

- (void)awakeFromNib {
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setModel:(rilimodel *)model
{
    NSArray *array = [model.date componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组

    self.time.text = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
    self.time.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
    
    

    
    int a = [model.principal intValue];
    NSLog(@"%d",a);

    if (a == 0) {
        self.lilv.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
        
        self.lilv.font = [UIFont systemFontOfSize:14];
        
        NSInteger po = model.profit .length;
       
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"利息 %@元",model.profit]];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1] range:NSMakeRange(3,po)];
        
        
        self.lilv.attributedText = str;
    }else{
        self.lilv.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
        
        self.lilv.font = [UIFont systemFontOfSize:14];
        
        NSInteger po = model.profit .length;
         NSInteger po1 = model.principal.length;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"利息 %@元  本金 %@元",model.profit,model.principal]];
        
         [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1] range:NSMakeRange(3,po)];
         [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1] range:NSMakeRange(9 +po,po1)];
        
        self.lilv.attributedText = str;
    }
    
    
    
    self.type.text = model.state;
    self.type.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];

    
    
    self.monay.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
    NSInteger po1 = model.totalmoney.length;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共 %@元",model.totalmoney]];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1] range:NSMakeRange(1,po1+1)];
    self.monay.attributedText = str1;

    self.recalids.text = [NSString stringWithFormat:@"%@",model.name];
    
    
    
    
    
    
}
@end
