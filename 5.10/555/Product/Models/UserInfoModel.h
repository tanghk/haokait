//
//  UserInfoModel.h
//  555
//
//  Created by otouzi on 15/12/15.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel


@end


/*
 *我的信息
 
 get /user/info
 header Access-Token Application-Session
 
 request
 {
 }
 
 response
 {
 "status": true,
 "code": 200,
 "data": {
 "chinapnr": {
 "available": "190630.00",                                          // 可用余额
 "frozen": "190630.00",                                             // 冻结金额
 "investment": "260520.00"                                          // 投资总额
 },
 "bankCard": {
 "hasDefaultBankCard": true,                                        // 是否绑定默认卡
 "defaultBankcardInfo": {                                           // 如果没绑定为 null
 "bankcode": "BOC",                                             // 银行英文缩写
 "card": "6013820800073254045",                                 // 银行卡卡号
 "bankname": "中国银行"                                          // 银行名称
 }
 },
 "user_chinapnr_info": {
 "id": "82675",
 "created_at": "1437357863",
 "updated_at": "1448592792",
 "uid": "84674",
 "usrcustid": "6000060001751091",
 "usrid": "qszc_microsoft",
 "trxid": "446519757385447025",
 "frozen": "190630.00",
 "available": "724688.81",
 "realname": "*权",
 "idcard": "**********2236",
 "virtual_total_money": "0.00",
 "virtual_available": "0.00",
 "virtual_frozen": "0.00",
 "experience": "0",
 "investment": "260520.00",
 "moon": "108",
 "total_moon": "1432"
 },
 "open_chinapnr_url": {
 "event": "OpenBrowser",
 "href": "http://debug.otouzi.com:8012/user/chinapnr/browseropen.html"
 }
 }
 }
 */