//
//  NoticeModel.h
//  555
//
//  Created by otouzi on 15/12/8.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface NoticeModel : BaseModel
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *created_at;
@property (nonatomic ,strong)NSString *seo_description;
@property (nonatomic ,strong)NSString *href;
@end
/*
 response
 {
 "status": true,
 "code": 200,
 "data": {
 "page": 1,
 "totalRows": "25",
 "limit": 2,
 "list": [
 {
 "id": "1401",
 "title": "投资当日计息，收益无需等待",
 "seo_keywords": "",
 "seo_description": "",
 "menu_id": "45",
 "created_at": "2015-06-30",
 "thumb": null,
 "page_view": "227",
 "event": "OpenBrowser",
 "href": "http://gongyi.gmw.cn/2015-12/10/content_18039818.htm"
 },
 {
 "id": "1397",
 "title": "网站系统升级",
 "seo_keywords": "",
 "seo_description": "尊敬的沃投资用户：您好！网站将于今日进行系统升级，升级时间为6月19日10:00-12:00。给您造成的不便敬请谅解，感谢您对沃投资一",
 "menu_id": "45",
 "created_at": "2015-06-28",
 "thumb": "",
 "page_view": "43",
 "event": "OpenBrowser",
 "href": "http://gongyi.gmw.cn/2015-12/10/content_18039818.htm"
 }
 ]
 }
 }
 */