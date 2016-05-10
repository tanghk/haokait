//
//  WithdrawView.m
//  555
//
//  Created by otouzi on 16/4/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "WithdrawView.h"

@implementation WithdrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.data = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
         self.showsVerticalScrollIndicator = NO;//滑动条隐藏
    }

    return self;
    
    


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"Noraml_BankCard_Cell";
    NoramlBankCardCell*cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
   
    
    cell = [[NoramlBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    
    //        cell = [[[NSBundle mainBundle]loadNibNamed:@"BestUserCell"
    //                                             owner:self
    //                                           options:nil]lastObject];
    

    WithdrawModel*model =self.data[indexPath.row]; 
    
    cell.model =model;
  
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.indexdelegate changeIndex:indexPath.row];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 170/3;



}
@end
