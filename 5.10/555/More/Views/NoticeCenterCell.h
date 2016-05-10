//
//  NoticeCenterCell.h
//  555
//
//  Created by otouzi on 15/11/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeModel.h"
@interface NoticeCenterCell : UITableViewCell
{

    UILabel *_titleLabel;//标题
    UILabel *_timeLabel;//时间
    UILabel *_contentLabel;//内容详情
    UIImageView *_upImageView;//顶图标
    NSString *_timeStr;
   

}
@property (nonatomic ,strong)NoticeModel *model;
@end
