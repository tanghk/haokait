//
//  WithdrawModel.h
//  555
//
//  Created by otouzi on 16/4/14.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "BaseModel.h"

@interface WithdrawModel : BaseModel
@property (nonatomic ,strong)NSString *bankcard;
@property (nonatomic ,strong)NSString *bankname;
@property (nonatomic ,strong)NSString *card;
@property (nonatomic ,strong)NSString *logo;

@end


/*   bankcard = 3;
 bankname = "\U4e2d\U56fd\U90ae\U653f\U50a8\U84c4\U94f6\U884c";
 card = 6215992340000306140;
 color = "#009983";
 colorRgb = "0,153,131";
 key = PSBC;
 logo = "http://debug.otouzi.com:8012/Public/mobile/images/PSBC.png";
 thumb = "http://debug.otouzi.com:8012/Public/images/PSBC.png";
 */