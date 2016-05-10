//
//  ListModel.m
//  555
//
//  Created by otouzi on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    self.product_id = [dataDic objectForKey:@"id"];
}

@end
