//
//  CashCouponModel.m
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "CashCouponModel.h"

@implementation CashCouponModel
- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    self.descriptionDetail = [dataDic objectForKey:@"description"];
}

@end
