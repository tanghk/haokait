//
//  TransferTableView.m
//  555
//
//  Created by otouzi on 15/10/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "TransferTableView.h"

@implementation TransferTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
//优质散户retailInvestorTableView  dataSorce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"Retail_Investor_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.textLabel.text = @"转让专区";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

@end
