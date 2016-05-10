//
//  BankModel.h
//  555
//
//  Created by otouzi on 15/12/7.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BaseModel.h"
#import "UIImageView+AFNetworking.h"
@interface BankModel : BaseModel
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *single;
@property (nonatomic, strong)NSString *day;
@property (nonatomic, strong)NSString *month;
@property (nonatomic, strong)NSString *logo;

@end
