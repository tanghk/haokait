//
//  rilitable.m
//  555
//
//  Created by 李浩宇 on 16/3/17.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "rilitable.h"
#import "riliTableViewCell.h"
#import "ViewController.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@implementation rilitable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    
    if (self) {
        self.data = [NSMutableArray array];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.allowsSelection = NO;
        
        
    }
    return self;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (__kScreenHeight__ == 568) {
        return 250*__kScreenHeight__/1334;
    }else
    {
        return 200*__kScreenHeight__/1334;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *indentifier = @"eeeeaa";
    riliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"riliTableViewCell"
                                         owner:self
                                       options:nil]lastObject];
    
    
    if (cell==nil) {
        
        cell = [[riliTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    if (indexPath.row<self.data.count) {
        rilimodel *model = self.data[indexPath.row];
        
        cell.model = model;
        return cell;
        
    }
    
    
    
    
    
    
    
    
    if (indexPath.row> self.data.count) {
        rilimodel *model = self.openData[indexPath.row-self.data.count-1];
        cell.model = model;
        return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row >=0 && indexPath.row <= self.data.count+self.openData.count+1 )
        
    {
        
        
        
        
        NSLog(@"选中了第%ld行",indexPath.row);
        
        NSString *a = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        
        //        [[NSUserDefaults standardUserDefaults]setObject:a forKey:@"dijihang"];
        
        
        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanwanle" object:self];
        
    }
    
    
    
    
    
}

@end
