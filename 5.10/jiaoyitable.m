//
//  jiaoyitable.m
//  555
//
//  Created by 李浩宇 on 15/12/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "jiaoyitable.h"
#import "jiaoyiTableViewCell.h"
#import "JIAOYIViewController.h"

@implementation jiaoyitable

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
        return 200*__kScreenHeight__/1334;
    }else
    {
        return 189*__kScreenHeight__/1334;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 1;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *indentifier = @"Best_User_Cell11";
    jiaoyiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"jiaoyiTableViewCell"
                                         owner:self
                                       options:nil]lastObject];
    
    
    if (cell==nil) {
        
        cell = [[jiaoyiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    if (indexPath.row<self.data.count) {
        jiaoyimodel *model = self.data[indexPath.row];
        
        cell.model = model;
        return cell;
        
    }
    
    
    
    
    
    
    
    
    if (indexPath.row> self.data.count) {
        jiaoyimodel *model = self.openData[indexPath.row-self.data.count-1];
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
