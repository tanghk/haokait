//
//  ExchangeConponViewController.h
//  555
//
//  Created by otouzi on 16/4/13.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeIndexDelegate <NSObject>

@optional
- (void)changeIndex:(NSUInteger)index;
@end
@interface ExchangeConponViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, assign) id<ChangeIndexDelegate>delegate;

@end
