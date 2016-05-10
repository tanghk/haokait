//
//  promptLabel.h
//  555
//
//  Created by otouzi on 16/4/8.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface promptLabel : UILabel
/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg;



/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg;

@end
