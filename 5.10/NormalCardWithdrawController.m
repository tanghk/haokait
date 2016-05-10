//
//  NormalCardWithdrawController.m
//  555
//
//  Created by otouzi on 16/4/12.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "NormalCardWithdrawController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "bangkaViewController.h"
#import "UIImageView+WebCache.h"
#import "tixianwebViewController.h"

@interface NormalCardWithdrawController ()
{
    
    UILabel *_canBeWithdrawalAmount;//可提现金额
    UILabel *_withdrawalAmount;//提现金额
    UITextField *_enterAmount;//输入金额
    NSString *_available_balance;//可用余额
    NSString *_amount_entered;//输入金额
    UIView * _withdrawalAmountView;
    UIView *_bgView;
 
    
    
    
   
    UIWindow *_lastWindow;        //当前window
    UIControl *_maskView;         //遮挡视图
    
    UILabel *_contentLabel;//提示框内容
    UIView *_rechargeView;//提示窗口
   

    UILabel *_withdrawFeeLabel;//提现手续费
    UILabel *_withdrawFee;//提现手续费

    
    
    UILabel *_realityAmountLabel;//实际到账金额
    UILabel *_realityAmount;//实际到账金额
    
    //线
    UILabel *_linebottom2;

     UILabel * _bankCard;//到账银行卡
    
    UILabel *_cardholder;//持卡人

     UILabel *_addCard;//+添加
    
    UIImageView *_bankCardview;//添加银行卡｜｜选卡

    UIButton *_addCardBtn;//添加按钮

    UIImageView *_bankLogo;//银行卡logo
    UILabel *_bankName;//银行卡名字
    
    NSString *_cardNumber;//银行卡号
    
    NSString *_bankCardNumber;

    
  
    
    UIImageView *_arrowImageView;//箭头
    
    UIButton *_addChooseCardBtn;//按钮
  
    UILabel *_descripition;//预计24小时
    UIButton *_withdrawBtn;// 提现按钮
    

    
    /*
     *快捷卡
     */
    BOOL _hasDefaultBankCard;  //data-bankCard-hasDefaultBankCard
    
    /*
     *普卡
     */
    
    BOOL _bind_bankcard; //data-chinapnr-bind_bankcard


}
@end

@implementation NormalCardWithdrawController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //[self requesrUserCenterData];
    [self creatWithNavGation];
    
    [self requesrUserCenterData];
    [self myBankCard];

    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
  
    [self custumViews];
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
    
    
    
    _bgView = [UIView new];
    _bgView.backgroundColor = kcolorGrayNew;
    [self.view addSubview:_bgView];
    
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        
    }];
    
    
    
    
#pragma mark -可提现金额
    
    UILabel *canBeWithdrawalLabel =[UILabel new];
    canBeWithdrawalLabel.font =Font(42/3);
    canBeWithdrawalLabel.text =@"可提现金额(元)  ：";
    canBeWithdrawalLabel.textColor =kcolorFontGray;
    
    [_bgView addSubview:canBeWithdrawalLabel];
    
    [canBeWithdrawalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(_bgView.mas_top).offset(0.030*kScreenHeight);
        make.width.mas_equalTo(365/3);
        make.height.mas_equalTo(14);
        
        
    }];
    
    _canBeWithdrawalAmount = [UILabel new];
    _canBeWithdrawalAmount.font = Font(42/3);
    //_canBeWithdrawalAmount.text = @"213.3";
    _canBeWithdrawalAmount.textColor = kColorMain;
    
    [_bgView addSubview:_canBeWithdrawalAmount];
    
    [_canBeWithdrawalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.left.equalTo(canBeWithdrawalLabel.mas_right).offset(0.018*kScreenWidth);
        make.left.equalTo(canBeWithdrawalLabel.mas_right);
        
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.top.equalTo(_bgView.mas_top).offset(0.030*kScreenHeight);
        make.height.mas_equalTo(14);
        
        
    }];
    
    
    
    
    
    //线
    UILabel *lineGray = [UILabel new];
    lineGray.backgroundColor =RGB(217, 217, 217, 1) ;
    [_bgView addSubview:lineGray];
    [lineGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_canBeWithdrawalAmount.mas_bottom).offset(0.03*kScreenHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    
    
    
    
    /*
     *提现金额视图
     */
    _withdrawalAmountView= [[UIView  alloc]init];
    _withdrawalAmountView .backgroundColor = kColorWhite;
    
    [_bgView addSubview:_withdrawalAmountView];
    
    [_withdrawalAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(lineGray.mas_bottom);
        make.height.mas_equalTo(0.081*kScreenHeight);
        make.width.mas_equalTo(kScreenWidth);
        
        
    }];
    
    
    
    
    //线
    UILabel *linebottom = [UILabel new];
    linebottom .backgroundColor =RGB(217, 217, 217, 1) ;
    [_bgView addSubview:linebottom ];
    [linebottom  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalAmountView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    
#pragma mark -提现金额
    _withdrawalAmount= [UILabel new];
    _withdrawalAmount.text = @"提现金额(元)";
    _withdrawalAmount.font = Font(48/3);
    
    [_withdrawalAmountView addSubview:_withdrawalAmount];
    
    [_withdrawalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);
        make.top.equalTo(_withdrawalAmountView.mas_top).offset(0.029*kScreenHeight);
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
    
    
    [_withdrawalAmountView addSubview:_enterAmount];
    
    [_enterAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalAmountView.mas_top);
        //  make.left.equalTo(_withdrawalAmount.mas_right).offset(0.018*kScreenWidth);
        make.left.equalTo(_withdrawalAmount.mas_right);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        // make.height.mas_equalTo(16);
        make.height.mas_equalTo(0.081*kScreenHeight);
    }];
    
    
    
    
    
    
    /*
     *到账银行卡
     */
    
#pragma mark -到账银行卡
    _bankCard = [UILabel new];
    [_bgView addSubview:_bankCard];
    
    _bankCard.text = @"到账银行卡";
    _bankCard.font= Font(42/3);
    

    
    [_bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);;
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_withdrawalAmountView.mas_bottom).offset(0.039*kScreenHeight);
        make.height.mas_equalTo(14);
        
    }];

   

    _bankCardview = [UIImageView new];
    _bankCardview.image = [UIImage imageNamed:@"bankCard"];
       [_bgView addSubview:_bankCardview];
  
   
    /*
     *没有绑定卡
     */
    [_bankCardview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];
    

    
    /*
     *银行卡按钮
     */
    
    _addChooseCardBtn = [UIButton new];
    
    [_addChooseCardBtn addTarget:self
                          action:@selector(addCardBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    _addChooseCardBtn.adjustsImageWhenHighlighted = NO;
    //  [priceBtn setAdjustsImageWhenHighlighted:NO];
    [_bgView addSubview:_addChooseCardBtn];
  
    
    
    [_addChooseCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];

    
  
    
    
    
    
    
#pragma mark -提现按钮
    _withdrawBtn =[UIButton new];
    [_withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_withdrawBtn setBackgroundColor:kColorMain];
    _withdrawBtn.layer.cornerRadius = 6;
    _withdrawBtn.titleLabel.font = Font(58/3);
    _withdrawBtn.titleLabel.font = Font(0.026*kScreenHeight);
    [_withdrawBtn addTarget:self
                    action:@selector(withdrawAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView addSubview:_withdrawBtn];
    
    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0.031*kScreenWidth);
        make.right.equalTo(_bgView.mas_right).offset(-0.031*kScreenWidth);
        make.top.equalTo(_addChooseCardBtn.mas_bottom).offset(0.069*kScreenHeight);
        make.height.mas_equalTo(0.079*kScreenHeight);
        
    }];
    
    
}



#pragma mark - 加载数据
#pragma mark－用户中心
- (void)requesrUserCenterData{
    
    [DataService requestWithURL:@"/user/center"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [ self loadUserCenterData :result];
                    
                    
                    
                }];
    
    
    
    
    
}
#pragma mark -银行卡信息
- (void)myBankCard{
    
    [DataService requestWithURL:@"/mybankcard"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [self loadmyBankCardData:result];
                    
                    
                }];
    
    
    
    
    
    
}

#pragma mark -提现点击事件
- (void)withdrawAction:(UIButton*)sender{
    
    
    if (_amount_entered ==nil) {
        
        [self promptView:@"请输入金额"];
    }else{
        if ([_amount_entered intValue]== 0) {
            
             [self promptView:@"请重新输入金额"];
            
        }else{
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithDictionary:@{
                                                        @"bankcard": _bankCardNumber,   //用户银行卡号id
                                                        @"transamt": _amount_entered
                                                        
                                                        } ];
        
        
        [DataService requestWithURL:@"/user/reply"
                             params:params
                         httpMethod:@"post"
                    completionBlock:^(id result) {
                        [self loadWithdraw:result];
                        
                    }];
        
    }
        
    }
}



#pragma mark -用户中心加载数据
- (void)loadUserCenterData:(id)result{
    
    NSLog(@"用户中心%@",result);
    
    NSDictionary *reponseDic =result;
    
    
    NSNumber *code = reponseDic[@"code"];
    
    if ([code intValue] ==200)
    {
        
        NSDictionary *dataDic = reponseDic[@"data"];
        
        
        
        /*
         *快捷卡判断
         */
        
        NSDictionary *bankCardDic = dataDic[@"bankCard"];
        
        _hasDefaultBankCard = [bankCardDic[@"hasDefaultBankCard"]boolValue];
        
        NSLog(@"快捷卡判断:%d",_hasDefaultBankCard);
        
        
        /*
         *判断普卡
         */
        
        NSDictionary *chinapnrDic = dataDic[@"chinapnr"];
        _bind_bankcard = [chinapnrDic[@"bind_bankcard"] boolValue] ;
        NSLog(@"普卡判断:%d",_bind_bankcard);
        
        
        /*
         *user_chinapnr_info
         */
        NSDictionary *user_chinapnr_infoDic = dataDic[@"user_chinapnr_info"];
        
        
        _available_balance = [NSString stringWithFormat:@"%@",user_chinapnr_infoDic[@"available_balance"]];
        
        if ([_available_balance isEqualToString:@"0"]||[_available_balance isEqualToString:@"0.0"]||[_available_balance isEqualToString:@"0.00"]) {
            
            _canBeWithdrawalAmount.text =@"0.00元";//余额
            
        }else{
            
            _canBeWithdrawalAmount.text = [NSString stringWithFormat:@"%@元",_available_balance];//余额
        }
        
        
        


 /*
  *没有绑定卡
  */
        if (_bind_bankcard ==YES) {
            [self noBindCard];
            
               _bankCardview.image = [UIImage imageNamed:@"addcard"];
            
            
        }else{
        
        
           _bankCardview.image = [UIImage imageNamed:@"bankCard"];
            [self hasBindCard];
            
            _cardholder.text =[NSString stringWithFormat:@"持卡人：%@", user_chinapnr_infoDic[@"realname"]];//姓名
            

            
        }
          }else{
        
        
        
    }
    
    
}


#pragma mark - 添加银行卡
- (void)loadmyBankCardData:(id)result{
    
    
    NSLog(@"%@",result);
    
    
    NSDictionary *responseDic = result;
    
    NSNumber *code = responseDic[@"code"];
    
    if ([code intValue] ==200) {
        
        NSDictionary *dataDic = responseDic[@"data"];
        BOOL isDefaultCard = [dataDic[@"isDefaultCard"]boolValue];
        
        if (isDefaultCard == YES) {
            
            NSArray *listArray  = dataDic[@"list"];
            NSDictionary * bankCardData = [listArray lastObject];
            NSString * logo =bankCardData[@"logo"];
            
            _cardNumber = [NSString stringWithFormat:@"%@",bankCardData[@"card"]];
            NSString *cardNumb = [_cardNumber substringFromIndex:_cardNumber.length-4];
            _bankCardNumber = [NSString stringWithFormat:@"%@",bankCardData[@"bankcard"]];
            
            [_bankLogo sd_setImageWithURL:[NSURL URLWithString:logo]];
            _bankName.text = [NSString stringWithFormat:@"%@(尾号%@)",bankCardData[@"bankname"],cardNumb];
            
            
            
        }else{
            
            
        }
        
        
        
    }else{
        
        
    }
    
    
   
}

#pragma mark - 提现事件
- (void)loadWithdraw:(id)result{
    NSLog(@"提现跳转%@",result);
    
    NSDictionary *responseDic = result;
    NSNumber *code =responseDic[@"code"];
    if ([code intValue] !=200) {
        NSLog(@"%@",responseDic[@"data"]);
        
        [self promptView:responseDic[@"data"]];
        
    }else{
        NSDictionary *dataDic = responseDic[@"data"];
        NSString *href = [NSString stringWithFormat:@"%@",dataDic[@"href"]];
        
        
        tixianwebViewController *webtixian = [[tixianwebViewController alloc]init];
        webtixian.withdraw = href;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        
        [self presentViewController:webtixian animated:NO completion:nil];
        
        
        
        
    }
    
    
    
}


#pragma mark - 添加银行卡
- (void)addCardBtnAction:(UIButton *)sender{

    [self addBankCard];
    
    

}

#pragma mark -选择银行卡
- (void)chooseCardBtnAction:(UIButton *)sender{
    
}

#pragma mark - 触摸释放textfiled
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_enterAmount resignFirstResponder];
    
    
}


# pragma mark - texfieild代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"1%@",textField.text);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"2%@",textField.text);
    
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"3结束编辑%@",textField.text);
//
//
//
//}

- (void)textFiledChanged:(UITextField *)textField{
    
    NSLog(@"4结束编辑%@",textField.text);
    
    _amount_entered = textField.text;
    
    if ([_amount_entered floatValue]>=[_available_balance floatValue]) {
        _enterAmount.text =_available_balance;
        _amount_entered =_available_balance;
        //        _enterAmount =[NSString stringWithFormat:@"%.2f",[_available_balance floatValue]];
    }else{
        
        
    }
    
}
#pragma mark - 更改银行卡
- (void)changeCardAction:(UIButton *)sender{
    NSLog(@"更改银行卡");
    
 //   [self showPromptWindow];
    [self addBankCard];
    

    
    
    
}

- (void)promptView:(NSString *)string{
    
    
    UILabel *promptLabel= [[UILabel alloc]init];
    CGFloat strWidth = [ self widthForString:string
                                    fontSize:11
                                   andHeight:42*kHeightScale];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.text = string;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.layer.cornerRadius = 3;
    promptLabel.clipsToBounds = YES;
    promptLabel.font = [UIFont systemFontOfSize:11];
    promptLabel.backgroundColor = [UIColor blackColor];
    promptLabel.frame = CGRectMake((kScreenWidth - (strWidth+30))/2, 650*kHeightScale, strWidth+30, 42*kHeightScale);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




#pragma mark -提示充值弹窗

//创建遮盖视图
- (void)createMaskView{
    
    
    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
    _rechargeView.layer.cornerRadius = 3;
    //    _rechargeView.frame = CGRectMake(0.163*kScreenWidth, 0.425*kScreenHeight, kScreenWidth - 2*0.163*kScreenWidth, 0.149*kScreenHeight);
    _rechargeView.frame = CGRectMake((kScreenWidth-820/3)/2, 0.379*kScreenHeight, 820/3, 0.169*kScreenHeight);
    
    
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_rechargeView];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    //_contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 1;
    _contentLabel.font = [UIFont systemFontOfSize:30/2];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = [NSString stringWithFormat:@"请电脑登录www.otouzi.com进行操作"];
    [_rechargeView addSubview:_contentLabel];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_rechargeView.mas_top).offset(0.042*kScreenHeight);
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
        make.top.equalTo(_contentLabel.mas_bottom).offset(0.038*kScreenHeight);
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

#pragma mark - 确认按钮点击事件

/*
 *确认按钮
 */

- (void)sureAction:(UIButton *)sender{
    
    [self hidePromptWindow];
    
}




#pragma mark - 提示信息
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

#pragma mark -遮挡视图点击事件
- (void)maskViewAction:(UIControl *)sender{
    
    
    [self hidePromptWindow];
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
#pragma mark - 返回按钮
- (void)backBtnAction:(UIButton*)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
#pragma mark -没有普卡
- (void)noBindCard{

    

    
    _withdrawFeeLabel.hidden = YES;//提现手续费
    _withdrawFee.hidden = YES;//提现手续费
    
    
    
    _realityAmountLabel.hidden = YES;//实际到账金额
    _realityAmount.hidden = YES;//实际到账金额
    
    //线
    _linebottom2.hidden = YES;
    
  
    
    _cardholder.hidden = YES;//持卡人
    _addCard.hidden =YES;//+添加
    _bankLogo.hidden =YES;//银行卡logo
   _bankName.hidden = YES;//银行卡名字
    
    
    
    
    
    _arrowImageView.hidden =YES;//箭头
   _descripition.hidden = YES;//预计24小时
    
    

    

}

- (void)hasBindCard{

#pragma mark -提现手续费
    
    
    _withdrawFeeLabel = [UILabel new];
    _withdrawFeeLabel.font = Font(42/3);
    _withdrawFeeLabel.text = @"提现手续费(元):";
    _withdrawFeeLabel.textColor = kcolorFontGray;
    [_bgView addSubview:_withdrawFeeLabel];
    
    [_withdrawFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(_withdrawalAmountView.mas_bottom).offset(0.030*kScreenHeight);
        make.width.mas_equalTo(349/3);
        make.height.mas_equalTo(14);
        
        
    }];
    
    
    _withdrawFee = [UILabel new];
    _withdrawFee.font = Font(42/3);
    _withdrawFee.text = @"0.00元";
    _withdrawFee.textColor = kcolorFontGray;
    [_bgView addSubview:_withdrawFee];
    
    [_withdrawFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_withdrawFeeLabel.mas_right).offset(0.018*kScreenWidth);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.top.equalTo(_withdrawalAmountView.mas_bottom).offset(0.030*kScreenHeight);
        make.height.mas_equalTo(14);
        
        
    }];
    
#pragma mark -实际到账金额
    
    _realityAmountLabel =[UILabel new];
    _realityAmountLabel.font = Font(42/3);
    _realityAmountLabel.text = @"实际到账金额(元):";
    _realityAmountLabel.textColor = kcolorFontGray;
    [_bgView addSubview:_realityAmountLabel];
    [_realityAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(_withdrawFeeLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.width.mas_equalTo(403/3);
        make.height.mas_equalTo(14);
        
        
    }];
    
    
    
    
    
    _realityAmount = [UILabel new];
    _realityAmount.font = Font(42/3);
    _realityAmount.text = @"100.21元";
    _realityAmount.textColor = kcolorFontGray;
    [_bgView addSubview:_realityAmount];
    
    
    [_realityAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_realityAmountLabel.mas_right);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.top.equalTo(_withdrawFeeLabel.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(14);
        
        
    }];
    
    

    //线
    _linebottom2 = [UILabel new];
    _linebottom2 .backgroundColor =RGB(217, 217, 217, 1) ;
    [_bgView addSubview:_linebottom2 ];
    [_linebottom2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_realityAmountLabel.mas_bottom).offset(0.038*kScreenHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(@(1));
        
        
    }];
    
    [_bankCard removeFromSuperview];
    
    _bankCard = [UILabel new];
    [_bgView addSubview:_bankCard];
    
    _bankCard.text = @"到账银行卡";
    _bankCard.font= Font(42/3);
    
    
    [_bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);;
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_linebottom2.mas_bottom).offset(0.039*kScreenHeight);
        make.height.mas_equalTo(14);
        
    }];
    

#pragma mark -持卡人
    
    _cardholder = [UILabel new];
    _cardholder.font= Font(42/3);
    _cardholder.textColor = kcolorFontGray;
    _cardholder.textAlignment = NSTextAlignmentLeft;
    [_bgView addSubview: _cardholder];
    [_cardholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);;
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(349/3);
        
    }];
    
#pragma mark -添加银行卡
    
    
    
    
    
    _addCard =[UILabel new];
    _addCard.text =@"+添加";
    _addCard.font = Font(42/3);
    _addCard.textColor =kColorMain;
       // changeCard.layer.borderWidth = 1;
    [_bgView addSubview:_addCard];
    
    
    [_addCard mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(115/3);
        
    }];
    
    
    
    _addCardBtn =[UIButton new];
    _addCardBtn.titleLabel.font = Font(42/3);
      [_addCardBtn setTitleColor:kColorMain forState:UIControlStateNormal];
    _addCardBtn.adjustsImageWhenHighlighted = NO;
    [_addCardBtn addTarget:self
                    action:@selector(changeCardAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    [_bgView addSubview:_addCardBtn];
    
    
    [_addCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(-0.039*kScreenWidth);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight-5);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(120/3+0.017*2*kScreenWidth);
        
    }];
    
    

    
#pragma mark -银行卡logo
    
    _bankLogo = [UIImageView new];
    
    [_bankCardview addSubview:_bankLogo];
    
    [_bankLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankCardview.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(_bankCardview.mas_top).offset(55/3);
        make.width.mas_equalTo(72/3);
        make.height.mas_equalTo(72/3);
        
    }];
    
    
    
    _bankName = [UILabel new];
    _bankName.font = Font(45/3);
    _bankName.textColor = kcolorFontGray;
    
    [_bankCardview addSubview:_bankName];
    
    [_bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankLogo.mas_right).offset(0.031*kScreenWidth);
        make.top.equalTo(_bankCardview.mas_top).offset(69/3);
        make.height.mas_equalTo(45/3);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        
        
    }];
    
    
    
#pragma mark -箭头
    _arrowImageView = [UIImageView new];
    _arrowImageView.image = [UIImage imageNamed:@"withdraw_pulldown"];
    
    [_bankCardview addSubview:_arrowImageView];
    
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bankCardview.mas_right).offset(-0.039*kScreenWidth);
        make.top.equalTo(_bankCardview.mas_top).offset(76/3);
        make.width.mas_equalTo(44/3);
        make.height.mas_equalTo(29/3);
        
        
    }];
    
    
    
    
#pragma mark -预计当天24点之前到账
    _descripition = [UILabel new];
    _descripition.text = @"预计当天24点之前到账";
    _descripition.font = Font(42/3);
    _descripition.textColor = kcolorFontGray;
    [_bgView addSubview:_descripition];
    
    [_descripition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_bankCardview.mas_bottom).offset(0.043*kScreenHeight);
        make.height.mas_equalTo(14);
        
    }];
    
    

    
    
    [_bankCardview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_cardholder.mas_bottom).offset(0.028*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];

    /*
     *有银行卡的布局
     */
    
    
    [_addChooseCardBtn removeFromSuperview];
    _addChooseCardBtn = [UIButton new];
    
     _addChooseCardBtn.adjustsImageWhenHighlighted = NO;
    //  [priceBtn setAdjustsImageWhenHighlighted:NO];
    [_bgView addSubview:_addChooseCardBtn];
    

    [_addChooseCardBtn addTarget:self
                          action:@selector(chooseCardBtnAction:)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    [_bankCardview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_cardholder.mas_bottom).offset(0.028*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];
    
    
    

    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0.031*kScreenWidth);
        make.right.equalTo(_bgView.mas_right).offset(-0.031*kScreenWidth);
        make.top.equalTo(_descripition.mas_bottom).offset(0.044*kScreenHeight);
        make.height.mas_equalTo(0.079*kScreenHeight);
        
    }];
    
    
  
    
}
@end
