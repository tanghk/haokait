//
//  TouziViewController.m
//  
//
//  Created by otouzi on 15/11/2.
//
//

#import "TouziViewController.h"
#import "disafangViewController.h"
#import "UICommons.h"
#import "UIViewExt.h"
#import "ProductInvestViewController.h"

#import "chongzhiViewController.h"
#import "DataService.h"
#import "CLLockVC.h"
#import "Masonry.h"
@interface TouziViewController ()

@end

@implementation TouziViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    

        [self requestUserInfo];
        
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWithNavGation];

   // [self performSelector:@selector(lockView) withObject:nil afterDelay:0.5];
    

   
    
    
    self.title = @"投资";
    UIColor *backcolor = RGB(245, 245, 245, 1);
    self.view.backgroundColor = backcolor;
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //[self createSubView];

  

    //当前window
    _lastWindow =[UIApplication sharedApplication].windows.lastObject;
    
    NSLog(@"#############%@",_investTextField.text);

}

- (instancetype)init{
    self = [super init];
    if (self) {
       [self createSubView];//创建子视图
      
    }
    return self;

}
#pragma mark - 导航栏
- (void)creatWithNavGation{
   
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, kScreenWidth, 32/2);
    titleLabel.text = @"投资";
    titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
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



- (void)setModel:(ListModel *)model{
    _model = model;
    NSLog(@"%@",_model);
   
    
    
    _productId = model.product_id;
      NSLog(@"%@",_productId);


    _deadline_key = model.deadline_key;
       _way_repayment_key = model.way_repayment_key;
     }



- (void)requestUserInfo{

    if ([_way_repayment_key intValue] == 4) {
   
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithDictionary:@{@"id":_productId,
                                                        @"behavior":@"InvestmentNoviceCoupon"
                                                        }];
        [DataService requestWithURL:@"/user/info"
                             params:params httpMethod:@"post"
                    completionBlock:^(id result) {
                        [self loadtUserInfoData:result];
                        NSLog(@"新手标＃＃＃＃＃＃＃＃＃%@",result);
  
                        
                    }];

        
        
    }else{
       
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithDictionary:@{@"id":_productId,
                                                                                                               }];
        [DataService requestWithURL:@"/user/info"
                             params:params httpMethod:@"post"
                    completionBlock:^(id result) {
                        [self loadtUserInfoData:result];
                       NSLog(@"可用余额＃＃＃＃＃＃＃＃＃%@",result);
     
                        [self requsetProductInfo];
   
                    }];
 
        
        
    }

    
  }


-(void)loadtUserInfoData:(id)result{


    NSDictionary *newUser = result;
    NSMutableDictionary *dataDic = [newUser objectForKey:@"data"];
    
  

    
    if ([_way_repayment_key intValue]==4) {
        
        
        NSMutableDictionary *couponDic = [dataDic objectForKey:@"coupon"];
        NSMutableDictionary *novice_project_infoDic = [couponDic objectForKey:@"novice_project_info"];
        
        _productId =[NSString stringWithFormat:@"%@",[novice_project_infoDic objectForKey:@"id"]];
        

        _nameLabel.text = [novice_project_infoDic objectForKey:@"name"];
        
        NSString *noviceRevenue = [novice_project_infoDic  objectForKey:@"revenue"];
        _revenueLabel.text =[NSString stringWithFormat:@"%@%%", noviceRevenue];
        
        
        _deadlineLabel.text = [novice_project_infoDic  objectForKey:@"deadline"];
        
        _repaymentLabel.text = [novice_project_infoDic  objectForKey:@"way_repayment"];
//        NSString *novieceDeadlineKey = [novice_project_infoDic  objectForKey:@"deadline_key"];
//        _deadline_key =[NSString stringWithFormat:@"%@",novieceDeadlineKey];
//      
        NSMutableDictionary *user_novice = [couponDic objectForKey:@"user_novice"];
       
        _noviceMoney = [user_novice objectForKey:@"money"];
       // _investTextField.placeholder=_noviceMoney;
        _investTextField.text = [NSString stringWithFormat:@"%@",_noviceMoney];
        if ([_investTextField.text intValue] <=0) {
            _nextButton.backgroundColor = kColorLightGray;
            _nextButton.userInteractionEnabled = NO;
        }
        _investTextField .userInteractionEnabled = NO;
        _investTextField.clearButtonMode = UITextFieldViewModeNever;
        _introductionLabel.text = @"";
        _questionButtton.hidden = YES;
        _increaseLabel.hidden = YES;

        double textValue =  [_noviceMoney doubleValue] ;
        
        _principal = [NSString stringWithFormat:@"%.10f",textValue];
        NSLog(@"输入金额= %@",_principal);
        
        
        //年华收益
        double  revenueValue = [_revenueLabel.text doubleValue];
        double increaseValue = [_increase  doubleValue];//角标
        double revenue = revenueValue/100;
        double increase = increaseValue/100;
        NSLog(@"%.10f",sum);
        
        
        _revenue = [NSString stringWithFormat:@"%.10f",revenue];
        NSLog(@"年华收益=%@",_revenue);
        _increaseStr = [NSString stringWithFormat:@"%.10f",increase];
        NSLog(@"奖励的年华收益=%@",_increaseStr);
        //求幂次的方法
        /*
         double s = pow([_principal doubleValue], delineValue);
         NSLog(@"输出的结果是%.2f",s);
         */
        
        //按月付息 到期还本     ，到期还本付息
        NSLog(@"投资期限%@",_deadline_key);
        sum = ([_principal doubleValue]*([_revenue doubleValue]+[_increaseStr doubleValue])* [_deadline_key intValue])/365;//输入金额＊年华收益＊投资期限＊30/365

        
        //计算器保留小数点后两位
        NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler
                                             
                                             decimalNumberHandlerWithRoundingMode:NSRoundDown
                                             
                                             scale:2
                                             
                                             raiseOnExactness:NO
                                             
                                             raiseOnOverflow:NO
                                             
                                             raiseOnUnderflow:NO
                                             
                                             raiseOnDivideByZero:YES];
        
        NSDecimalNumber *ouncesDecimal;
        NSDecimalNumber *roundedOunces;
        
        ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:sum];
        roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundDown];
        
        NSString *str = [NSString stringWithFormat:@"%@",roundedOunces];
        NSLog(@"保留两位小数%@",str);
        
 
        _incomeLabel.text = [NSString stringWithFormat:@"%@",str];
        
         

    }
    
    
    /*
     *用户可用余额
     */
    NSMutableDictionary *user_chinapnr_infoDic =[dataDic objectForKey:@"user_chinapnr_info"];

    _available= [user_chinapnr_infoDic objectForKey:@"available"];
  
    
    _balanceLabel.text =_available;
    
    



}

#pragma mark - 网络请求
-(void)requsetProductInfo{
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithDictionary:@{@"id":_productId,
                                                  
                                                      }];
    
[DataService requestWithURL:@"/product/info"
                     params:params httpMethod:@"post"
            completionBlock:^(id result) {
                [self loadProductInfoData:result];
             
}];
    
   
}

- (void)loadProductInfoData:(id)result{

    NSDictionary *productInfoDic = result;
    
    NSLog(@"投资产品信息：%@",productInfoDic);
    NSDictionary *dataDic = [productInfoDic objectForKey:@"data"];
    
    NSDictionary *userInfoDic = [dataDic objectForKey:@"user_info"];
    
    NSDictionary *projectInfoDic =[dataDic objectForKey:@"project_info"];
    
   
    _increase = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"increase"]] ;
 
    
    
    //可投资金额  剩余金额
    CGFloat st = [[projectInfoDic objectForKey:@"money"] floatValue];
    CGFloat sr =[ [dataDic objectForKey:@"money_sum" ]  floatValue];
    _difference = (st - sr);
    
//    NSString *deadlineKeyString = [productInfoDic objectForKey:@"deadline_key"];
//
//    _deadline_key = [NSString stringWithFormat:@"%@",deadlineKeyString];
    
    
    if (_difference>=100){
        
        _introductionLabel.text = @"100元起投,10元递增";
        
        
    }else{
        
        _introductionLabel.text = @"10元起投,10元递增";
    }

    if (_difference<= 0) {
        
        
        _nextButton.backgroundColor = kColorLightGray;
        _nextButton.userInteractionEnabled = NO;
    }
    
    _nameLabel.text = [projectInfoDic objectForKey:@"name"];
    
    NSString *revenue = [projectInfoDic objectForKey:@"revenue"];
     _revenueLabel.text =[NSString stringWithFormat:@"%@%%", revenue];
    
    
    _deadlineLabel.text = [projectInfoDic objectForKey:@"deadline"];
    
    _repaymentLabel.text = [projectInfoDic objectForKey:@"way_repayment"];
    
 // _increase =
  //  NSString *increase = [dataDic objectForKey:@"increase"];
  
    double increasenum =  [_increase  doubleValue];
    _increaseLabel.text = [NSString stringWithFormat:@" +%.1f%%",increasenum];
    
    _increaseLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([_increase isEqualToString:@"0"]||[_increase isEqualToString:@"0.0"]) {
        _increaseLabel.hidden = YES;
    }
    
    _invest_money = [projectInfoDic objectForKey:@"invest_money"];
    
    
   // NSLog(@"产品投资_invest_money:%@",_invest_money);
    _way_repayment_key = [projectInfoDic objectForKey:@"way_repayment_key"];
    

    double balance =[_available doubleValue];

  
    /*
     *产品余额大于100
     */
        if (_difference >100) {
            if (balance<100) {
               _investTextField.text =@"0";//[NSString stringWithFormat:@"%f",_difference];
    
    
            }else{
            
                if (balance>_difference) {
                    _investTextField.text = [NSString stringWithFormat:@"%.f",_difference];
                }else{
                
                    int tempMoney = balance/100;
                    _investTextField.text =[NSString stringWithFormat:@"%d00",tempMoney];
                 
                   }
               }
        }
    /*
     *产品余额小于100
     */


        else{
           
          
            if (balance<10) {
                
                _investTextField.text =@"";
                
                if (_difference <=0||balance ==0) {
                    _investTextField.text = @"0";
                     _nextButton.backgroundColor = kColorLightGray;
                    _nextButton.userInteractionEnabled = NO;
                  
                }
                
              
            }else{
            
                if (balance>_difference) {
                    _investTextField.text = [NSString stringWithFormat:@"%.f",_difference];
                }else{
                    
                    int tMoney = balance/10;
                    _investTextField.text =[NSString stringWithFormat:@"%d0",tMoney];
                }
                
            }
    
        
      }

    
    
    [self textField:_investTextField];
    
    
    
}



# pragma mark - 创建子视图
- (void)createSubView{
    
    //背景视图
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 24*kHeightScale+kNavigationBarHeight+0.5, kScreenWidth, (110+86+86)*kHeightScale-0.5);
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    //产品名称
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(42*kWidthScale, (37)*kHeightScale, kScreenWidth-28*kHeightScale-42*kHeightScale, 30/2);
   // _nameLabel.text =@"粮食买卖生意收购粮食资金";
    
    _nameLabel.font = [UIFont systemFontOfSize:30/2];
    
    [bgView addSubview:_nameLabel];
    
    //新手标
    _newImageView = [[UIImageView alloc]init];
    [bgView addSubview:_newImageView];
    
   
    //线
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [bgView addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 225.0/255.0, 225.0/255.0, 225.0/255.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 24*kWidthScale,101*kHeightScale);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),kScreenWidth-24*kWidthScale,101*kHeightScale );   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //年华收益text
    _revenueText = [[UILabel alloc]init];
    _revenueText.frame = CGRectMake(42*kWidthScale, (32+101)*kHeightScale, 110/2, 24/2);
    _revenueText.text = @"年化收益:";
    _revenueText.textColor = kColorGray;
    _revenueText.font = [UIFont systemFontOfSize:24/2];
    
    [bgView addSubview:_revenueText];
    
    
    
    //年华收益
    _revenueLabel = [[UILabel alloc]init];
    _revenueLabel.frame = CGRectMake((42)*kWidthScale+110/2, (32+101)*kHeightScale, 84/2, 24/2);
    //_revenueLabel.text = @"14.8%";
    
    _revenueLabel.font = [UIFont systemFontOfSize:24/2];
    //_revenueLabel.textAlignment = NSTextAlignmentCenter;
    //_revenueLabel.layer.borderWidth=1;
    _revenueLabel.textColor = kColorRed;
    [bgView addSubview:_revenueLabel];
    
    
    // 奖励升级（角标）
    _increaseLabel = [[UILabel alloc]init];
    _increaseLabel.frame = CGRectMake((42+12)*kWidthScale+(110+78)/2, (24+101)*kHeightScale, 76/2, 31/2);
    //_increaseLabel.text = @"   +0.2%";
    _increaseLabel.font = [UIFont systemFontOfSize:16/2];
    _increaseLabel.textColor = RGB(255, 255, 255, 1);
    //_increaseLabel.textAlignment = NSTextAlignmentRight;
    _increaseLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6PTIcon2"]];
    
    [bgView addSubview:_increaseLabel];
    
    //投资期限text
    _deadlineText = [[UILabel alloc]init];
    _deadlineText.frame = CGRectMake((42+121)*kWidthScale+(110+78+76)*kWidthScale, (32+101)*kHeightScale, 110/2, 24/2);
    _deadlineText.font = [UIFont systemFontOfSize:24/2];
    _deadlineText.text = @"投资期限:";
    _deadlineText.textColor = kColorGray;
    
    [bgView addSubview:_deadlineText];
    
    //投资期限
    _deadlineLabel = [[UILabel alloc]init];
    _deadlineLabel.frame = CGRectMake((42+110+78+76+121)*kWidthScale+110/2, (32+101)*kHeightScale, 80/2,24/2);
    _deadlineLabel.font = [UIFont systemFontOfSize:24/2];
    _deadlineLabel.textAlignment = NSTextAlignmentLeft;
    //_deadlineLabel.text = @"24个月";
    
    
    [bgView addSubview:_deadlineLabel];
    
    //线
    UIImageView *imageView2=[[UIImageView alloc] initWithFrame:self.view.frame];
    [bgView addSubview:imageView2];
    
    UIGraphicsBeginImageContext(imageView2.frame.size);
    [imageView2.image drawInRect:CGRectMake(0, 0, imageView2.frame.size.width, imageView2.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 225.0/255.0, 225.0/255.0, 225.0/255.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 24*kWidthScale,(101+86)*kHeightScale);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),kScreenWidth-24*kWidthScale,(101+86)*kHeightScale );   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView2.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //还款方式text
    _repaymentText = [[UILabel alloc]init];
    _repaymentText.frame = CGRectMake(42*kWidthScale, (86+110+32)*kHeightScale,110/2, 24/2);
    _repaymentText.textColor = kColorGray;
    _repaymentText.font = [UIFont systemFontOfSize:24/2];
    _repaymentText.text = @"还款方式:";
    
    [bgView addSubview:_repaymentText];
    
    
    //还款方式
    _repaymentLabel = [[UILabel alloc]init];
    _repaymentLabel.frame = CGRectMake(42*kWidthScale+110/2, (86+110+32)*kHeightScale, 214/2, 24/2);
    //_repaymentLabel.text = @"按月付息到期还本";
  
    _repaymentLabel.font = [UIFont systemFontOfSize:24/2];
    
    [bgView addSubview:_repaymentLabel];
    
    //10元起投资
    
    _introductionLabel = [[UILabel alloc]init];
    _introductionLabel.frame = CGRectMake((30+72)*kWidthScale+(110+214)*kWidthScale, (86+110+32)*kHeightScale,238/2, 24/2);
    //_introductionLabel.text = @"10元起投，10元递增";
   // _introductionLabel.textColor = kColorRed;
    _introductionLabel.font = [UIFont systemFontOfSize:24/2];
    
    [bgView addSubview:_introductionLabel];
    
    //问号图片
    _questionButtton = [UIButton buttonWithType:UIButtonTypeCustom];
    _questionButtton.frame = CGRectMake((30+72+17)*kWidthScale+(110+214)*kWidthScale+222/2-5, (86+110+27)*kHeightScale-2, 45/2, 45/2);
   
    [_questionButtton setImage:[UIImage imageNamed:@"6PTIcon3"] forState:UIControlStateNormal];
    [_questionButtton setImage:[UIImage imageNamed:@"6PTIcon3"] forState:UIControlStateSelected];
    
    [_questionButtton addTarget:self
                         action:@selector(questiomAction:)
               forControlEvents:UIControlEventTouchUpInside];
    count = 1;
    [bgView addSubview:_questionButtton];
    if (iphone5x_4_0) {
        _questionButtton.frame = CGRectMake((30+72)*kWidthScale+(110+214)*kWidthScale+218/2, (86+110+27)*kHeightScale-4, 45/2, 45/2);

    }
    
    
    //投资视图
    UIView *investView = [[UIView alloc]init];
    investView.frame = CGRectMake(0, (24+101+86+86+49)*kWidthScale+kNavigationBarHeight, kScreenWidth, 101*kHeightScale);
    investView.backgroundColor = [UIColor whiteColor];
    investView.layer.borderWidth = 1;
    UIColor *lineColor = RGB(225, 225, 225, 1);
    investView.layer.borderColor = [lineColor CGColor];
    
    [self.view addSubview:investView];
    
    
    //投资金额textlabel
    _investText= [[UILabel alloc]init];
    _investText.frame = CGRectMake(42*kWidthScale, 37*kHeightScale, 212/2,30/2);
    _investText.text = @"投标金额(元):";
    _investText.font = [UIFont systemFontOfSize:30/2];
    [investView addSubview:_investText];
    
    //投资金额textfield
    _investTextField = [[UITextField alloc]init];
    _investTextField.frame = CGRectMake((42)*kWidthScale+212/2, 37*kHeightScale, 460*kWidthScale, 30/2);
    _investTextField.placeholder  = @"请输入投资金额";
    _investTextField.font = [UIFont systemFontOfSize:30/2];
 
    _investTextField.delegate = self;
     _investTextField.keyboardType = UIKeyboardTypeNumberPad;
    _investTextField.clearButtonMode = UITextFieldViewModeAlways;
    [_investTextField addTarget:self
                         action:@selector(textField:)
               forControlEvents:UIControlEventEditingChanged];
    
    NSLog(@"%@",_investTextField.text );
    
    
    [investView addSubview:_investTextField];
    
    
 
    //可用余额视图
    UIView *incomeView = [[UIView alloc]init];
      //incomeView.layer.borderWidth = 1;
    incomeView.backgroundColor = [UIColor whiteColor];
    incomeView.layer.cornerRadius = (48*kWidthScale)/2;
    
    [self.view addSubview:incomeView];
    
    if (iphone4x_3_5) {
        incomeView.frame = CGRectMake(24*kWidthScale, (24+101+86+86+49+101+24+48)*kHeightScale+kNavigationBarHeight, kScreenWidth - (24+24)*kWidthScale, 48*kHeightScale);

    }else{
    
        incomeView.frame = CGRectMake(24*kWidthScale, (24+101+86+86+49+101+24)*kHeightScale+kNavigationBarHeight, kScreenWidth - (24+24)*kWidthScale, 48*kHeightScale);

    
    
    }
    
    
    //可用余额text;
    _balanceText = [[UILabel alloc]init];
    _balanceText.frame = CGRectMake(87*kWidthScale, 15*kHeightScale, 100/2, 20/2);
    _balanceText.text = @"可用余额:";
    _balanceText.textColor = kColorGray;
    _balanceText.font = [UIFont systemFontOfSize:20/2];
    
    [incomeView addSubview:_balanceText];
    
    
    
    
    //可用余额
    _balanceLabel = [[UILabel alloc]init];
    _balanceLabel.frame = CGRectMake(87*kWidthScale+100/2, 15*kHeightScale, 162/2, 20/2);
   //_balanceLabel.text = @"0.00元";
    _balanceLabel.textColor = kColorGray;
    _balanceLabel.font = [UIFont systemFontOfSize:20/2];
    
    [incomeView addSubview:_balanceLabel];
    
    //线
    UIImageView *imageView3=[[UIImageView alloc] initWithFrame:self.view.frame];
    [incomeView addSubview:imageView3];
    
    UIGraphicsBeginImageContext(imageView3.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView3.frame.size.width, imageView3.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0/255.0, 0.0/255.0, 0.0/255.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), incomeView.width/2,15*kHeightScale);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),incomeView.width/2,35*kHeightScale );   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView3
    .image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //预期收益text
    _investText = [[UILabel alloc]init];
    _investText.frame = CGRectMake((87+79)*kWidthScale+100/2+162/2, 15*kHeightScale
                                   , 100/2, 20/2);
    _investText.text = @"预期收益:";
    _investText.textColor = kColorRed;
    _investText.font = [UIFont systemFontOfSize:20/2];
    
    [incomeView addSubview:_investText];
    
    
    //预期收益
    _incomeLabel = [[UILabel alloc]init];
    _incomeLabel.frame  =CGRectMake((87+79)*kWidthScale+100/2+162/2+100/2, 15*kHeightScale, 162/2, 20/2);
    _incomeLabel.text = @"0.00元";
    _incomeLabel.textColor = kColorRed;
    _incomeLabel.font = [UIFont systemFontOfSize:20/2];
    
    [incomeView addSubview:_incomeLabel];
    
    if (iphone5x_4_0) {
        _investText.frame = CGRectMake((87+35)*kWidthScale+100/2+162/2, 15*kHeightScale
                                       , 100/2, 20/2);
        _incomeLabel.frame  =CGRectMake((87+35)*kWidthScale+100/2+162/2+100/2, 15*kHeightScale, 162/2, 20/2);


    }
    
    //下一步button
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    _nextButton.backgroundColor = kColorRed;
  
    
    if (iphone4x_3_5) {
          _nextButton.frame = CGRectMake(24*kWidthScale, (24+101+86+86+49+101+24+48+48+48)*kHeightScale+kNavigationBarHeight, kScreenWidth - (24+24)*kWidthScale, 88*kHeightScale);
    }else{
    
      _nextButton.frame = CGRectMake(24*kWidthScale, (24+101+86+86+49+101+24+48+48)*kHeightScale+kNavigationBarHeight, kScreenWidth - (24+24)*kWidthScale, 88*kHeightScale);
    }
   
    
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton addTarget:self
                    action:@selector(nextAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nextButton];
    
    //logo图片盾牌
    UIImageView *logoImageView = [[UIImageView alloc]init];
  
    logoImageView.image = [UIImage imageNamed:@"6PTIcon5"];
    
    [self.view addSubview:logoImageView];
    
    //wordlabel
    UILabel *wordlabel = [[UILabel alloc]init];
      wordlabel.text = @"账户资金安全全由汇付天下托管";
    wordlabel.font = [UIFont systemFontOfSize:20/2];
    
    [self.view addSubview:wordlabel];
    
    if (iphone4x_3_5) {
        
        logoImageView .frame = CGRectMake(193*kWidthScale, (24+101+86+86+49+101+24+48+48+88+27+48)*kHeightScale+kNavigationBarHeight,24/2, 29/2);
        
        wordlabel.frame = CGRectMake((193+16)*kWidthScale+24/2, (24+101+86+86+49+101+24+48+48+88+31+48)*kHeightScale+kNavigationBarHeight, 304/2, 22/2);

    }else{
    
      logoImageView .frame = CGRectMake(193*kWidthScale, (24+101+86+86+49+101+24+48+48+88+27)*kHeightScale+kNavigationBarHeight,24/2, 29/2);
    
        wordlabel.frame = CGRectMake((193+16)*kWidthScale+24/2, (24+101+86+86+49+101+24+48+48+88+31)*kHeightScale+kNavigationBarHeight, 304/2, 22/2);

    }
    
    
    
    
    
    //点击？显示00
    _noteLabel =[[UILabel alloc]init];
    _noteLabel.frame = CGRectMake(kScreenWidth-24*kWidthScale-424
                                  
                                  /2, 408*kHeightScale, 414/2, 107/2);
    _noteLabel.text = @"  可投金额>=100元时，100元起投，10元递增\n  可投金额<100元时，10元起投，10元递增";
    _noteLabel.numberOfLines = 0
    ;
    _noteLabel.font = [UIFont systemFontOfSize:18/2];
    _noteLabel.textColor = [UIColor whiteColor];
    _noteLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6PTDui3"]];
    _noteLabel.hidden = YES;
    
    [self.view addSubview:_noteLabel];
    
    if(iphone6_4_7){
        _noteLabel.frame = CGRectMake(kScreenWidth-26*kWidthScale-428
                                      
                                      /2, 412*kHeightScale+1, 414/2, 107/2);

    }else if (iphone6Plus_5_5){
    
    
        _noteLabel.frame = CGRectMake(kScreenWidth-52*kWidthScale-432
                                      
                                      /2, 395*kHeightScale+1.5, 414/2, 107/2);

    
    }else{
    
        _noteLabel.frame = CGRectMake(kScreenWidth-420
                                      
                                      /2, 441*kHeightScale, 414/2, 107/2);
        

    }
   
    


}




#pragma mark -提示充值弹窗

- (void)promptWindow{

  
   
    //提示弹窗
    _rechargeView = [[UIView alloc]init];
   _rechargeView.frame = CGRectMake(202*kPlusScale, 657*kPlusScale, kScreenWidth - (202+202)*kPlusScale, 0);
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_rechargeView];
    
    //文本内容
   _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:28/2];
    _contentLabel.text = [NSString stringWithFormat:@"您当前可用的余额%@元,小于购买余额%@元,请先充值",_balanceLabel.text,self.invest];
  
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:12/2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentLabel.text length])];
    [_contentLabel setAttributedText:attributedString];
    [_contentLabel sizeToFit];
    
    [_rechargeView addSubview:_contentLabel];
    
     //取消
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82+82+44)*kPlusScale)/2 ,110*kPlusScale);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = RGB(180, 180, 180, 1);
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 3;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleButton addTarget:self
                     action:@selector(cancleAction:)
           forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag = 1001;
    [_rechargeView addSubview:cancleButton];
    
    //立即充值
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(82*kPlusScale+44*kPlusScale+(_rechargeView.width-(82+82+44)*kPlusScale)/2, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82+82+44)*kPlusScale)/2, 110*kPlusScale);
    [sureButton setTitle:@"立即充值" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = RGB(211, 74, 89, 1);
    sureButton.layer.cornerRadius = 3;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    sureButton.tag = 1002;
    [_rechargeView addSubview:sureButton];
    
  _rechargeView.frame = CGRectMake(202*kPlusScale, 657*kPlusScale, kScreenWidth - (202+202)*kPlusScale,sureButton.height+sureButton.origin.y +60*kPlusHeightScale );

}

#pragma mark -提示余额不足框

- (void)residualAmountView{
    
    _residualAmountView = [[UIView alloc]init];
    
    //提示弹窗
    _residualAmountView = [[UIView alloc]init];
    _residualAmountView.frame =CGRectMake(202*kPlusScale, 657*kPlusScale, kScreenWidth - (202+202)*kPlusScale, 0);    _residualAmountView.hidden = YES;
    _residualAmountView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_residualAmountView];
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _residualAmountView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:24/2];
    _contentLabel.text = [NSString stringWithFormat:@"亲，当前剩余金额%.0f元,您的投资金额大于剩余金额",_difference];
    //contentLabel.layer.borderWidth = 1;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:12/2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentLabel.text length])];
    [_contentLabel setAttributedText:attributedString];
    [_contentLabel sizeToFit];
    
    [_residualAmountView addSubview:_contentLabel];
    
    //取消
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82+82+44)*kPlusScale)/2 ,110*kPlusScale);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:48/3];
    cancleButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *cancleColor = RGB(180, 180, 180, 1);
    [cancleButton setBackgroundColor:cancleColor];
    cancleButton.layer.cornerRadius = 3;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleButton addTarget:self
                     action:@selector(cancleAction:)
             forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag = 2001;
    [_residualAmountView addSubview:cancleButton];
    
    //立即充值
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(82*kPlusScale+44*kPlusScale+(_rechargeView.width-(82+82+44)*kPlusScale)/2, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82+82+44)*kPlusScale)/2, 110*kPlusScale);
    [sureButton setTitle:@"重新输入" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:48/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = RGB(211, 74, 89, 1);
    sureButton.layer.cornerRadius = 3;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    sureButton.tag = 2002;
    
    [_residualAmountView addSubview:sureButton];
    
    _residualAmountView.frame = CGRectMake(202*kPlusScale, 657*kPlusScale, kScreenWidth - (202+202)*kPlusScale,sureButton.height+sureButton.origin.y +60*kPlusHeightScale );
    
}

#pragma mark -遮盖视图
//创建遮盖视图
- (void)createMaskView{
    
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
#pragma mark - 按钮点击事件

#pragma mark -点击事件
//问题按钮
- (void)questiomAction:(UIButton *)sender{
    
    _noteLabel.hidden = !_noteLabel.hidden;
    
    
}


//  下一步
- (void)nextAction:(UIButton *)sender{
    [_investTextField resignFirstResponder];
 
    
    [self promptWindow];      //提示充值
    [self residualAmountView];//重新输入
    [self createMaskView];   //遮盖视图
    
    if ([_way_repayment_key intValue]==4) {
        
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithDictionary:
                                                                                      
                                                                                      
                                                                                      
              @{
                    @"id":_productId,                               // 投资产品id
                    @"money":_investTextField.text                     // 投资金额
                                }
         
                                                                                      
         ];
        [DataService requestWithURL:@"/product/invest"
                             params:params
                         httpMethod:@"post"
                    completionBlock:^(id result) {
            
                        
                        
                        NSLog(@"%@",result);
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        dic = result;
                        
                        NSString *codeaValue = [dic objectForKey:@"code"];
                        
                        
                        if ([codeaValue intValue] ==200) {
                            NSDictionary *dataValue = [dic objectForKey:@"data"];
                            NSString *urlValue = [dataValue objectForKey:@"href"];
                            
                            ProductInvestViewController *productInvestVC = [[ProductInvestViewController alloc]init];
                            productInvestVC.investUrl = urlValue;
                            productInvestVC.hidesBottomBarWhenPushed = YES;
      
                            [self.navigationController pushViewController:productInvestVC animated:YES];
                        }else{
                            
                            NSString*dataValue = [dic objectForKey:@"data"];
                            
                            
                            [self promptView:dataValue];
                            
                            
                            
                        }
      
                        
        }];
        
   
        
    }else{

    
    if (_difference>=100) {
        if ([_investTextField.text intValue]%10 != 0||[_investTextField.text intValue]<100)
        {
            
            [self promptView:@"100元起投，10元递增"];
    
        }else
        {
            
            NSLog(@"下一步投%@",_investTextField.text);

            if (_investTextField.text.length<1)
            {
                  [self promptView:@"请输入投资金额"];
                
                
            }else
            {
                
                if ([_balanceLabel.text intValue]<[_investTextField.text intValue]||[_balanceLabel.text isEqualToString:@"0.00"])
                { //我的余额小于输入金额
                    
                    
                    [self showPromptWindow];
                    NSLog(@"当前余额为%@元，小于购买余额%@元，请先充值",_balanceLabel.text,_investTextField.text);

               }
                else
                {
                    if (_difference<[_invest doubleValue] )
                    {

                        [self showEnttyAgainView];
             NSLog(@"亲，当前剩余金额%f元，您的投资金额%f大于剩余金额",_difference,[_invest doubleValue] );
                    }else
                    {
                       
                        
                        NSMutableDictionary *params =
                        [NSMutableDictionary dictionaryWithDictionary:

                           @{
                               @"id":_productId,                                     // 投资产品id
                               @"money":_investTextField.text                                   // 投资金额
                               }
                
                         ];
                        [DataService requestWithURL:@"/product/invest"
                                             params:params
                                         httpMethod:@"post"
                                    completionBlock:^(id result) {
                                        
                                        

                        
                        NSLog(@"%@",result);
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        dic = result;
                        
                        NSString *codeaValue = [dic objectForKey:@"code"];
                        
                        
                        if ([codeaValue intValue] ==200) {
                            NSDictionary *dataValue = [dic objectForKey:@"data"];
                            NSString *urlValue = [dataValue objectForKey:@"href"];
                            
                            
                            ProductInvestViewController *productInvestVC = [[ProductInvestViewController alloc]init];
                            productInvestVC.investUrl = urlValue;
                            productInvestVC.hidesBottomBarWhenPushed = YES;
                            
                            [self.navigationController pushViewController:productInvestVC animated:YES];
                            
                        }else{
                            NSString*dataValue = [dic objectForKey:@"data"];
                            [self promptView:dataValue];
                        }
                                   
                                    
                                    
                                    }];
                        
  
                    }
                }
                
            }

    
        }
    }else{
        
        /*
         *投资金额小于100
         */
        if ([_investTextField.text intValue]%10 != 0||[_investTextField.text intValue]==0)
        {
            
            [self promptView:@"10元起投，10元递增"];
            
        }else{
        
            
            NSLog(@"下一步投%@",_investTextField.text);
            if (_investTextField.text.length<1||_investTextField.text ==0) {
 
                [self promptView:@"请输入投资金额"];
  
            }else
            {
                
                if ([_balanceLabel.text intValue]<[_investTextField.text intValue] ||[_balanceLabel.text isEqualToString:@"0.00"])
                { //我的余额小于输入金额
                    
                    
                    [self showPromptWindow];
                    NSLog(@"当前余额为%@元，小于购买余额%@元，请先充值",_balanceLabel.text,_investTextField.text);
      
    
                }
                else{
                    if ([_invest intValue] >_difference)
                    {
                        [self showEnttyAgainView];
                        //            NSLog(@"亲，当前剩余金额%f元，您的投资金额大于剩余金额",_difference);
                    }else
                    {
                      
                       
                        
                        NSMutableDictionary *params =
                        [NSMutableDictionary dictionaryWithDictionary:

                         @{
                           @"id":_productId,                                     // 投资产品id
                           @"money":_investTextField.text                        // 投资金额
                           }
                         
                         
                         
                         ];
                        [DataService requestWithURL:@"/product/invest"
                                             params:params
                                         httpMethod:@"post"
                                    completionBlock:^(id result) {
                                        
                                        
                                        
                                        
                                        NSLog(@"%@",result);
                                        
                          NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                             dic = result;

                          NSString *codeaValue = [dic objectForKey:@"code"];
                        
                        
                        if ([codeaValue intValue] ==200) {
                            NSDictionary *dataValue = [dic objectForKey:@"data"];
                            NSString *urlValue = [dataValue objectForKey:@"href"];
                            
                            ProductInvestViewController *productInvestVC = [[ProductInvestViewController alloc]init];
                            productInvestVC.investUrl = urlValue;
                            productInvestVC.hidesBottomBarWhenPushed = YES;
                            
                            [self.navigationController pushViewController:productInvestVC animated:YES];
                            
                        }else{
                            
                            NSString*dataValue = [dic objectForKey:@"data"];
                            
                            [self promptView:dataValue];
                            
                            
                        }
                                        
                                        
                                    }];


 
                    }
                }
                
            }

        
        }
        
        
        }
    }

    
    
   }
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _noteLabel.hidden = YES;
    [_investTextField resignFirstResponder];
}

/*
 *代理方法实现
 */

- (void)textFieldDidEndEditing:(UITextField *)textField{



}

-(void)textField:(UITextField *)textField{
    
    
 
    BOOL isEid = [self validateNumberByRegExp:textField.text];
    
    if (isEid ==NO) {
       // textField.text = @"";
              NSLog(@"不可编辑");
    }
    
   /*
    *balance  用户剩余金额
    *_difference  产品可投金额
    */
    
    
    NSLog(@"投资金额%@",textField.text);
    textField.clearsOnBeginEditing = YES;
  
    if ([_investTextField.text intValue]>_difference) {
        textField.text = [NSString stringWithFormat:@"%.f",_difference];
        
        
        if (_difference<[_balanceLabel.text doubleValue]) {
           textField.text = [NSString stringWithFormat:@"%.0f",_difference];
        }
    }

    
    
    
    double textValue =  [_investTextField.text doubleValue] ;

    _principal = [NSString stringWithFormat:@"%.10f",textValue];
    NSLog(@"输入金额= %@",_principal);
    
    
    //年华收益
    double  revenueValue = [_revenueLabel.text doubleValue];
    double increaseValue = [_increase  doubleValue];//角标
    double revenue = revenueValue/100;
    double increase = increaseValue/100;
    NSLog(@"%.10f",sum);
    
    
    _revenue = [NSString stringWithFormat:@"%.10f",revenue];
     NSLog(@"年华收益=%@",_revenue);
    _increaseStr = [NSString stringWithFormat:@"%.10f",increase];
     NSLog(@"奖励的年华收益=%@",_increase);
    //求幂次的方法
    /*
     double s = pow([_principal doubleValue], delineValue);
     NSLog(@"输出的结果是%.2f",s);
     */
    
    //按月付息 到期还本     ，到期还本付息
    NSLog(@"投资期限%@",_deadline_key);
    sum = ([_principal doubleValue]*([_revenue doubleValue]+[_increaseStr doubleValue])* [_deadline_key intValue])/365;//输入金额＊年华收益＊投资期限＊30/365
    
    
    NSLog(@"按月付息 到期还本     ，到期还本付息%.10f",sum);
    
    //计算器保留小数点后两位
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler
                                         
                                         decimalNumberHandlerWithRoundingMode:NSRoundDown
                                         
                                         scale:2
                                         
                                         raiseOnExactness:NO
                                         
                                         raiseOnOverflow:NO
                                         
                                         raiseOnUnderflow:NO
                                         
                                         raiseOnDivideByZero:YES];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:sum];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundDown];
    
    NSString *str = [NSString stringWithFormat:@"%@",roundedOunces];
    NSLog(@"保留两位小数%@",str);
    
    
    
    
    
    
    
    
    //设贷款额为a，月利率为i，年利率为I，还款月数为n，每月还款额为b，还款利息总和为Y
    //还款总额:n×a×i×（1＋i）^n÷〔（1＋i）^n－1〕
    //注:a^b表示a的b次方。
    
    
    //_principal  投资金额   _tex2 年华收益
    // [_principal doubleValue]   //[_revenue doubleValue]
    
    //月利率  年化收益／12  保留10位
    CGFloat mouthValue = ([_revenue doubleValue]+[_increaseStr doubleValue])/12;//[_revenue doubleValue]
    
    
    
    NSLog(@"月利率%.10f",mouthValue);
    
    //本金＊月利率 保留10位
    CGFloat tempA =  [_principal doubleValue]* mouthValue;
    NSLog(@"本金＊月利率 保留10位 =%.10f",tempA);
    
    //幂的值
    double upPowerValue = pow(1+mouthValue, [_deadline_key intValue]);
    NSLog(@"upPowerValue =%.10f",upPowerValue);
    
    //月收本息
    double allsum = ([_principal doubleValue]*mouthValue *upPowerValue)/(upPowerValue-1);
    
    NSString * allSumSave = [NSString stringWithFormat:@"%.2f",allsum];
    NSLog(@"allSumSave = %@",allSumSave);
    
    
    // 应收利息
    double getMoney = [allSumSave doubleValue] *[_deadline_key intValue] ;
    NSString * money = [NSString stringWithFormat:@"%.2f",getMoney];
    
    text = [money doubleValue]-[_principal doubleValue];
    NSLog(@"%.10f",getMoney);
    
    //产品收益label 赋值
    
    if ([_way_repayment_key intValue] ==2) {//按月等额本息
        //产品收益label 赋值
        _incomeLabel.text = [NSString stringWithFormat:@"%.2f",text];//产品收益赋值
    }
    else  if([_way_repayment_key intValue] ==3){// 到期返本付息
        
        _incomeLabel.text = [NSString stringWithFormat:@"%@",str];
        if ([str isEqualToString:@"0"])  {
            _incomeLabel.text = @"00.00";
        }
    }else{//"按月付息 到期返本"
        
          _incomeLabel.text = [NSString stringWithFormat:@"%@",str];
        
        if ([str isEqualToString:@"0"])  {
            _incomeLabel.text = @"00.00";
        }
    }
    [self promptWindow];      //提示充值
    [self residualAmountView];//重新输入
    [self createMaskView];   //遮盖视图
    
    self.invest = textField.text;

}

#pragma mark -充值窗口按钮点击事件
/*
 *取消按钮
 */
- (void)cancleAction:(UIButton *)sender{
 
    switch (sender.tag) {
        case 1001:
            [self hidePromptWindow];
            break;
          case 2001:
        default:
            [self hideEnttyAgainView];
            break;
    }


}
/*
 *充值按钮
 */

- (void)sureAction:(UIButton *)sender{

   
    switch (sender.tag) {
        case 1002:
 #warning 跳转chongzhiviewcontroler
            [self voucherCenter];
            
            [self hidePromptWindow];
          
            
            break;
        case 2002:
        default:
            [self hideEnttyAgainView];
            break;
    }

}

#pragma mark -遮挡视图点击事件
- (void)maskViewAction:(UIControl *)sender{
  
    [self hidePromptWindow];
    [self hideEnttyAgainView];
    
}

#pragma mark -提示充值信息
/*
 *显示提示充值框
 */
- (void)showPromptWindow{
[UIView animateWithDuration:.35 animations:^{

    _rechargeView.hidden = NO;
    _maskView.hidden = NO;
}];
}

/*
 *隐藏提示充值框
 */
- (void)hidePromptWindow{
    [UIView animateWithDuration:.35 animations:^{
        
        _rechargeView.hidden = YES;
        _maskView.hidden = YES;

    }];
   
}

#pragma mark -提示输入金额大于产品剩余金额

/*
 *现实提示信息
 */
- (void)showEnttyAgainView{

    _residualAmountView.hidden = NO;
    _maskView.hidden = NO;

}

/*
 *隐藏提示信息
 */
- (void)hideEnttyAgainView{
    _residualAmountView.hidden = YES;
    _maskView.hidden = YES;
    
    
}


#pragma mark - 正则表达式第一次不能输入0
-(BOOL)validateNumberByRegExp:(NSString *)string {
      BOOL isValid = YES;
         NSUInteger len = string.length;
        if (len > 0) {
               NSString *numberRegex = @"^([1-9][0-9]*)$";
                 NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
                isValid = [numberPredicate evaluateWithObject:string];
          }
         return isValid;
     }
#pragma mark - 充值中心
- (void)voucherCenter{

    

    chongzhiViewController *chong =[[chongzhiViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionFromTop;
    animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:chong animated:YES completion:nil];
    


}



- (void)backBtnAction:(UIButton*)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.5;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageCurl";
//    animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
//
    
}

- (void)lockView{
     
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
    promptLabel.frame = CGRectMake((kScreenWidth - (strWidth+30))/2, 600*kHeightScale, strWidth+30, 50*kHeightScale);
    
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
