//
//  WelcomeViewController.h
//  555
//
//  Created by otouzi on 16/1/21.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@interface WelcomeViewController : UIViewController<UIScrollViewDelegate,PageControlDelegate>
{
PageControl *thePGLeft;
     UILabel *_titleLabel;//标题
   UIScrollView *scrVl;
}
@property (strong, nonatomic) UIWindow *window;
@end
