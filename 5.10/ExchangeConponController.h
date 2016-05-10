//
//  ExchangeConponController.h
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol ChangeIndexDelegate <NSObject>

@optional
- (void)changeIndex:(NSUInteger)index;

@end

@interface ExchangeConponController : BaseViewController<UITextFieldDelegate>
@property (nonatomic, assign) id<ChangeIndexDelegate>delegate;
@end
