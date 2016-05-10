//
//  bankview.m
//  demotest
//
//  Created by otouzi on 15/12/7.
//  Copyright © 2015年 otouzi. All rights reserved.
//
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#import "bankview.h"
#import "TableViewCell.h"
#import "chongzhiViewController.h"
@implementation bankview

- (instancetype)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    
    if (self) {
        self.data = [NSMutableArray array];
        self.openData = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        
      
        
    }
    return self;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101*__kScreenHeight__/1334;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count+self.openData.count+1;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *indentifier = @"Best_User_Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell"
                                         owner:self
                                       options:nil]lastObject];
    
    
    if (cell==nil) {
        
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    if (indexPath.row<self.data.count) {
        BankModel *model = self.data[indexPath.row];
        
        cell.model = model;
        return cell;
        
    }
    
    
    
   
    
    
    if (indexPath.row == self.data.count) {
        cell.tishilable.text = @"注：下列银行需开通银联在线支付业务才可使用！";
        cell.tishilable.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:190/255.0 alpha:1];
         return cell;
    }
    
    
    if (indexPath.row> self.data.count) {
        BankModel *model = self.openData[indexPath.row-self.data.count-1];
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
        
        
        [[NSUserDefaults standardUserDefaults]setObject:a forKey:@"dijihang"];
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanwanle" object:self];
        
    }
        
    
   

    
}




@end
