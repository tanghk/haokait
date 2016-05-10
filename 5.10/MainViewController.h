//
//  MainViewController.h
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    
    UIWindow *_lastWindow;
    
    UIView *_updataView;//检查更新视图
    
    UILabel *_versionNumberLabel ;//版本号
    
    UILabel *_mbLabel;//占内存大小
    
    UILabel *_versionUpdataLabel;//2.2.1全新版本上线；
    
    UILabel *_updataContent; // 更新具体内容
    
    UIControl *_maskView;
    NSString * _notice_url;

}

@end
