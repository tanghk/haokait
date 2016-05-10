//
//  AdviceFeedbackViewController.h
//  555
//
//  Created by mark on 15/11/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceFeedbackViewController : UIViewController<UITextViewDelegate>
{

    UILabel *_changeTitleLabel;//改变类型标题
    UIView *_footerView;//尾部视图
    UITextView * _textView;
    UILabel *_placeholderLabel;//站位label
    UILabel * _numberLabel;
    NSString *_type;

}
@end
