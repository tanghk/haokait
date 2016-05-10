//
//  NetworkState.h
//  555
//
//  Created by otouzi on 16/4/20.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkState : NSObject{


    UIWindow *_lastWindow;        //当前window
    UIControl *_maskView;         //遮挡视图
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
    
}
@property (nonatomic ,strong)NSString *localized;
+ (instancetype)sharedNetworkState;
-(void)showPromptWindow;

@end
