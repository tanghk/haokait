//
//  SelectModel.h
//  555
//
//  Created by otouzi on 15/11/25.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface FilterModel : BaseModel

@property (nonatomic ,copy)NSString *node;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic , strong)NSMutableArray *selected;


@end



/* 
 get /product/list/filter
 header Access-Token Application-Session
 
 request
 {
 
 }
 
 response
 {
 "status": true,
 "code": 200,
 "data": [
 {
 "node": 0,                          // 索引节点
 "name": "还款方式",                  // 筛选描述
 "selected": [
 {
 "node": 0,                  // 子索引节点
 "name": "全部"               // 筛选描述
 },
 {
 "node": 1,
 "name": "按月付息，到期返本"
 },
 {
 "node": 2,
 "name": "按月等额本息"
 },
 {
 "node": 3,
 "name": "到期返本付息"
 }
 ]
 },
 {
 "node": 1,
 "name": "年华收益率",
 "selected": [
 {
 "node": 0,
 "name": "全部"
 },
 {
 "node": 1,
 "name": "12%-13.9%"
 },
 {
 "node": 2,
 "name": "14%-15.9%"
 },
 {
 "node": 3,
 "name": "16%-18%"
 }
 ]
 },
 {
 "node": 2,
 "name": "投资期限",
 "selected": [
 {
 "node": 0,
 "name": "全部"
 },
 {
 "node": 1,
 "name": "1个月以下"
 },
 {
 "node": 2,
 "name": "1-2个月"
 },
 {
 "node": 3,
 "name": "3-5个月"
 },
 {
 "node": 4,
 "name": "6-12个月"
 }
 ]
 }
 ]
 }
 */