//
//  AdviceFeedbackViewController.m
//  555
//
//  Created by mark on 15/11/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "AdviceFeedbackViewController.h"
#import "UICommons.h"
#import "UIViewExt.h"
#import "DataService.h"
#import "Masonry.h"
@interface AdviceFeedbackViewController ()

@end

@implementation AdviceFeedbackViewController
- (void)viewWillAppear:(BOOL)animated{

    [self creatWithNavGation];
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    _type = @"3";

    UIColor *backcolor = RGB(235, 235, 235, 1);
    self.view.backgroundColor = backcolor;
   // self.title = @"意见反馈";
    [self createSubViews];//创建子视图
    [self creatFooterView];//创建尾部视图
   
}

#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
   // self.view.backgroundColor = kColorWhite;
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = RGB(245, 245, 245, 1);
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"我的投资";
    titleLabel.font = [UIFont systemFontOfSize:16];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(backBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =kColorNaviLine ;
    [self.view addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationgView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    
    
}

#pragma mark 创建子视图
- (void)createSubViews{
//    
//    
//    //头视图
//    UIView *headerView = [[UIView alloc]init];
//    headerView.frame = CGRectMake(40*kPlusScale, 51*kPlusHeightScale+64, kScreenWidth - (40+40)*kPlusScale, 142*kPlusHeightScale);
//    headerView.layer.borderWidth = 0.5;
//    headerView.backgroundColor = [UIColor whiteColor];
//    UIColor *headerBoderColor = RGB(210, 210, 210, 1);
//    headerView.layer.borderColor = [headerBoderColor CGColor];
//    
//    headerView.userInteractionEnabled = YES;
//    
//    [self.view addSubview:headerView];
//    
//    //类型选择标题
//    UILabel *typeChoooseTitleLabel = [[UILabel alloc]init];
//    typeChoooseTitleLabel.frame = CGRectMake(42*kPlusScale, 52*kPlusHeightScale, 200/3, 40*kPlusHeightScale);
//    typeChoooseTitleLabel.font = [UIFont systemFontOfSize:40/3];
//    
//    typeChoooseTitleLabel.text = @"类型选择";
//    
//    [headerView addSubview:typeChoooseTitleLabel];
//    
//    //可变类型选择label
//    
//    _changeTitleLabel = [[UILabel alloc]init];
//    _changeTitleLabel.text = @"请选择意见类型";
//    _changeTitleLabel.frame = CGRectMake((42+200+40)*kPlusScale, 52*kPlusHeightScale, 480*kPlusScale, 42*kPlusHeightScale);
//    _changeTitleLabel.textColor = RGB(184, 184, 184, 1);
//    _changeTitleLabel.font = [UIFont systemFontOfSize:40/3];
//    [headerView addSubview:_changeTitleLabel];
//    
//    
//    UIImageView *indentitierImageView = [[UIImageView alloc]init];
//    indentitierImageView.frame = CGRectMake(headerView.width-(32+25)*kPlusScale, 50*kPlusHeightScale, 25*kPlusScale, 44*kPlusHeightScale);
//    NSLog(@"%f",headerView.width);
//    indentitierImageView.image = [UIImage imageNamed:@"moreNoticeSJIcon"];
//    
//    [headerView addSubview:indentitierImageView];
//    
//    
//    //headerView上放一个透明的Button
//    UIButton *maskButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    maskButton.frame =CGRectMake(40*kPlusScale, 51*kPlusHeightScale+64, kScreenWidth - (40+40)*kPlusScale, 142*kPlusHeightScale);
//    
//    [maskButton addTarget:self
//                   action:@selector(maskButtonAction:)
//         forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:maskButton];
//    
//    
    //输入意见视图
    _textView =[[UITextView alloc]init];
    _textView.frame = CGRectMake(40*kPlusScale, (38)*kPlusHeightScale+64, kScreenWidth - (40+40)*kPlusScale, 516*kPlusHeightScale);
   // _textView.layer.borderWidth = 0.5;
 
   // UIColor *textBorderColor =RGB(210, 210, 210, 1);
   // _textView.layer.borderColor = [textBorderColor CGColor];
    //_textView.text =@"请输入您反馈的意见";
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:40/3];
    [self.view addSubview:_textView];
    
    //placeholderLabel
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.frame = CGRectMake(42*kPlusScale, 22*kPlusHeightScale, _textView.width-42*kPlusHeightScale*2, 40);
    _placeholderLabel.text = @"感谢您对沃投资的支持，我们期待您宝贵的建议，请点击输入......";
    _placeholderLabel.textColor = RGB(184, 184, 184, 1);
    _placeholderLabel.font = _textView.font;
    _placeholderLabel.numberOfLines = 0;
  
    [_textView addSubview:_placeholderLabel];
    
    
    
    
//    //计数器
//    _numberLabel = [[UILabel alloc]init];
//    _numberLabel.text = @"160/160";
//    _numberLabel.font = [UIFont systemFontOfSize:36/3];
    //numberLabel.layer.borderWidth = 1;
    
    
    _numberLabel.frame = CGRectMake(_textView.width-(32+165)*kPlusScale, (516-36-30)*kPlusHeightScale, 165/3, 40*kPlusHeightScale);
    
    [_textView addSubview:_numberLabel];
    
    //提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(40*kPlusScale, (38+150+516)*kPlusHeightScale+64, kScreenWidth - (40+40)*kPlusScale, 174*kPlusHeightScale);
    submitButton.backgroundColor = kColorMain;
    submitButton.layer.cornerRadius = 6;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:60/3];
    [submitButton addTarget:self
                     action:@selector(submitAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
    
    
    //如有疑问，可直接拨打客服电话
    UILabel *contactLabel = [[UILabel alloc]init];
    contactLabel.frame = CGRectMake(47*kPlusScale, (38+150+516+60+174)*kPlusHeightScale+64, 690*kPlusScale, 60*kPlusHeightScale);
    contactLabel.text = @"如有疑问,可直接拨打客服电话:";
    contactLabel.textColor = kcolorFontGray;
    contactLabel.font = [UIFont systemFontOfSize:40/3];
    //contactLabel.layer.borderWidth = 1;
    [self.view addSubview:contactLabel];
    
    
    //联系电话
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake((47+690)*kPlusScale, (38+150+516+60+174)*kPlusHeightScale+64, 370*kPlusScale, 60*kPlusHeightScale);
    [phoneButton setTitle:@"400-9693-788"forState:UIControlStateNormal];
    UIColor *numberColor = kColorMain;
    [phoneButton setTitleColor:numberColor forState:UIControlStateNormal];
    
    phoneButton.titleLabel.font = [UIFont systemFontOfSize:40/3];

    [phoneButton addTarget:self
                    action:@selector(phoneAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    if (iphone6_4_7) {
        phoneButton.frame = CGRectMake((620)*kPlusScale, (38+150+516+60+174)*kPlusHeightScale+64, 370*kPlusScale, 60*kPlusHeightScale);

    }else if (iphone6Plus_5_5){
    
     phoneButton.frame = CGRectMake((550)*kPlusScale, (38+150+516+60+174)*kPlusHeightScale+64, 370*kPlusScale, 60*kPlusHeightScale);
    }
    
   
    [self.view addSubview:phoneButton];
    
    
    
}


//点击类型选择按钮弹出视图

- (void)creatFooterView{
    _footerView = [[UIView alloc]init];
    _footerView.frame = CGRectMake(40*kPlusScale,kScreenHeight, kScreenWidth - (40+40)*kPlusScale, kScreenHeight - 1517*kPlusHeightScale-kNavigationBarHeight);
    _footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_footerView];
    
    NSArray *typeArr = @[@"功能型",
                         @"体验型",
                         @"其他类型"
                         ];
    for (int i = 0; i<3; i++) {
        
        
        UIButton * typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.frame = CGRectMake(0, (90+30)*kPlusHeightScale*i, _footerView.width, 90*kPlusHeightScale);
        [typeButton setTitle:typeArr[i] forState:UIControlStateNormal];
        typeButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
        [typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        typeButton.backgroundColor = [UIColor whiteColor];
        typeButton.tag = 1000+i;
        [typeButton addTarget:self
                       action:@selector(typeAction:)
             forControlEvents:UIControlEventTouchUpInside];
        
        [_footerView addSubview:typeButton];
        
        
    }
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, (90+30)*kPlusHeightScale *3, _footerView.width, 90*kPlusHeightScale);
    UIColor *backgroundColor = RGB(103, 103, 103, 1);
    [cancelButton setBackgroundColor:backgroundColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(cancelAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView addSubview:cancelButton];
    
    
    
    
    
}

//显示尾部视图
- (void)showFooterView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         //使用block，来执行一个动画
                         //向下的平移
                        
                         if (iphone5x_4_0) {
                                _footerView.transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight - 1517*kPlusHeightScale)+kNavigationBarHeight-10);
                         }else{
                         _footerView.transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight - 1517*kPlusHeightScale)+kNavigationBarHeight);
                         }
                     }];
    
}

//隐藏尾部视图
- (void)hideFooterView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         _footerView.transform = CGAffineTransformIdentity;
                     }];
    
}

#pragma mark - 按钮点击事件
//遮盖按钮点击事件
- (void)maskButtonAction:(UIButton *)sender{
    [_textView resignFirstResponder];
    NSLog(@"请选择意见类型");
    [self showFooterView];
    UIColor *textBorderColor =RGB(210, 210, 210, 1);
    _textView.layer.borderColor = [textBorderColor CGColor];

    
}

//选中电话号码
- (void)phoneAction:(UIButton *)sender{
    
    // 拨号访问alertView
    //NSString *title = NSLocalizedString(@"A Short Title Is Best", nil);
    //    NSString *message = NSLocalizedString(@"400-9693-788", nil);
    //    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    //    NSString *otherButtonTitle = NSLocalizedString(@"呼叫", nil);
    //
    //    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    //
    //    // Create the actions.
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    //        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    //    }];
    //
    //    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4009693788"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    
    //        NSString *number = @"4009693788";// 此处读入电话号码
    //        // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
    //
    //        NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    //  }];
    
    //    // Add the actions.
    //    [alertController addAction:cancelAction];
    //    [alertController addAction:otherAction];
    //
    //    [self presentViewController:alertController animated:YES completion:nil];
    //    
    
}

#warning 提供接口将text文本上传服务器
//提交按钮点击事件
- (void)submitAction:(UIButton *)sender{
    NSLog(@"提交意见反馈内容");
    
    NSString *banduan=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan = [banduan intValue];
    if (panduan == 200 ) {
        
        if ((_textView.text.length<1
                                 )) {
            
            
            UIAlertView *myalert = [[UIAlertView alloc]
                                    initWithTitle:@"请输入您反馈的意见"
                                    message:nil
                                    delegate:self
                                    cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
                                    otherButtonTitles:nil];
            
            [myalert show];
            
            
        }
        
        
        else{
            
            NSString *string = [[NSString alloc]init];
            for (int i = 0; i < 32; i++) {
                int number = arc4random() % 36;
                if (number < 10) {
                    int figure = arc4random() % 10;
                    NSString *tempString = [NSString stringWithFormat:@"%d", figure];
                    string = [string stringByAppendingString:tempString];
                }else {
                    int figure = (arc4random() % 26) + 97;
                    char character = figure;
                    NSString *tempString = [NSString stringWithFormat:@"%c", character];
                    string = [string stringByAppendingString:tempString];
                }
            }
            
            
            
            NSLog(@"用户反馈意见类型：%@and用户反映的内容：%@",_type,_textView.text);
            NSMutableDictionary *params =
            [NSMutableDictionary dictionaryWithDictionary:@{@"type":_type,
                                                            @"content":_textView.text,
                                                            @"token":string
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            } ];
            
            [DataService requestWithURL:@"/feedback"
                                 params:params httpMethod:@"post"
                        completionBlock:^(id result) {
                            [self feedback:result];
                            
                            
                            
                            
                        }];
            
            
        }
        
    }else{
        
        
        
        UIAlertView *myalert = [[UIAlertView alloc]
                                initWithTitle:@"请先登录"
                                message:nil
                                delegate:self
                                cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
                                otherButtonTitles:nil];
        
        [myalert show];
        
        //  [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }
}

- (void)feedback:(id)result{


    NSLog(@"意见反馈%@",result);
    if ([[result objectForKey:@"code"]isEqualToNumber:@2113]) {
        //提示用户提交成功
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"请先登录"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
        [alertView show];

    }else if ([[result objectForKey:@"code"]isEqualToNumber:@200]){
    
//        //提示用户提交成功
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"意见提交成功"
//                                  message:nil
//                                  delegate:nil
//                                  cancelButtonTitle:@"确定"
//                                  otherButtonTitles:nil];
//        [alertView show];
//
    
    
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self dismissViewControllerAnimated:NO completion:nil];

    }else{
    
        NSLog(@"%@",result[@"data"]);
    
    }

}
//选择类型点击事件
- (void)typeAction :(UIButton *)sender{
    if (sender.tag==1000) {
        _type = @"1";
        _changeTitleLabel.text = @"功能型";
        _changeTitleLabel.textColor = [UIColor blackColor];
        [self hideFooterView];
        
        
    }else if (sender.tag == 1001){
        _type = @"2";

        _changeTitleLabel.text = @"体验型";
        _changeTitleLabel.textColor = [UIColor blackColor];
        
        [self hideFooterView];
        
    }else if (sender.tag ==1002){
        _type = @"3";

        _changeTitleLabel.text =  @"其他类型";
        _changeTitleLabel.textColor = [UIColor blackColor];
        
        [self hideFooterView];
        
        
    }
    
    
}


//取消按钮点击事件
- (void)cancelAction:(UIButton *)sender{
    
    [self hideFooterView];
    
}

#pragma mark - 触摸事件

//触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIColor *textBorderColor =RGB(210, 210, 210, 1);
    _textView.layer.borderColor = [textBorderColor CGColor];
    [_textView resignFirstResponder];
    [self hideFooterView];
    
    
    
}
#pragma mark - textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self hideFooterView];
    
    _placeholderLabel.text = @"";
    //211 74 89
    UIColor *viewBoderColor  = RGB(211, 74, 89, 1);
    _textView.layer.borderColor =[viewBoderColor CGColor];
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (_textView.text.length ==0) {
        _placeholderLabel.text = @"感谢您对沃投资的支持，我们期待您宝贵的建议，请点击输入......";
    }else{
        
        _placeholderLabel.text = @"";
    }
    
    
}

- (void)textViewDidChange:(UITextView *)textView{
    //_numberLabel.text = [NSString stringWithFormat:@"%ld/160",160-_textView.text.length];
    
}


- (void)backBtnAction:(UIButton*)sender
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

@end
