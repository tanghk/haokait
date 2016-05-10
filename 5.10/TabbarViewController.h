//
//  TabbarViewController.h
//  555
//
//  Created by 李浩宇 on 15/11/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarViewController : UITabBarController<UITabBarControllerDelegate>
{
    NSUInteger _lastSelectedIndex;
}

@property(readonly, nonatomic) NSUInteger lastSelectedIndex;


@end
