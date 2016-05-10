//
//  ShortcutCardWithdrawController.m
//  555
//
//  Created by otouzi on 16/4/12.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "ShortcutCardWithdrawController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "DataService.h"
#import "bangkaViewController.h"
#import "UIImageView+WebCache.h"
#import "tixianwebViewController.h"
#import "UIViewExt.h"
@interface ShortcutCardWithdrawController ()
{
    
    
    UILabel *_canBeWithdrawalAmount;//可提现金额
    UILabel *_withdrawalAmount;//提现金额
    UITextField *_enterAmount;//输入金额
    // NSString *_available_balance;//可用余额
    
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
    
    
    UIView *_footerView;//尾部银行卡视图
    /*
     *快捷卡
     */
    BOOL _hasDefaultBankCard;  //data-bankCard-hasDefaultBankCard
    
    /*
     *普卡
     */
    
    BOOL _bind_bankcard; //data-chinapnr-bind_bankcard
    
    
    
    
    
    
    NSString *_bankNameValue;
    BOOL witchBank;
    BOOL workday;
    BOOL workingTime;
    
    
    NSString *_withdrawFeeValue;//提现手续费
    NSString *_realityAmountValue;//实际到账金额
    UIView *_withdrawPrompt;
    
    
}
@end

@implementation ShortcutCardWithdrawController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //[self requesrUserCenterData];
    [self creatWithNavGation];
  //  [self requesrUserCenterData];
    [self myBankCard];
    
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self custumViews];
    [self createMaskView];
    [self withdrawPrompt];
    
    
    
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
    
    if ([_available_balance isEqualToString:@"0"]||[_available_balance isEqualToString:@"0.0"]||[_available_balance isEqualToString:@"0.00"]) {
        
        _canBeWithdrawalAmount.text =@"0.00元";//余额
        
    }else{
        
        _canBeWithdrawalAmount.text = [NSString stringWithFormat:@"%@元",_available_balance];//余额
    }
    
    
    
    
    
    
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
    
    _enterAmount.keyboardType = UIKeyboardTypeDecimalPad  ;
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
    _realityAmount.text = @"0.00元";
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
    _cardholder.text =[NSString stringWithFormat:@"持卡人：%@",_realname];//姓名
    _cardholder.textColor = kcolorFontGray;
    _cardholder.textAlignment = NSTextAlignmentLeft;
    [_bgView addSubview: _cardholder];
    [_cardholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.056*kScreenWidth);;
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(349/3);
        
    }];
    
    
#pragma mark -更改银行卡
    
    
    
    
    
    UILabel *changeCard =[UILabel new];
    changeCard.text =@"更换银行卡";
    changeCard.font = Font(42/3);
    changeCard.textColor =kColorMain;
   // changeCard.layer.borderWidth = 1;
    [_bgView addSubview:changeCard];
    
    
    [changeCard mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(-0.032*kScreenWidth);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(210/3);
        
    }];


  
    UIButton *changeCardBtn =[UIButton new];
    [changeCardBtn setTitle:@"更换银行卡" forState:UIControlStateNormal];
    
    changeCardBtn.titleLabel.font = Font(42/3);
    //changeCardBtn.layer.borderWidth = 1;
    [changeCardBtn setTitleColor:kColorMain forState:UIControlStateNormal];
    changeCardBtn.adjustsImageWhenHighlighted = NO;
    [changeCardBtn addTarget:self
                      action:@selector(changeCardAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    [_bgView addSubview:changeCardBtn];
    
    
    [changeCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(-0.032*kScreenWidth);
        make.top.equalTo(_bankCard.mas_bottom).offset(0.025*kScreenHeight-5);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(210/3);
        
    }];
    
    

    
    /*
     *银行卡
     */
    
    
    UIImageView *bankCardview = [UIImageView new];
    bankCardview.image = [UIImage imageNamed:@"bankCard"];
    //[addCard setImage:[UIImage imageNamed:@"bankCard"] forState:UIControlStateNormal];
//    [addCard addTarget:self
//                action:@selector(addBankCard)
//      forControlEvents:UIControlEventTouchUpInside];
//    addCard.adjustsImageWhenHighlighted = NO;
    //  [priceBtn setAdjustsImageWhenHighlighted:NO];
    [_bgView addSubview:bankCardview];
    
    [bankCardview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.right.equalTo(_bgView.mas_right);
        make.top.equalTo(_cardholder.mas_bottom).offset(0.028*kScreenHeight);
        make.height.mas_equalTo(181/3);
        
    }];
    
#pragma mark -银行卡logo
    
    _bankLogo = [UIImageView new];
    
    [bankCardview addSubview:_bankLogo];
    
    [_bankLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankCardview.mas_left).offset(0.056*kScreenWidth);
        make.top.equalTo(bankCardview.mas_top).offset(55/3);
        make.width.mas_equalTo(72/3);
        make.height.mas_equalTo(72/3);
        
    }];
    
    
    
    _bankName = [UILabel new];
    _bankName.font = Font(45/3);
    _bankName.textColor = kcolorFontGray;
    
    [bankCardview addSubview:_bankName];
    
    [_bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankLogo.mas_right).offset(0.031*kScreenWidth);
        make.top.equalTo(bankCardview.mas_top).offset(69/3);
        make.height.mas_equalTo(45/3);
        make.right.equalTo(self.view).offset(-0.056*kScreenWidth);
        
        
    }];
    
    
    
    
    
    
    
#pragma mark -预计当天24点之前到账
    UILabel *descripition = [UILabel new];
    descripition.text = @"预计当天24点之前到账";
    descripition.font = Font(42/3);
    descripition.textColor = kcolorFontGray;
    [_bgView addSubview:descripition];
    
    [descripition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(bankCardview.mas_bottom).offset(0.043*kScreenHeight);
        make.height.mas_equalTo(14);
        
    }];
    
    

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
        make.top.equalTo(descripition.mas_bottom).offset(0.044*kScreenHeight);
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
                 //   [ self loadUserCenterData :result];
                    
                    
                    
                }];
    
    
    
    
    
}
#pragma mark -银行卡信息
- (void)myBankCard{
    
    [DataService requestWithURL:@"/mybankcard"
                         params:nil
                     httpMethod:@"get"
                completionBlock:^(id result) {
                    [self loadBankCardData:result];
                    
                    
                }];
    
    
    
    
    
    
}

#pragma mark -提现点击事件
- (void)withdrawAction:(UIButton*)sender{
    
       [_enterAmount resignFirstResponder];
    
    if (_amount_entered.length<1) {
        
        [self promptView:@"请输入金额"];
    }else{
        
        if ([_amount_entered intValue]== 0) {
            
            [self promptView:@"请重新输入金额"];
            
        }else{
            if ([_amount_entered floatValue]>[_available_balance floatValue]) {
                
                [self promptView:@"提现金额不可大于可提现金额"];
                
            }else{
                
                
                if ([_withdrawFeeValue floatValue]>[_available_balance floatValue] ) {
                    
                    
                    [self promptView:@"提现手续费不可大于可提现金额"];
                    
                    //  _withdrawBtn.userInteractionEnabled = NO;
                }else{
                    if ([_realityAmountValue floatValue]<=0) {
                        _realityAmount.text =@"0.00元";//可提现金额
                        
                        [self promptView:@"提现手续费大于可提现金额"];

                        //_withdrawBtn.userInteractionEnabled = NO;
                    }else{
                        
                        [self showWithdrawPromptWindow];
 
                        
                    }
                    
                }
                
            }
        }
        
        
    }
}


/*
#pragma mark -用户中心加载数据
- (void)loadUserCenterData:(id)result{
    
    NSLog(@"用户中心%@",result);
    
    NSDictionary *reponseDic =result;
    
    
    NSNumber *code = reponseDic[@"code"];
    
    if ([code intValue] ==200)
    {
        
        NSDictionary *dataDic = reponseDic[@"data"];
        
 // user_chinapnr_info

 
        NSDictionary *user_chinapnr_infoDic = dataDic[@"user_chinapnr_info"];
        
        
        _available_balance = [NSString stringWithFormat:@"%@",user_chinapnr_infoDic[@"available_balance"]];
        
        if ([_available_balance isEqualToString:@"0"]||[_available_balance isEqualToString:@"0.0"]||[_available_balance isEqualToString:@"0.00"]) {
            
            _canBeWithdrawalAmount.text =@"0.00元";//余额
            
        }else{
            
            _canBeWithdrawalAmount.text = [NSString stringWithFormat:@"%@元",_available_balance];//余额
        }
        

        
        
    
        _cardholder.text =[NSString stringWithFormat:@"持卡人：%@", user_chinapnr_infoDic[@"realname"]];//姓名
        
    }else{
        
        
        
    }
    
    
}
*/

#pragma mark - 添加银行卡
- (void)loadBankCardData:(id)result{
    
    
    NSLog(@"%@",result);
    
    
     NSDictionary *responseDic = result;
    
    NSNumber *code = responseDic[@"code"];
    
    if ([code intValue] ==200) {
       
        NSDictionary *dataDic = responseDic[@"data"];
       
        
        
        
        _available_balance = [NSString stringWithFormat:@"%@",dataDic[@"available"]];
        
        if ([_available_balance isEqualToString:@"0"]||[_available_balance isEqualToString:@"0.0"]||[_available_balance isEqualToString:@"0.00"]) {
            
            _canBeWithdrawalAmount.text =@"0.00元";//余额
            
        }else{
            
            _canBeWithdrawalAmount.text = [NSString stringWithFormat:@"%@元",_available_balance];//余额
        }
        
  
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
            
            /*
             *银行卡名字
             */
            _bankNameValue =[NSString stringWithFormat:@"%@",bankCardData[@"bankname"]];
            
            
            
            
            witchBank = [self witchBank:_bankNameValue];
            
            NSLog(@"是否是银行列表内银行%d",witchBank);
            

            
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
    // [self.navigationController popViewControllerAnimated:YES];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
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

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"3结束编辑%@",textField.text);
//    
//    
//    
//}

- (void)textFiledChanged:(UITextField *)textField{
    
    NSLog(@"4结束编辑%@",textField.text);
    textField.clearsOnBeginEditing = YES;
    

    _amount_entered = textField.text;
    
    workingTime = [self isBetweenFromHour:8 toHour:18];
    
    if (textField.text.length<1) {//字符串长度
        
        _withdrawFee.text = [NSString stringWithFormat:@"0.00元"];//手续费
        _realityAmount.text =[NSString stringWithFormat:@"0.00元"];//可提现金额
        
        
        
    }else{
    

    if (workingTime == YES&&witchBank == YES&&_is_holiday ==NO) {//是否工作日
        if ([_amount_entered floatValue]>=1000) {//输入金额>=1000
 
    
            _realityAmount.text =[NSString stringWithFormat:@"%@元",_amount_entered];
            _withdrawFee.text = [NSString stringWithFormat:@"0.00元"];//手续费
            _withdrawFeeValue = @"0.00";
          
        }else{//输入金额<1000
        
        
            NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                              
                                              decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                              
                                              scale:2
                                              
                                              raiseOnExactness:NO
                                              
                                              raiseOnOverflow:NO
                                              
                                              raiseOnUnderflow:NO
                                              
                                              raiseOnDivideByZero:YES];
            
            NSDecimalNumber*subtotal = [NSDecimalNumber decimalNumberWithString:_amount_entered];
            
            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@".0005"];
            
            NSDecimalNumber*total = [subtotal decimalNumberByMultiplyingBy:discount
                                     
                                                              withBehavior:roundUp];
            
            NSLog(@"Rounded total: %@", total);
         
            
                   /*
             *如果明天是节假日
             */
            if (_tomrrow_Is_Holiday ==YES) {
  
             _withdrawFeeValue = [NSString stringWithFormat:@"%.2f",([total floatValue]*[_holiday_days intValue] )+2];//手续费

                _withdrawFee.text =[NSString stringWithFormat:@"%@元",_withdrawFeeValue];
                
                _realityAmountValue = [NSString stringWithFormat:@"%.2f",[_amount_entered floatValue]-[total floatValue]-2];
                _realityAmount.text =[NSString stringWithFormat:@"%@元",_realityAmountValue];//实际到账金额

                
            }else{
            
            
                
                _withdrawFeeValue = [NSString stringWithFormat:@"%.2f",[total floatValue]+2];//手续费
                _withdrawFee.text =[NSString stringWithFormat:@"%@元",_withdrawFeeValue];
                
                _realityAmountValue = [NSString stringWithFormat:@"%.2f",[_amount_entered floatValue]-[total floatValue]-2];
                _realityAmount.text =[NSString stringWithFormat:@"%@元",_realityAmountValue];//实际到账金额
                
                

            
            }
            
            
            
            
            
            
        }
        
        /*
         *  _withdrawFeeValue    手续费
         *  _amount_entered      输入的金额
         *  _realityAmountValue  可提现金额
         *  _available_balance   可用余额
         *  _realityAmount       实际到账金额
         */
        

        //取现后的余额
        CGFloat LastBalance = [_available_balance floatValue]-[_amount_entered floatValue];
        
        NSLog(@"取现金后余额：%.2f",LastBalance);
        if ([_withdrawFeeValue floatValue]<=LastBalance) {
            _realityAmount.text = [NSString stringWithFormat:@"%.2f元",[_amount_entered floatValue]];
      
           NSLog(@"实际到账金额%@",_realityAmount.text);

        
        }else{
        
        
            CGFloat realyValue = [_amount_entered floatValue]-[_withdrawFeeValue floatValue];
            if (realyValue<=0.00) {
                _realityAmount.text =@"0.00元";
            }else{
                
                _realityAmount.text =[NSString stringWithFormat:@"%.2f元",realyValue];

            }
            NSLog(@"实际到账金额%@",_realityAmount.text);
            
            
            }

    
        
        
        
        
        
    }else{
        
    
        /*
         *工作日其他时间段 或 周末 或 非以上列表银行卡 取现手续费
         */
        if ([_amount_entered floatValue]>=1000) {
            
            
            
            _realityAmount.text =[NSString stringWithFormat:@"%@元",_amount_entered];
            _withdrawFee.text = [NSString stringWithFormat:@"0.00元"];//手续费

            _withdrawFeeValue = @"0.00";

            
        }else{
        
            
                _withdrawFeeValue = [NSString stringWithFormat:@"2.00"];//手续费
                _withdrawFee.text =[NSString stringWithFormat:@"%@元",_withdrawFeeValue];
                
                _realityAmountValue =[NSString stringWithFormat:@"%.2f",[_amount_entered floatValue]-2];
                _realityAmount.text =[NSString stringWithFormat:@"%@元",_realityAmountValue];//实际到账金额

        }

    
        /*
         *  _withdrawFeeValue    手续费
         *  _amount_entered      输入的金额
         *  _realityAmountValue  可提现金额
         *  _available_balance   可用余额
         *  _realityAmount       实际到账金额
         */
        
        
        
        //取现后的余额
        CGFloat LastBalance = [_available_balance floatValue]-[_amount_entered floatValue];
        
        NSLog(@"取现金后余额：%.2f",LastBalance);
        if ([_withdrawFeeValue floatValue]<=LastBalance) {
            _realityAmount.text = [NSString stringWithFormat:@"%.2f元",[_amount_entered floatValue]];
        }else{
            
            
            CGFloat realyValue = [_amount_entered floatValue]-[_withdrawFeeValue floatValue];
           if (realyValue<=0.00) {
                  _realityAmount.text =@"0.00元";
            }else{
            
                _realityAmount.text =[NSString stringWithFormat:@"%.2f元",realyValue];
                
            
            }
            NSLog(@"实际到账金额%@",_realityAmount.text);
        }
 
        
    }
    
    
    }
    
    
}
#pragma mark - 更改银行卡
- (void)changeCardAction:(UIButton *)sender{
    NSLog(@"更改银行卡");
  [_enterAmount resignFirstResponder];
    [self showPromptWindow];
       



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
    promptLabel.frame = CGRectMake((kScreenWidth - (strWidth+30))/2, 650*kHeightScale, strWidth+30, 50*kHeightScale);
    
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


-(void)withdrawPrompt{


    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    //提示弹窗
    _withdrawPrompt = [[UIView alloc]init];
    _withdrawPrompt.layer.cornerRadius =0;
   
    if (iphone5x_4_0) {
        _withdrawPrompt.frame = CGRectMake(12, 0.105*kScreenHeight, kScreenWidth - 24, 0.799*kScreenHeight);
        
    }else if (iphone6_4_7){
    
      _withdrawPrompt.frame = CGRectMake(12, 0.125*kScreenHeight, kScreenWidth - 24, 0.609*kScreenHeight);
    
    }else if (iphone6Plus_5_5){
      _withdrawPrompt.frame = CGRectMake(12, 0.125*kScreenHeight, kScreenWidth - 24, 0.562*kScreenHeight);
    
    
    }else{
    
       _withdrawPrompt.frame = CGRectMake(12, 0.105*kScreenHeight, kScreenWidth - 24, 0.799*kScreenHeight);
    
    
    }
    
   // _withdrawPrompt.frame = CGRectMake(12, 0.125*kScreenHeight, kScreenWidth - 24, 0.749*kScreenHeight);
    
    _withdrawPrompt.hidden = YES;
    _withdrawPrompt.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_withdrawPrompt];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    //_contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:28/2];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [ _withdrawPrompt addSubview:_contentLabel];
    
    _contentLabel.frame = CGRectMake(10, 30,_withdrawPrompt.width-20, 0.018*kScreenHeight) ;
    

    _contentLabel.text = [NSString stringWithFormat:@"1、取现金额大于等于1000元，提现免手续费;\n2、取现金额小于1000元，将收取2元+提现金额的0.05%%作为转账费用,节假日前一个工作日另按照提现金额的0.05%%*（节假日天数+1）+2元收取；\n3、当日网银充值的资金当日不可取现，您的可取现金额=账户余额-当日网银充值金额；\n4、工商、农业、建行、中行、招商、民生、交行、邮储、浦发、渤海、光大、兴业、浙商、广发、华夏、平安、上海农商银行、北京农商行、深发展、北京银行、杭州银行、南京银行、浙江泰隆商业银行的银行卡工作日（周一至周五）8:00-18:00内申请提现，当日到账，其余时间为下一个工作日到账；\n5、除以上列出的银行卡外，其他类银行卡提现均为下一个工作日到账。"];
    

    

    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: _contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:2];
    
    paragraphStyle.paragraphSpacing = 10;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ _contentLabel.text length])];
    [ _contentLabel setAttributedText:attributedString];
    
    
    
    [_contentLabel sizeToFit];
    
    //确认
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    sureButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82)*kPlusScale)/2, 110*kPlusScale);
    
    
    
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 3;
    sureButton.tag = 9009;
    [sureButton setBackgroundColor:kColorMain];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_withdrawPrompt addSubview:sureButton];
//    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_rechargeView.mas_centerX);
//        make.top.equalTo(_contentLabel.mas_bottom).offset(0.038*kScreenHeight);
//        make.width.mas_equalTo(0.230*kScreenWidth);
//        make.height.mas_equalTo(0.052*kScreenHeight);
//        
//    }];
//    
    
    //取消按钮
   UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = RGB(180, 180, 180, 1);
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 3;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleButton addTarget:self
                      action:@selector(cancelAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [_withdrawPrompt addSubview:cancleButton];
    
    


    
    
    [ sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_withdrawPrompt.mas_left).offset(0.083*kScreenWidth);
        make.top.equalTo(_contentLabel.mas_bottom).offset(0.038*kScreenHeight);
        make.height.mas_equalTo(0.058*kScreenHeight);
        
    }];
    
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sureButton.mas_right).offset(0.054*kScreenWidth);
        make.top.equalTo(_contentLabel.mas_bottom).offset(0.038*kScreenHeight);
        make.width.equalTo(sureButton.mas_width);
        make.height.mas_equalTo(0.058*kScreenHeight);
        make.right.equalTo(_withdrawPrompt.mas_right).offset(-0.083*kScreenWidth);
        
        
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
    sureButton.tag = 9008;

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
    if (sender.tag ==9008) {
        [self hidePromptWindow];
        
    }else{
        
        
        [self hideWithdrawPromptWindow];

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
        
        

        
        //提现
        
    }
    
    

    
}




- (void)cancelAction:(UIButton *)sender{
  
    [self hideWithdrawPromptWindow];
    
}


#pragma mark - 提示信息
/*
 *显示提示框
 */

- (void)showWithdrawPromptWindow{

    [UIView animateWithDuration:.35 animations:^{
        _withdrawPrompt.hidden = NO;
           _maskView.hidden = NO;
    }];

}


-(void)hideWithdrawPromptWindow{



    [UIView animateWithDuration:.35 animations:^{
        _withdrawPrompt.hidden = YES;
              _maskView.hidden = YES;
        
    }];

}


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
    
    [self hideWithdrawPromptWindow];

    [self hidePromptWindow];
}





- (BOOL)witchBank:(NSString *)bankName{


    if ([bankName isEqualToString:@"中国工商银行"]||
        [bankName isEqualToString:@"招商银行"]||
        [bankName isEqualToString:@"中国农业银行"]||
        [bankName isEqualToString:@"中国银行"]||
        [bankName isEqualToString:@"渤海银行"]||
        [bankName isEqualToString:@"中国光大银行"]||
        [bankName isEqualToString:@"中国建设银行"]||
        [bankName isEqualToString:@"兴业银行"]||
        [bankName isEqualToString:@"浙商银行"]||
        [bankName isEqualToString:@"广发银行"]||
        [bankName isEqualToString:@"华夏银行"]||
        [bankName isEqualToString:@"平安银行"]||
        [bankName isEqualToString:@"上海农村商业银行"]
        
  
        /*
         *中国工商银行     ICBC
         中国农业银行     ABC
         中国招商银行     CMB
         中国建设银行     CCB
         北京银行         BCCB
         北京农商银行     BJRCB
         中国银行         BOC
         交通银行         BOCOM
         民生银行         CMBC
         上海银行         BOS
         渤海银行         CBHB
         光大银行         CEB
         兴业银行         CIB
         中信银行         CITIC
         浙商银行         CZB
         广发银行         GDB
         东亚银行         HKBEA
         华夏银行         HXB
         杭州银行         HZCB
         南京银行         NJCB
         平安银行         PINGAN
         邮储银行         PSBC
         深发银行         SDB
         浦发银行         SPDB
         上海农村商业银行  SRCB
         */
        
        
        
        
        ) {
        return YES ;
    }

    return NO;
    

}
/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [self getCustomDateWithHour: fromHour ];
    NSDate *date23 = [self getCustomDateWithHour: toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        NSLog(@ "该时间在 %ld:00-%ld:00 之间！" , fromHour, toHour);
        return YES;
    }
    NSLog(@ "不在该时间在 %ld:00-%ld:00 之间！" , fromHour, toHour);

    return NO;
}





/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}




- (void)weekday{

    //initializtion parameter
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
   // week = [comps weekday];
//    month = [comps month];
//    day = [comps day];
//    hour = [comps hour];
//    min = [comps minute];
//    sec = [comps second];




}


+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}




//
//    NSString *numO = @"1.取现金额大于等于1000元，提现免手续费，小于1000元，将收取2元+提现金额的0.05%%作为转账费用；";
//    NSString *numS = @"2当日网银充值的资金当日不可取现，您的可取现金额=账户余额-当日网银充值金额；";
//    NSString *numT = @"3.工商、农业、中行、建行、招商、民生、邮储、渤海、光大、兴业、浙商、广发、华夏、平安、交行、浦发、北京农商行、深发展、北京银行、杭州银行、南京银行、浙江泰隆商业银行、上海农商银行的银行卡工作日（周一至周五）8:00-18:00内申请提现，当日到账，其余时间为下一个工作日到账；";
//    NSString *numF = @"4.除以上列出的银行卡外，其他类银行卡提现均为下一个工作日到账。";
//
//

@end
