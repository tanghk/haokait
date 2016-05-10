//
//  ListModel.h
//  555
//
//  Created by otouzi on 15/11/2.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

//TODO:类目不同的类型 prducttypelabel的值不同
enum ProductType {
    WordType,  //文字新闻
    ImageType, //图片新闻
    VideoType  //视频新闻
};



@interface ListModel : BaseModel
@property (nonatomic, strong)NSMutableArray *data;

@property (nonatomic, strong)NSString *name;// 产品名称

@property (nonatomic, strong)NSString *revenue; // 年华收益

@property (nonatomic, strong)NSString *way_repayment; // 还款方式

@property (nonatomic, strong)NSString *state;// 项目状态

@property (nonatomic, copy)NSString *thumb;// 小缩略图

@property (nonatomic, copy)NSString *category; // 项目类型

@property (nonatomic,copy)NSString *deadline;// 投资期限

@property (nonatomic,  copy)NSString * money;//   项目总额

@property (nonatomic, copy)NSString *total_invest_money;// 投资总额

@property (nonatomic, copy)NSString *increase;

@property (nonatomic, strong)NSDictionary *extend;//拓展事件

@property (nonatomic, strong)NSString *product_id;//产品id

@property (nonatomic , strong)NSString *deadline_key;//投资期限／天／月

@property (nonatomic , strong)NSString *way_repayment_key;//还款方式



@property (nonatomic , strong)NSString *is_novice;
/*
 *"way_repayment": "按月付息 到期返本","way_repayment_key": "1"
 *"way_repayment": "按月等额本息", "way_repayment_key": "2"
 *"way_repayment": "到期返本付息", "way_repayment_key": "3"
 */
@end


/*
 "data": {
 "activity": {
 "name": "标题",
 "thumb": "https://www.otouzi.com/Public/images/admin/logo.png",
 "event": "OpenBrowser",
 "href": "https://www.otouzi.com/"
 },
 "totalRows": "14",
 "page": "1",
 "limit": " 10",
 "code": "000",
 "list": [
 {
 "id": "993",
 "name": "222-141204-22342xxxx",
 "risk": "A",
 "deadline": "12个月",
 "category": "优选散标",
 "way_repayment": "按月等额本息",
 "money": "1000000.00",
 "revenue": "12.00",
 "state": "募集中",
 "thumb": "http://tt.otouzi.com/Public//Uploads/desc/2015-04/20150414114527-70810.jpg",
 "attribute": "信用",
 "industry": "农",
 "detail_thumb": "http://tt.otouzi.com/Public//Uploads/desc/2015-04/20150414114527-70810.jpg",
 "created_at": "1448521200",
 "total_invest_money": "118900.00",
 "increase": 0,
 "extend": {
 "event": "OpenBrowser",
 "href": "http://debug.otouzi.com:8012/product/browser/info/993.html"
 },
 "deadline_key": "12",
 "category_key": "2",
 "attribute_key": "3",
 "risk_key": "1",
 "way_repayment_key": "2"
 },


 */