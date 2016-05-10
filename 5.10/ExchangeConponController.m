//
//  ExchangeConponController.m
//  555
//
//  Created by otouzi on 16/3/9.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "ExchangeConponController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "exchangeSucessfulController.h"
#import "UIViewExt.h"
#import "DataService.h"
@interface ExchangeConponController (){
    UIImageView *_bgImageView;
    UIView *_entryView;
    UITextField *_entryTextFileld;
    UIButton *_exchangeButton;
    
   
    UIWindow *_lastWindow;        //当前window
    UIControl *_maskView;         //遮挡视图
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
    

    NSString *_exchangeCode; //兑换吗
    
    

}

@end

@implementation ExchangeConponController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  


}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
  
    [self custumRedPackageView];
    [self creatWithNavGation];
    [self createMaskView];
    
}

#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = kColorWhite;
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = RGB(245, 245, 245, 1);
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"兑换红包";
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
#pragma mark - 自定义视图

- (void)custumRedPackageView{

    /*
     *背景
     */
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.image = [UIImage imageNamed:@"convertRedPacket"];
    
    [self.view addSubview:_bgImageView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64.5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    /*
     *输入视图
     */
    _entryView = [[UIView alloc]init];
    _entryView.backgroundColor = kColorWhite;
    _entryView.layer.cornerRadius = 3;
    [self.view addSubview:_entryView];
    
    [_entryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0.081*kScreenWidth);
        make.right.equalTo(self.view).offset(-0.081*kScreenWidth);
        make.top.equalTo(_bgImageView.mas_top).offset(0.135*kScreenHeight);
        make.height.mas_equalTo(0.069*kScreenHeight);
        
    }];
    
    /*
     *输入框
     */
    _entryTextFileld = [[UITextField alloc]init];
    _entryTextFileld.delegate = self;
    //_entryTextFileld.autocapitalizationType = UITextAutocapitalizationTypeWords;
//    _entryTextFileld.keyboardType = UIKeyboardTypeNumberPad;
    _entryTextFileld.clearButtonMode = UITextFieldViewModeAlways;
    //_entryTextFileld.layer.borderWidth = 1;
    [_entryTextFileld addTarget:self
                         action:@selector(textField:)
               forControlEvents:UIControlEventEditingChanged];
    
    [_entryView addSubview:_entryTextFileld];
    
    
    /*
     *兑换按钮
     */
    _exchangeButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    _exchangeButton.backgroundColor = kColorMain;
    _exchangeButton.layer.cornerRadius = 3;
    _exchangeButton.titleLabel.font = Font(14);
    [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    
    [_exchangeButton addTarget:self
                        action:@selector(exchangeAction)
              forControlEvents:UIControlEventTouchUpInside];
    [_entryView addSubview:_exchangeButton];
   

    [_entryTextFileld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_entryView.mas_left).offset(0.031*kScreenWidth);
        make.top.equalTo(_entryView.mas_top).offset(0.008*kScreenHeight);
        make.height.mas_equalTo(0.054*kScreenHeight);
        make.right.equalTo(_exchangeButton.mas_left).offset(-0.031*kScreenWidth);
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_entryView.mas_right).offset(-0.014*kScreenWidth);
        make.top.equalTo(_entryView.mas_top).offset(0.008*kScreenHeight);
        make.height.mas_equalTo(0.054*kScreenHeight);
        make.width.mas_equalTo(0.213*kScreenWidth);
    }];
    
    

}



#pragma mark -提示充值弹窗

//创建遮盖视图
- (void)createMaskView{
    
    
  //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
    _rechargeView.layer.cornerRadius = 3;
//    _rechargeView.frame = CGRectMake(0.163*kScreenWidth, 0.425*kScreenHeight, kScreenWidth - 2*0.163*kScreenWidth, 0.149*kScreenHeight);
    _rechargeView.frame = CGRectMake(0.163*kScreenWidth, 0.358*kScreenHeight, kScreenWidth - 2*0.163*kScreenWidth, 0.149*kScreenHeight);
    

    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];

    [_lastWindow addSubview:_rechargeView];
    

    //文本内容
    _contentLabel = [[UILabel alloc]init];
    //_contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 1;
    _contentLabel.font = [UIFont systemFontOfSize:28/2];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = [NSString stringWithFormat:@"您输入的兑换码已经兑换过了"];
    [_rechargeView addSubview:_contentLabel];

   
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(_rechargeView.mas_top).offset(0.032*kScreenHeight);
        make.left.equalTo(_rechargeView.mas_left);
        make.right.equalTo(_rechargeView.mas_right);
        make.height.mas_equalTo(0.018*kScreenHeight);
  }];
       //确认
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sureButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82)*kPlusScale)/2, 110*kPlusScale);
    
    
    
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 3;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
     [_rechargeView addSubview:sureButton];
 [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rechargeView.mas_centerX);
        make.top.equalTo(_contentLabel.mas_bottom).offset(0.028*kScreenHeight);
        make.width.mas_equalTo(0.230*kScreenWidth);
        make.height.mas_equalTo(0.052*kScreenHeight);
        
    }];
    
    
    
    //_rechargeView.frame = CGRectMake(202*kPlusScale, 657*kPlusScale, kScreenWidth - (202+202)*kPlusScale,sureButton.height+sureButton.origin.y +60*kPlusHeightScale );
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //根据RGB设置颜色
    //[UIColor colorWithRed: green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [_lastWindow insertSubview:_maskView belowSubview:_rechargeView];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
  
    [_entryTextFileld resignFirstResponder];
}

/*
 *代理方法实现
 */

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
 
    NSLog(@"%@",_exchangeCode);

}




-(void)textField:(UITextField *)textField{
    _exchangeCode = textField.text;
    
   // NSLog(@"%@",_exchangeCode);

}





#pragma mark - 返回按钮
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
    

    
  //  [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

#pragma mark － 提示窗口

/*
 *确认按钮
 */

- (void)sureAction:(UIButton *)sender{
    
    

 [self hidePromptWindow];
    
}

#pragma mark -遮挡视图点击事件
- (void)maskViewAction:(UIControl *)sender{
    
    
    [self hidePromptWindow];
}


#pragma mark 兑换红包按钮
- (void)exchangeAction{
    [_entryTextFileld resignFirstResponder];
    NSLog(@"%@",_exchangeCode);
    if (_exchangeCode !=nil ) {
        
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{
                                     @"code" :_exchangeCode
                                    
                                     }];
    
   [ DataService requestWithURL:@"/exchangeCode"
                         params:params
                     httpMethod:@"post"
                completionBlock:^(id result) {
                    [self loadExchangeCode:result];
                    
    }];
    
    
    
    }else{
    
    _contentLabel.text = @"请输入兑换码";
        [self showPromptWindow];

    
    }

}
#pragma mark - 请求
- (void)loadExchangeCode:(id)result{
    NSLog(@"fanhui%@",result);

    NSDictionary * reponseDic = result;
   
    NSNumber *codeNumber = [reponseDic objectForKey:@"code"];
    
    if ([codeNumber isEqualToNumber:@200]) {
        NSDictionary *dataDic = [reponseDic objectForKey:@"data"];
        NSLog(@"%@",dataDic);

        NSInteger type = [[dataDic objectForKey:@"type"]intValue];
        
        [self.delegate changeIndex:type];
        
       exchangeSucessfulController *exchangeSuccessfulVC =[[exchangeSucessfulController alloc]init];
       exchangeSuccessfulVC.codeDic = dataDic;
//       exchangeSuccessfulVC.hidesBottomBarWhenPushed = YES;
//       [self.navigationController pushViewController:exchangeSuccessfulVC animated:YES];
//            
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:exchangeSuccessfulVC animated:NO completion:nil];

   
        
    }else {
    
        NSLog(@"兑换码结果%@",reponseDic);

        NSLog(@"结果为%@", [reponseDic objectForKey:@"data"]);

        [self showPromptWindow];
        _contentLabel.text = [NSString stringWithFormat:@"%@",[reponseDic objectForKey:@"data"]];

    }
}



#pragma mark - 提示充值信息
    /*
     *显示提示框
     */
- (void)showPromptWindow{
        [UIView animateWithDuration:.35 animations:^{
            
            _rechargeView.hidden = NO;
            _maskView.hidden = NO;
        }];
    }
    
    /*
     *隐藏提示框
     */
 - (void)hidePromptWindow{
        [UIView animateWithDuration:.35 animations:^{
            
            _rechargeView.hidden = YES;
            _maskView.hidden = YES;
            
        }];
        
    }
 
   // NSDictionary *dataDic = reponseDic objectForKey:@"data";
//    
//    
//        exchangeSucessfulController *exchangeSuccessfulVC =[[exchangeSucessfulController alloc]init];
//        exchangeSuccessfulVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:exchangeSuccessfulVC animated:YES];
//    
//    
//





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.view removeFromSuperview];
    


}
@end
