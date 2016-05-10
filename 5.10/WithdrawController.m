//
//  WithdrawController.m
//  555
//
//  Created by otouzi on 16/3/29.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "WithdrawController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "bangkaViewController.h"


@interface WithdrawController ()

@end

@implementation WithdrawController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self requesrUserCenterData];
    [self creatWithNavGation];
    [self requesrUserCenterData];
    
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
   

    [self custumViews];
    
    

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
    titleLabel.text = @"提现";
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




#pragma mark -  自定义view
- (void)custumViews{
    
    
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = kcolorGrayNew ;
    [self.view addSubview:bgView];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);

    }];
    
    
    
    
    
    UILabel *canBeWithdrawalLabel =[UILabel new];
    canBeWithdrawalLabel.font =Font(42/3);
    canBeWithdrawalLabel.text =@"可提现金额(元)  ：";
    canBeWithdrawalLabel.textColor =kcolorFontGray;
//    canBeWithdrawalLabel.layer.borderWidth = 1;
    [bgView addSubview:canBeWithdrawalLabel];
    
    [canBeWithdrawalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(bgView.mas_top).offset(0.030*kScreenHeight);
        make.width.mas_equalTo(349/3);
        make.height.mas_equalTo(14);
        
        
    }];

    _canBeWithdrawalAmount = [UILabel new];
    _canBeWithdrawalAmount.font = Font(42/3);
    //_canBeWithdrawalAmount.text = @"213.3";
    _canBeWithdrawalAmount.textColor = kColorMain;
    
    [bgView addSubview:_canBeWithdrawalAmount];
    
    [_canBeWithdrawalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.left.equalTo(canBeWithdrawalLabel.mas_right).offset(0.018*kScreenWidth);
        make.left.equalTo(canBeWithdrawalLabel.mas_right);

        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.top.equalTo(bgView.mas_top).offset(0.030*kScreenHeight);
        make.height.mas_equalTo(14);
        
        
    }];
    
    
    
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =RGB(217, 217, 217, 1) ;
    [bgView addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_canBeWithdrawalAmount.mas_bottom).offset(0.03*kScreenHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];

    
    
    
    /*
     *提现金额视图
     */
     UIView * withdrawalAmountView= [[UIView  alloc]init];
    withdrawalAmountView .backgroundColor = kColorWhite;
   
    [bgView addSubview:withdrawalAmountView];
    
    [withdrawalAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(lineGray.mas_bottom);
        make.height.mas_equalTo(0.081*kScreenHeight);
        make.width.mas_equalTo(kScreenWidth);
        
        
    }];
    
    
    
    
    //线
    UILabel *linebottom = [UILabel new];
    linebottom .backgroundColor =RGB(217, 217, 217, 1) ;
    [bgView addSubview:linebottom ];
    [linebottom  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(withdrawalAmountView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];

    /*
     *提现金额
     */
     _withdrawalAmount= [UILabel new];
    _withdrawalAmount.text = @"提现金额(元)";
    _withdrawalAmount.font = Font(48/3);
    
    [withdrawalAmountView addSubview:_withdrawalAmount];
    
    [_withdrawalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);
        make.top.equalTo(withdrawalAmountView.mas_top).offset(0.029*kScreenHeight);
        make.height.mas_equalTo(16);
       // make.width.mas_equalTo(0.279*kScreenWidth);
          // make.width.mas_equalTo(0.277*kScreenWidth);
          make.width.mas_equalTo(365/3);
    }];
    
    
    
    
    
    
    
    
    
    /*
     *请输入金额
     */
    _enterAmount = [UITextField new];
    _enterAmount.delegate = self;

    _enterAmount.keyboardType = UIKeyboardTypeNumberPad;
    _enterAmount.clearButtonMode = UITextFieldViewModeAlways;
    _enterAmount.font = Font(48/3);
    _enterAmount.placeholder = @"请输入金额";
    [_enterAmount addTarget:self
                     action:@selector(textFiledChanged:)
               forControlEvents:UIControlEventEditingChanged];
    

    [withdrawalAmountView addSubview:_enterAmount];
    
    [_enterAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(withdrawalAmountView.mas_top);
        //  make.left.equalTo(_withdrawalAmount.mas_right).offset(0.018*kScreenWidth);
        make.left.equalTo(_withdrawalAmount.mas_right);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
       // make.height.mas_equalTo(16);
            make.height.mas_equalTo(0.081*kScreenHeight);
    }];
    
    
    
    /*
     *到账银行卡
     */
    
    
    UILabel * bankCard = [UILabel new];
    [bgView addSubview:bankCard];
    
    bankCard.text = @"到账银行卡";
    bankCard.font= Font(42/3);
    
    [bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);;
        make.right.equalTo(bgView.mas_right);
        make.top.equalTo(withdrawalAmountView.mas_bottom).offset(0.039*kScreenHeight);
        make.height.mas_equalTo(14);
        
}];
    
    
    
    /*
     *添加银行卡
     */
    
    
    UIButton *addCard = [UIButton new];
    [addCard setImage:[UIImage imageNamed:@"addcard"] forState:UIControlStateNormal];
    [addCard addTarget:self
                action:@selector(addBankCard)
      forControlEvents:UIControlEventTouchUpInside];
    addCard.adjustsImageWhenHighlighted = NO;
   //  [priceBtn setAdjustsImageWhenHighlighted:NO];
    [bgView addSubview:addCard];
    
    [addCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        make.top.equalTo(bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];
    
    
    UIButton *withdrawBtn =[UIButton new];
    
    [withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [withdrawBtn setBackgroundColor:kColorMain];
    withdrawBtn.layer.cornerRadius = 6;
    withdrawBtn.titleLabel.font = Font(58/3);
     withdrawBtn.titleLabel.font = Font(0.026*kScreenHeight);
    [withdrawBtn addTarget:self
                    action:@selector(withdrawAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:withdrawBtn];
    
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(0.031*kScreenWidth);
        make.right.equalTo(bgView.mas_right).offset(-0.031*kScreenWidth);
        make.top.equalTo(addCard.mas_bottom).offset(0.069*kScreenHeight);
        make.height.mas_equalTo(0.079*kScreenHeight);
        
    }];
    
    

    

}




#pragma mark 用户中心
- (void)requesrUserCenterData{
    
    [DataService requestWithURL:@"/user/center"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [ self loafUserCenterData :result];
                    
                    
                    
                }];
    
    
    
    
    
}



- (void)loafUserCenterData:(id)result{
    
    NSLog(@"提现%@",result);
    
    NSDictionary *reponseDic =result;
    
    
    NSNumber *code = reponseDic[@"code"];
    
    if ([code intValue] ==200)
    {
        
        NSDictionary *dataDic = reponseDic[@"data"];
        NSDictionary *user_chinapnr_infoDic = dataDic[@"user_chinapnr_info"];
        _available_balance = user_chinapnr_infoDic[@"available_balance"];
        
        _canBeWithdrawalAmount.text = [NSString stringWithFormat:@"%@元",_available_balance];
        
    }else{
        
        
        
    }
    
    
}


#pragma mark - 添加银行卡
- (void)addBankCard{

    [DataService requestWithURL:@"/bindcard"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [self loadBankCardData:result];
                    
        
    }];
    
    
    

}

#pragma mark - 提现
- (void)withdrawAction:(UIButton*)sender{


   [_enterAmount resignFirstResponder];


    [self promptView:@"请先添加银行卡"];
    
    
}


#pragma mark - 添加银行卡
- (void)loadBankCardData:(id)result{

    
    NSLog(@"%@",result);
    NSLog(@"%@",result[@"data"]);
    NSDictionary *responseDic = result;
    
    NSNumber *code = responseDic[@"code"];
    if ([code intValue]==200) {
        NSDictionary *dataDic = responseDic[@"data"];
        NSString  *url= dataDic[@"href"];

         bangkaViewController *bang =[[bangkaViewController alloc]init];
        
        bang.urlValue = url;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
            
        [self presentViewController:bang animated:NO completion:nil];
        
  
        
    }else{
    
    
    }


    
    
    
    
}



#pragma mark - 触摸释放textfiled
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_enterAmount resignFirstResponder];
    

}
#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionReveal;
//    animation.subtype = kCATransitionFromBottom;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
//
//    
   // [self.navigationController popViewControllerAnimated:YES];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];

    
    
}


# pragma mark - texfieild代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     NSLog(@"1%@",textField.text);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"2%@",textField.text);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"3结束编辑%@",textField.text);
    
    
    
}

- (void)textFiledChanged:(UITextField *)textField{

 NSLog(@"4结束编辑%@",textField.text);
    textField.clearsOnBeginEditing = YES;
    

    _amount_entered = textField.text;
    if ([_amount_entered floatValue]>=[_available_balance floatValue]) {
       // _enterAmount.text =[NSString stringWithFormat:@"%@",_available_balance];
    }else{
    
    
    }

}


- (void)promptView:(NSString *)string{
    
    
    UILabel *promptLabel= [[UILabel alloc]init];
    CGFloat strWidth = [ self widthForString:string
                                    fontSize:15
                                   andHeight:50*kHeightScale];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.text = string;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.layer.cornerRadius = 3;
    promptLabel.clipsToBounds = YES;
    promptLabel.font = [UIFont systemFontOfSize:15];
    promptLabel.backgroundColor = [UIColor blackColor];
    promptLabel.frame = CGRectMake((kScreenWidth - (strWidth+30))/2, 600*kHeightScale, strWidth+30, 70*kHeightScale);
    
    [self.view addSubview:promptLabel];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationDelegate:self];
    promptLabel.alpha =0.0;
    [UIView commitAnimations];//2秒后消失
    
    
    
}



//是宽度不变，动态改变高度
- (float)widthForString:(NSString*)value
               fontSize:(float)fontSize
              andHeight:(float)height
{
    
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                             lineBreakMode:NSLineBreakByCharWrapping];
    
    return sizeToFit.width;
}


@end