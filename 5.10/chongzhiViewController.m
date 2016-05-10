//
//  chongzhiViewController.m
//  555
//
//  Created by 李浩宇 on 15/12/3.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "chongzhiViewController.h"
#import "AFNetworking.h"
#import "bankview.h"
#import "huifuchongzhiViewController.h"
#import "huifuzhongxinViewController.h"
#import "UICommons.h"
#import "Masonry.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface chongzhiViewController ()
{
    UITextField *shuru;
    NSString *monnay2;
    UILabel *titleLabel;
    UILabel *sunmonay;
    UIWindow *lastwindou1;
    UIControl *zhedang1;
    UIView *xieyiview1;
    UIWindow *lastwindou;
    UIControl *zhedang;
    UIView *xieyiview;
    UIView *chongzhiguize;
    NSURL *ury;
    NSString *ui;
    NSMutableArray *mara;
    NSMutableArray *Mar;
    UIView *viewyinhang;
    UIControl *_maskView;
    UIImageView *imgViewkah;
    UILabel *yinghangname;
    UILabel *xiangqingname1;
    NSString *kademingzi;
    UILabel *morende;
    NSString *shurujineshu;
    NSString *bancksuo;

}
- (NSAttributedString *)attributedString:(NSArray **)URLs URLRanges:(NSArray **)URLRanges;
@property (nonatomic, strong)bankview *viewbank;
@end

@implementation chongzhiViewController

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *adc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chongzhihouzhanghujine"];
    monnay2 = adc;
    
    
    [self requestdata];
    self.data = [NSMutableArray array];
    self.openData = [NSMutableArray array];
 
    
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    titleLabel.text = @"充值";
    titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(buchongle:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    UIView *viewdang = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 0.5)];
    [self.view addSubview:viewdang];
    viewdang.backgroundColor = [UIColor lightGrayColor];
#pragma mark - 背景图
    
    UIImageView *imge_deng = [[UIImageView alloc]init];
    [self.view addSubview:imge_deng];
    [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64.5);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height - 64.5);
        
    }];
    NSString * cao1=  [[NSUserDefaults standardUserDefaults]objectForKey:@"duandingkuaijie"];
    int icbb1 = [cao1 intValue];

    if(icbb1 == 0)
    {
        [imge_deng setImage:[UIImage imageNamed:@"chongzhi_main.png"]];
    }else{
        
        UILabel * daysingle = [[UILabel alloc]init]; 
        [self.view addSubview:daysingle];
        [daysingle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0.361*__kScreenHeight__);
            make.left.mas_offset(20);
            make.width.mas_offset(__kScreenWidth__);
            make.height.mas_offset(50);
            
        }];
        daysingle.textColor = [UIColor colorWithRed:150/255.0 green:155/255.0 blue:150/255.0 alpha:1];
        NSString *idday = [[NSUserDefaults standardUserDefaults]objectForKey:@"idhaoba1"];
        
        NSString *idsingle = [[NSUserDefaults standardUserDefaults]objectForKey:@"idhaoba2"];
        NSString *shuchudanri;
        NSString *shuchudanbi;
        int dayone = [idday intValue];
        int singleone = [idsingle intValue];
        
        if (dayone == 0) {
            shuchudanri  = @"无限额";
        }else
        {
            if (dayone >= 10000)
            {
                float dayaas = dayone/10000;
                shuchudanri = [NSString stringWithFormat:@"%.0f万元", dayaas];
                
            }else{
                float dayaas = dayone/1000;
                shuchudanri = [NSString stringWithFormat:@"%.0f千元", dayaas];
            }
            
            
        }
        
        if (singleone == 0) {
            shuchudanbi =@"无限额";
        }else{
            if (singleone >=10000) {
                float dasd = singleone/10000;
                shuchudanbi =[NSString stringWithFormat:@"%.0f万元", dasd];
            }else{
                float dasd = singleone/1000;
                shuchudanbi =[NSString stringWithFormat:@"%.0f千元", dasd];
            }
        }
        
        NSInteger po = shuchudanri.length;
        NSInteger po1 = shuchudanbi.length;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"单笔限额%@,单日限额%@",shuchudanbi,shuchudanri]];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(4,po1)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(9+po1,po)];
        
        
        daysingle.attributedText = str ;
        if (__kScreenHeight__ == 568) {
            daysingle.font = [UIFont systemFontOfSize:13];
        }else if(__kScreenHeight__ == 667)
        {
            daysingle.font = [UIFont systemFontOfSize:14];
        }else{
            daysingle.font = [UIFont systemFontOfSize:14];
        }
        

        [imge_deng setImage:[UIImage imageNamed:@"chongzhi_no.png"]];
        
        UIButton *genghuan = [[UIButton alloc]init];
        [self.view addSubview:genghuan];
        [genghuan mas_makeConstraints:^(MASConstraintMaker *make) {
            if(__kScreenHeight__ == 568)
            {make.top.mas_offset(0.415*__kScreenHeight__);
                make.left.mas_offset(0.77*__kScreenWidth__);
                make.width.mas_offset(0.231*__kScreenWidth__);
                make.height.mas_offset(0.061*__kScreenHeight__);
                
            }else if (__kScreenHeight__ == 667)
            {
                make.top.mas_offset(0.405*__kScreenHeight__);
                make.left.mas_offset(0.77*__kScreenWidth__);
                make.width.mas_offset(0.231*__kScreenWidth__);
                make.height.mas_offset(0.061*__kScreenHeight__);
            }else{
                make.top.mas_offset(0.400*__kScreenHeight__);
                make.left.mas_offset(0.77*__kScreenWidth__);
                make.width.mas_offset(0.231*__kScreenWidth__);
                make.height.mas_offset(0.061*__kScreenHeight__);
            }
            
            
        }];
        genghuan.backgroundColor = [UIColor clearColor];
        
        [genghuan addTarget:self action:@selector(xuzhixiang:) forControlEvents:UIControlEventTouchUpInside];
    }
    

#pragma mark - ###########  更换银行卡 ###############
    
    
    
    
    
    
    zhedang = [[UIControl alloc]
               initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
 
    zhedang.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    zhedang.hidden = YES;
    [zhedang addTarget:self
                action:@selector(maskViewAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    lastwindou = [UIApplication sharedApplication].windows.lastObject;
    
    
    xieyiview = [[UIView alloc]init];
    [lastwindou addSubview:xieyiview];
    
    [xieyiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.5*__kScreenHeight__-60);
        make.left.mas_offset(40);
        make.width.mas_offset(__kScreenWidth__-80);
        make.height.mas_offset(120);
    }];
    
    
    xieyiview.backgroundColor = [UIColor whiteColor];
    
   
    
    xieyiview.hidden = YES;
    
    [lastwindou insertSubview:zhedang belowSubview:xieyiview];
    
    if (__kScreenHeight__ == 568) {
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(202*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"6ellBtn1@2x.png"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kScreenWidth__, 40)];
        [xieyiview addSubview:xuzhis];
        xuzhis.text = @"请电脑登录www.otouzi.com进行操作";
        xuzhis.font = [UIFont systemFontOfSize:13];

    }else if(__kScreenHeight__ == 667){
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"6ellBtn1"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kScreenWidth__, 40)];
        [xieyiview addSubview:xuzhis];
        xuzhis.text = @"请电脑登录www.otouzi.com进行操作";

    }else{
        UIButton *tongyi = [[UIButton alloc]initWithFrame:CGRectMake(204*__kScreenWidth__/750,70,192*__kScreenWidth__/750 , 65*__kScreenHeight__/1334)];
        [tongyi setImage:[UIImage imageNamed:@"6ellBtn1"]forState:UIControlStateNormal];
        [tongyi addTarget:self action:@selector(xuzhitui:) forControlEvents:UIControlEventTouchUpInside];
        [xieyiview addSubview:tongyi];
        UILabel *xuzhis = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, __kScreenWidth__, 40)];
        [xieyiview addSubview:xuzhis];
        xuzhis.text = @"请电脑登录www.otouzi.com进行操作";

    }
    
    

#pragma mark - 单日，单笔
    
    
  
    
#pragma mark - ###############  请选择银行卡提示  #############
    
    morende = [[UILabel alloc]initWithFrame:CGRectMake(20, 413 *__kScreenHeight__/1334, 300*__kScreenWidth__/750, 40*__kScreenHeight__/1334)];
    
    morende.text = @"请选择银行";
   
    morende.textColor = [UIColor blackColor];
    if (__kScreenHeight__ == 568) {
         morende.font = [UIFont systemFontOfSize:15];
    }else if (__kScreenHeight__ >= 667)
    {
         morende.font = [UIFont systemFontOfSize:18];
    }
   
    NSString *hehe = [[NSUserDefaults standardUserDefaults]objectForKey:@"duandingkuaijie"];
    int haha = [hehe intValue];
    if (haha == 1) {
        [morende removeFromSuperview];
       bancksuo =  [[NSUserDefaults standardUserDefaults]objectForKey:@"biaohaoka"];
    }
    else
    {
        [self.view addSubview:morende];
        
    }
    
#pragma mark - 账户总金额
    if (!sunmonay) {
        sunmonay = [[UILabel alloc]init];
        [self.view addSubview: sunmonay];
        [sunmonay mas_makeConstraints:^(MASConstraintMaker *make) {
            if(__kScreenHeight__ == 568)
            {make.top.mas_offset(0.229*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
                
            }else if (__kScreenHeight__ == 667)
            {make.top.mas_offset(0.215*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
                
            }else{
                make.top.mas_offset(0.209*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
            }
        }];

    }else{
        sunmonay = [[UILabel alloc]init];
        [self.view addSubview: sunmonay];
        [sunmonay mas_makeConstraints:^(MASConstraintMaker *make) {
            if(__kScreenHeight__ == 568)
            {make.top.mas_offset(0.229*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
                
            }else if (__kScreenHeight__ == 667)
            {make.top.mas_offset(0.215*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
                
            }else{
                make.top.mas_offset(0.209*__kScreenHeight__);
                make.left.mas_offset(0.441*__kScreenWidth__);
                make.width.mas_offset(0.5*__kScreenWidth__);
                make.height.mas_offset(0.035*__kScreenHeight__);
                
            }
        }];

    }
    
    
    
    sunmonay.text = monnay2;
    sunmonay.font = [UIFont systemFontOfSize:14];
    
#pragma mark - 选择银行卡
    
    NSString * cao=  [[NSUserDefaults standardUserDefaults]objectForKey:@"duandingkuaijie"];
    int icbb = [cao intValue];
    if (icbb == 0) {
        [self.view addSubview:morende];

    }
    else
    {
        ui = [[NSUserDefaults standardUserDefaults]objectForKey:@"morenlogo"];
        ury = [NSURL URLWithString:ui];
    }
    
   
    UIButton *xuanzeyinhangka = [[UIButton alloc]initWithFrame:CGRectMake(0,383*__kScreenHeight__/1334 ,__kScreenWidth__,102*__kScreenHeight__/1334)];
    if (icbb == 0) {
        
    
    [xuanzeyinhangka setImage:[UIImage imageNamed:@"chongzhi_change.png"] forState:UIControlStateNormal];
    }else
    {

        
        xuanzeyinhangka.userInteractionEnabled = NO;
    }
    
    [self.view addSubview:xuanzeyinhangka];
   
    if (icbb == 0) {
        
    [xuanzeyinhangka addTarget:self action:@selector(yinghangtanchu:) forControlEvents:UIControlEventTouchUpInside];
        imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(24*__kScreenWidth__/750,411*__kScreenHeight__/1334 ,43*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
        
        [imgViewkah setImageWithURL: ury placeholderImage:nil];
        imgViewkah.userInteractionEnabled=YES;
        
        [self.view addSubview:imgViewkah];
    }
    else{
        
        
         NSString *strio = [[NSUserDefaults standardUserDefaults]objectForKey:@"morenname"];
      
        NSLog(@"%ld", strio.length);
        if(__kScreenHeight__ == 568)
        {
            if (strio.length<=4) {
                
            
            imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(360*__kScreenWidth__/750,415*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }else if(strio.length>6)
            { imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(250*__kScreenWidth__/750,415*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }
            
            else if (strio.length == 6)
            {
                imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(310*__kScreenWidth__/750,415*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }


            
        }else if (__kScreenHeight__ == 667)
        {
            
            if(strio.length<=4)
            {imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(360*__kScreenWidth__/750,402*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
                
            }else if(strio.length>6)
            {
                imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(260*__kScreenWidth__/750,402*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }else if (strio.length == 6)
            {
                imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(320*__kScreenWidth__/750,402*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }
            

        }else{
            
            if(strio.length<=4)
            { imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(360*__kScreenWidth__/750,390*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
                
            }else if(strio.length>6)
            {
                imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(290*__kScreenWidth__/750,390*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];
            }else if (strio.length == 6)
            {
                imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(350*__kScreenWidth__/750,390*__kScreenHeight__/1334 ,44*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
                
                [imgViewkah setImageWithURL: ury placeholderImage:nil];
                imgViewkah.userInteractionEnabled=YES;
                
                [self.view addSubview:imgViewkah];

            }

           

        }
    }
    
    
  
    
    
    
    

#pragma mark - ############ 获取银行名字 ############
    
    
    
    if (icbb == 0) {
         yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(91*__kScreenWidth__/750, 403*__kScreenHeight__/1334, __kScreenWidth__, 30*__kScreenHeight__/1334)];
        yinghangname.text = kademingzi;
        yinghangname.textColor = [UIColor blackColor];
        yinghangname.font = [UIFont systemFontOfSize:13];
        
        [self.view addSubview:yinghangname];

    [self.view addSubview:morende];

    }
    else
    {
        if (__kScreenHeight__ == 568) {
            yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(310*__kScreenWidth__/750, 419*__kScreenHeight__/1334, 238*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
            kademingzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"morenname"];
            yinghangname.text = kademingzi;
            yinghangname.textColor = [UIColor grayColor];
            yinghangname.textAlignment = UITextAlignmentRight;
            yinghangname.textColor = [UIColor blackColor];
            if (__kScreenHeight__ == 568) {
                yinghangname.font = [UIFont systemFontOfSize:13];
            }else{
                yinghangname.font = [UIFont systemFontOfSize:15];
            }
            
            
            [self.view addSubview:yinghangname];
            

        }else if (__kScreenHeight__ == 667)
        {
            yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(315*__kScreenWidth__/750, 405*__kScreenHeight__/1334, 238*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
            kademingzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"morenname"];
            yinghangname.text = kademingzi;
            yinghangname.textColor = [UIColor grayColor];
            yinghangname.textAlignment = UITextAlignmentRight;
            yinghangname.textColor = [UIColor blackColor];
            if (__kScreenHeight__ == 568) {
                yinghangname.font = [UIFont systemFontOfSize:13];
            }else{
                yinghangname.font = [UIFont systemFontOfSize:15];
            }
            
            
            [self.view addSubview:yinghangname];
            

        }else{
            yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(330*__kScreenWidth__/750, 395*__kScreenHeight__/1334, 238*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
            kademingzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"morenname"];
            yinghangname.text = kademingzi;
            yinghangname.textColor = [UIColor grayColor];
            yinghangname.textAlignment = UITextAlignmentRight;
            yinghangname.textColor = [UIColor blackColor];
            if (__kScreenHeight__ == 568) {
                yinghangname.font = [UIFont systemFontOfSize:13];
            }else{
                yinghangname.font = [UIFont systemFontOfSize:15];
            }
            
            
            [self.view addSubview:yinghangname];
            

        }
    }
    
    
    
    
#pragma mark - ############  获取银行详情  ##########
    NSString *jiushiniua;
    if (icbb  == 0) {
        
    [self.view addSubview:morende];
//    jiushiniua =[[NSUserDefaults standardUserDefaults]objectForKey:@"pinjiewancheng"];
        
    }
    else
    {
    
     NSString *jiushiniuB =[[NSUserDefaults standardUserDefaults]objectForKey:@"morenkahao"];
        NSString *tempA=[jiushiniuB substringFromIndex:jiushiniuB.length - 4];//截取下标2之前的字符串
        
        jiushiniua = [NSString stringWithFormat:@"（尾号%@）",tempA];
        
    }
    if (__kScreenHeight__ == 568) {
        xiangqingname1 = [[UILabel alloc]initWithFrame:CGRectMake(330*__kScreenWidth__/750, 424*__kScreenHeight__/1334, 400*__kScreenWidth__/750, 20*__kScreenHeight__/1334)];
        xiangqingname1.textColor = [UIColor grayColor];
        xiangqingname1.text = jiushiniua;
        xiangqingname1.textAlignment = UITextAlignmentRight;
        xiangqingname1.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:xiangqingname1];
    }else if (__kScreenHeight__ == 667)
    {
        xiangqingname1 = [[UILabel alloc]initWithFrame:CGRectMake(330*__kScreenWidth__/750, 410*__kScreenHeight__/1334, 400*__kScreenWidth__/750, 20*__kScreenHeight__/1334)];
        xiangqingname1.textColor = [UIColor grayColor];
        xiangqingname1.text = jiushiniua;
        xiangqingname1.textAlignment = UITextAlignmentRight;
        xiangqingname1.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:xiangqingname1];
    }
    else{
        xiangqingname1 = [[UILabel alloc]initWithFrame:CGRectMake(330*__kScreenWidth__/750, 400*__kScreenHeight__/1334, 400*__kScreenWidth__/750, 20*__kScreenHeight__/1334)];
        xiangqingname1.textColor = [UIColor grayColor];
        xiangqingname1.text = jiushiniua;
        xiangqingname1.textAlignment = UITextAlignmentRight;
        xiangqingname1.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:xiangqingname1];

    }
    

    
    
    
    
    
#pragma mark - 金额
   
    
    if (__kScreenHeight__ == 568) {
        shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.396*__kScreenWidth__, 0.157*__kScreenHeight__, 0.6*__kScreenWidth__, 30*__kScreenHeight__/1334)];
        
        shuru.font = [UIFont systemFontOfSize:14];
        shuru.placeholder = @"请输入充值金额";
        
        [shuru setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [shuru setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        shuru.keyboardType = UIKeyboardTypeNumberPad;
        [shuru addTarget:self action:@selector(shurujinedianji:) forControlEvents:UIControlEventEditingChanged];

    }
    else if (__kScreenHeight__ == 667)
    {shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.396*__kScreenWidth__, 0.141*__kScreenHeight__, 0.6*__kScreenWidth__, 30*__kScreenHeight__/1334)];
        
        shuru.font = [UIFont systemFontOfSize:14];
        shuru.placeholder = @"请输入充值金额";
        
        [shuru setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [shuru setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        shuru.keyboardType = UIKeyboardTypeNumberPad;
        [shuru addTarget:self action:@selector(shurujinedianji:) forControlEvents:UIControlEventEditingChanged];

        
    }
    else{
        shuru = [[UITextField alloc]initWithFrame:CGRectMake(0.396*__kScreenWidth__, 0.137*__kScreenHeight__, 0.6*__kScreenWidth__, 30*__kScreenHeight__/1334)];
        
        shuru.font = [UIFont systemFontOfSize:15];
        shuru.placeholder = @"请输入充值金额";
        
        [shuru setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [shuru setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//        shuru.clearButtonMode = UITextFieldViewModeAlways;//清空小叉
        
        [self.view addSubview:shuru];
        shuru.keyboardType = UIKeyboardTypeNumberPad;
        [shuru addTarget:self action:@selector(shurujinedianji:) forControlEvents:UIControlEventEditingChanged];

    }
    
    
#pragma mark - 充值按钮
    
    
    if (icbb == 0) {
        
    
    if (__kScreenHeight__ == 568) {
        
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 640*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 95*__kScreenHeight__/1334)];
        denglu.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    }else if (__kScreenHeight__ == 667)
    {
        
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 630*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 95*__kScreenHeight__/1334)];
        denglu.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 620*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 95*__kScreenHeight__/1334)];
        denglu.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    
    }
    else{
        if (__kScreenHeight__ == 568) {
            
            UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 700*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 95*__kScreenHeight__/1334)];
            denglu.backgroundColor = [UIColor clearColor];
            
            [self.view addSubview:denglu];
            [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
        }else if (__kScreenHeight__ == 667)
        {
            
            UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 680*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 110*__kScreenHeight__/1334)];
            denglu.backgroundColor = [UIColor clearColor];
            
            [self.view addSubview:denglu];
            [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 680*__kScreenHeight__/1334, 702*__kScreenWidth__/750, 95*__kScreenHeight__/1334)];
            denglu.backgroundColor = [UIColor clearColor];
            
            [self.view addSubview:denglu];
            [denglu addTarget:self action:@selector(chongzhiwancheng:) forControlEvents:UIControlEventTouchUpInside];
        }
        

        
    }
    
    
//###############################################################################################
    
   
 

    
    viewyinhang = [[UIView alloc]initWithFrame:CGRectMake(0, __kScreenHeight__, __kScreenWidth__, 808*__kScreenHeight__/1334)];
    
//    viewyinhang.backgroundColor = [UIColor grayColor];
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    [window addSubview:viewyinhang];
    
    
    UIImage *change = [UIImage imageNamed:@"6Pay24@2x.png"];
    
    UIImageView *changeim = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, __kScreenWidth__, 86*__kScreenHeight__/1334)];
    [changeim setImage:change];
    [viewyinhang addSubview:changeim];
    
    

#pragma mark - ########### 银行卡层  #############
        
  
   
    
    _viewbank = [[bankview alloc]initWithFrame:CGRectMake(0, 86*__kScreenHeight__/1334, __kScreenWidth__, 722*__kScreenHeight__/1334)];
    
    [viewyinhang addSubview:_viewbank];
    
    
    
#pragma mark - #############  返回按钮  ##################
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jiazaishuju) name:@"xuanwanle" object:nil];
     

    UIButton *guanbi = [[UIButton alloc]initWithFrame:CGRectMake(24*__kScreenWidth__/750, 28*__kScreenHeight__/1334, 40*__kScreenWidth__/750, 43*__kScreenHeight__/1334)];
  
    [guanbi setImage:[UIImage imageNamed:@"6Pay21@2x.png"] forState:UIControlStateNormal];
    [viewyinhang addSubview:guanbi];
    
    [guanbi addTarget:self action:@selector(maskview:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    _maskView = [[UIControl alloc]
                 initWithFrame:CGRectMake(0, 0,__kScreenWidth__, __kScreenHeight__)];
    //根据RGB设置颜色
    //[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#>
    // alpha:<#(CGFloat)#>]
    
    //根据灰度设置颜色
    //灰度，0为纯黑，1为纯白
    _maskView.backgroundColor = [UIColor colorWithWhite:0.441 alpha:0.500];
    _maskView.hidden = YES;
    [_maskView addTarget:self
                  action:@selector(maskViewAction1:)
        forControlEvents:UIControlEventTouchUpInside];
    
    //在某个子视图上面插入一个视图
    //[self insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>]
    
    //在某个子视图下面插入一个视图
    window =[UIApplication sharedApplication].windows.lastObject ;
    
    [window  insertSubview:_maskView belowSubview:viewyinhang];
    
    //根据下标插入
    //[self insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>];
    
    
    
    
    
    
    
    
}

-(void)shouyeyue
{
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    
    
    [manager GET:@"http://debug.otouzi.com:8012/user/center"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             
             
             NSDictionary *keyong= [gerenzhongxin objectForKey:@"data"];
             NSDictionary *keyong1= [keyong objectForKey:@"invest"];
             NSString *yue = [keyong1 objectForKey:@"available"];//可用余额
             if (__kScreenHeight__== 568) {
                 UILabel *keyongyue = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750,660*__kScreenHeight__/1334, 185*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
                 keyongyue.font = [ UIFont systemFontOfSize:11];
                 keyongyue.textColor = [UIColor grayColor];
                 keyongyue.text = [ NSString stringWithFormat:@"%@元",yue];

                 keyongyue.textAlignment = NSTextAlignmentLeft;
                 [self.view addSubview:keyongyue];

             }else if (__kScreenHeight__ >= 667)
             {
                 UILabel *keyongyue = [[UILabel alloc]initWithFrame:CGRectMake(180*__kScreenWidth__/750,660*__kScreenHeight__/1334, 183*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
                 keyongyue.font = [ UIFont systemFontOfSize:11];
                 keyongyue.textColor = [UIColor grayColor];
                 keyongyue.text = [ NSString stringWithFormat:@"%@元",yue];

                 [self.view addSubview:keyongyue];
 
                 keyongyue.textAlignment = NSTextAlignmentLeft;
                 
             }
             
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
    

}


-(void)yinghangtanchu:(id)sender
{
    [shuru resignFirstResponder];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kalogo"];
    [self showview];
}

-(void)buchongle:(id)sender
{
    NSString *newbioe = [[NSUserDefaults standardUserDefaults]objectForKey:@"newbiewc"];
    int cc = [newbioe intValue];
    NSLog(@"%d",cc);
    if (cc == 1000) {
        
        
        NewbieController  *disanfang= [[NewbieController alloc]init];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:disanfang animated:NO completion:nil];
        
        disanfang.productId =@"996";
    }else{
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
        

        
        AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        TabbarViewController *tab = [[TabbarViewController alloc]init];
        delete.window.rootViewController = tab;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:self];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)showview
{
    [UIView animateWithDuration:0.35
                     animations:^{
                         viewyinhang.transform = CGAffineTransformMakeTranslation(0, -(808*__kScreenHeight__/1334));
                         _maskView.hidden = NO;
                     }];
    
}
-(void)hiddn
{
    [UIView animateWithDuration:0.35
                       animations:^{
                         viewyinhang.transform = CGAffineTransformIdentity;
                         
                     }];
}
//遮盖视图点击事件
- (void)maskViewAction1:(UIControl *)sender {
    
    [self hiddn];
    sender.hidden = YES;
}

#pragma mark -   #####################   加载数据   ##################


-(void)jiazaishuju
{
    [imgViewkah removeFromSuperview];
    [xiangqingname1 removeFromSuperview];
    [yinghangname removeFromSuperview];
    [morende removeFromSuperview];
    
    
    
    
    
    NSString *b =[[NSUserDefaults standardUserDefaults]objectForKey:@"dijihang"];
    int c = [b intValue];
    if (c < yizu) {
        
        NSMutableDictionary * pro = Mar[c];
        NSString *pro1 = [pro objectForKey:@"single"];
        
        //单笔
        NSString *first;
        int fiest2 = [pro1 intValue];
        
        if (fiest2 == 0 )
        {
            first = @"无限额";
        }
        else
        {
            if ( fiest2 >10000) {
                
                
                float firest1 =[pro1 intValue]/10000;
                first = [NSString stringWithFormat:@"%.0f万", firest1];
            }
            else
            {
                float firest1 =[pro1 intValue]/1000;
                first = [NSString stringWithFormat:@"%.0f千", firest1];
            }
        }
        //单日
        
        NSMutableDictionary * mac = Mar[c];
        NSString *mac1 = [pro objectForKey:@"day"];

        NSString *firday;
       if ([mac1 intValue]==0)
        {
            firday = @"无限额";
        }
        else
        {
            if ( [mac1 intValue] >10000) {
                
                
                float firday1 =[Mar[c][@"day"] intValue]/10000;
                firday = [NSString stringWithFormat:@"%.0f万", firday1];
            }
            else
            {
                float firday1 =[Mar[c][@"day"] intValue]/1000;
                firday = [NSString stringWithFormat:@"%.0f千", firday1];
            }
        }
        
        
        //单月
        NSMutableDictionary * macpro = Mar[c];
        NSString *macpro1 = [pro objectForKey:@"month"];
        
        NSString *firyue;
        if ([macpro1 intValue]==0)
        {
            firyue = @"无限额";
        }
        else
        {
            if ( [macpro1 intValue] >10000) {
            
                
                float firyue1 =[macpro1 intValue]/10000;
                firyue = [NSString stringWithFormat:@"%.0f万", firyue1];
            }
            else
            {
                float firyue1 =[macpro1 intValue]/1000;
                firyue = [NSString stringWithFormat:@"%.0f千", firyue1];
            }
        }

        
        
       NSString *pinjie =[NSString stringWithFormat:@"单笔限额%@，单日限额%@",first,firday];
        
        [[NSUserDefaults standardUserDefaults ]setObject:pinjie forKey:@"pinjiewancheng"];
        NSString *jiushiniuB=[[NSUserDefaults standardUserDefaults]objectForKey:@"pinjiewancheng"];
        
        xiangqingname1 = [[UILabel alloc]initWithFrame:CGRectMake(280*__kScreenWidth__/750, 427*__kScreenHeight__/1334, 400*__kScreenWidth__/750, 20*__kScreenHeight__/1334)];
        xiangqingname1.textColor = [UIColor grayColor];
        xiangqingname1.text = jiushiniuB;
        xiangqingname1.textAlignment = UITextAlignmentRight;
        xiangqingname1.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:xiangqingname1];

        
        
    
        
        
        
    
        [[NSUserDefaults standardUserDefaults]setObject:Mar[c][@"name"] forKey:@"kaname"];
        
        yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(91*__kScreenWidth__/750, 420*__kScreenHeight__/1334, 238*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
        
        kademingzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"kaname"];
        yinghangname.text = kademingzi;
        yinghangname.textColor = [UIColor blackColor];
        yinghangname.font = [UIFont systemFontOfSize:13];
        
        [self.view addSubview:yinghangname];
        
        
        
        
        
        
    
    [[NSUserDefaults standardUserDefaults]setObject:Mar[c][@"logo"] forKey:@"kalogo"];
    ui = [[NSUserDefaults standardUserDefaults]objectForKey:@"kalogo"];
    ury = [NSURL URLWithString:ui];
    
    imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(24*__kScreenWidth__/750,413*__kScreenHeight__/1334 ,43*__kScreenWidth__/750,44*__kScreenHeight__/1334)];    [imgViewkah setImageWithURL: ury placeholderImage:[UIImage imageNamed:@"6Pay@2x_04.png"]];
    imgViewkah.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yinghangtanchu:)];
    [imgViewkah addGestureRecognizer:singleTap];
    [self.view addSubview:imgViewkah];
        [[NSUserDefaults standardUserDefaults]setObject:Mar[c][@"code"] forKey:@"yinhangsuolv"];
        bancksuo =[[NSUserDefaults standardUserDefaults]objectForKey:@"yinhangsuolv"];
        
        NSLog( @"yinghang %@",bancksuo);
        
    
    [self hiddn];
    _maskView.hidden =YES;
        
    }else if (c >yizu)
    {
        int u = c-yizu-1;
        
        NSMutableDictionary * pro = mara[u];
        NSString *pro1 = [pro objectForKey:@"single"];
        
        //单笔
        NSString *first;
        int fiest2 = [pro1 intValue];
        
        if (fiest2 == 0 )
        {
            first = @"无限额";
        }
        else
        {
            if ( fiest2 >10000) {
                
                
                float firest1 =[pro1 intValue]/10000;
                first = [NSString stringWithFormat:@"%.0f万", firest1];
            }
            else
            {
                float firest1 =[pro1 intValue]/1000;
                first = [NSString stringWithFormat:@"%.0f千", firest1];
            }
        }
        //单日
        
        NSMutableDictionary * mac = mara[u];
        NSString *mac1 = [pro objectForKey:@"day"];
        
        NSString *firday;
        if ([mac1 intValue]==0)
        {
            firday = @"无限额";
        }
        else
        {
            if ( [mac1 intValue] >10000) {
                
                
                float firday1 =[mara[u][@"day"] intValue]/10000;
                firday = [NSString stringWithFormat:@"%.0f万", firday1];
            }
            else
            {
                float firday1 =[mara[u][@"day"] intValue]/1000;
                firday = [NSString stringWithFormat:@"%.0f千", firday1];
            }
        }
        
        
        //单月
        NSMutableDictionary * macpro = mara[u];
        NSString *macpro1 = [pro objectForKey:@"month"];
        NSLog(@"%@",macpro1);
        NSString *firyue;
        if ([macpro1 intValue]==0)
        {
            firyue = @"无限额";
        }
        else
        {
            if ( [macpro1 intValue] >10000) {
                
                
                float firyue1 =[macpro1 intValue]/10000;
                firyue = [NSString stringWithFormat:@"%.0f万", firyue1];
            }
            else
            {
                float firyue1 =[macpro1 intValue]/1000;
                firyue = [NSString stringWithFormat:@"%.0f千", firyue1];
            }
        }
        
        
        
        NSString *pinjie =[NSString stringWithFormat:@"单笔限额%@，单日限额%@，单月限额%@",first,firday,firyue];
        
        [[NSUserDefaults standardUserDefaults ]setObject:pinjie forKey:@"pinjiewancheng"];
        NSString *jiushiniuB=[[NSUserDefaults standardUserDefaults]objectForKey:@"pinjiewancheng"];
        
        xiangqingname1 = [[UILabel alloc]initWithFrame:CGRectMake(280*__kScreenWidth__/750, 427*__kScreenHeight__/1334, 400*__kScreenWidth__/750, 20*__kScreenHeight__/1334)];
        xiangqingname1.textColor = [UIColor grayColor];
        xiangqingname1.text = jiushiniuB;
        xiangqingname1.textAlignment = UITextAlignmentRight;
        xiangqingname1.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:xiangqingname1];
        

        
        [[NSUserDefaults standardUserDefaults]setObject:mara[u][@"name"] forKey:@"kaname"];
        
        yinghangname = [[UILabel alloc]initWithFrame:CGRectMake(91*__kScreenWidth__/750, 420*__kScreenHeight__/1334, 238*__kScreenWidth__/750, 30*__kScreenHeight__/1334)];
        
        kademingzi = [[NSUserDefaults standardUserDefaults]objectForKey:@"kaname"];
        yinghangname.text = kademingzi;
        yinghangname.textColor = [UIColor blackColor];
        yinghangname.font = [UIFont systemFontOfSize:13];
        
        [self.view addSubview:yinghangname];
        
        
        
        
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:mara[u][@"logo"] forKey:@"kalogo"];
        
        ui = [[NSUserDefaults standardUserDefaults]objectForKey:@"kalogo"];
        ury = [NSURL URLWithString:ui];
        
       imgViewkah =[[UIImageView alloc] initWithFrame:CGRectMake(24*__kScreenWidth__/750,413*__kScreenHeight__/1334 ,43*__kScreenWidth__/750,44*__kScreenHeight__/1334)];
        [imgViewkah setImageWithURL: ury placeholderImage:[UIImage imageNamed:@"6Pay@2x_04.png"]];
        imgViewkah.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yinghangtanchu:)];
        [imgViewkah addGestureRecognizer:singleTap];
        [self.view addSubview:imgViewkah];
        [[NSUserDefaults standardUserDefaults]setObject:mara[u][@"code"] forKey:@"yinhangsuolv"];
        bancksuo =[[NSUserDefaults standardUserDefaults]objectForKey:@"yinhangsuolv"];
        
        NSLog( @"yinghang %@",bancksuo);
        
        [self hiddn];
        _maskView.hidden =YES;
        
    }
    
    
    
}

-(void)maskview:(UIButton *)sender
{
    
    [self hiddn];
    _maskView.hidden = YES;
    
  
}


- (void)requestdata{
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    [manager GET:@"http://debug.otouzi.com:8012/bankcard/aqList"
      parameters:@{}
         success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
             
             NSLog(@"%@",responseObject);
             
             NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
             gerenzhongxin = responseObject;
             
             NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
             NSMutableArray *yonghuming1= [yonghuming objectForKey:@"list"];
              Mar = yonghuming1;
             yizu =yonghuming1.count;
             NSLog(@"%d",yizu);
             for (NSDictionary *dataDic in yonghuming1) {
                 
                 BankModel *model =[[BankModel alloc]initWithDataDic:dataDic];
                 
                 [self.data addObject:model];
                 self.viewbank.data = self.data;
  
             }
          
            
             NSDictionary *yinlianweikai = [gerenzhongxin objectForKey:@"data"];
             NSMutableArray *yinlianweikai1= [yinlianweikai objectForKey:@"open_list"];
     
             mara = yinlianweikai1;
             erzu = yinlianweikai1.count;
             NSLog(@"%d",erzu);
             
             
             for (NSDictionary *dataDic1 in yinlianweikai1) {
                 BankModel *model1 =[[BankModel alloc]initWithDataDic:dataDic1];
                 
                 [self.openData addObject:model1];
                 self.viewbank.openData = self.openData;
                 
             }
             
             //刷新表视图，回到主线程
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [self.viewbank reloadData];
                 
                 NSLog(@"############# %@",self.viewbank.data
                       );
             });
             
             
         } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
             
         }];
}

-(void)chongzhiwancheng:(id)sender
{
   NSString *ui =  [[NSUserDefaults standardUserDefaults]objectForKey:@"duandingkuaijie"];
    int bc = [ui intValue];
    if (bc == 0 && shurujineshu != nil && bancksuo != nil) {
        
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
    [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    [manager POST:@"http://debug.otouzi.com:8012/user/quickrecharge"
       parameters:@{@"transamt": shurujineshu,
                     @"bankcode": bancksuo
                    }
          success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
              
              NSLog(@"%@",responseObject);
              
              
              
           
              
              NSDictionary *objc1 = [[NSDictionary alloc] init];
              
              objc1 = responseObject;
              NSLog(@"登录成功%@",responseObject);
              
              
              
              if ([[objc1 objectForKey:@"code"]isEqualToNumber:@200]) {
              
              
              [[NSUserDefaults standardUserDefaults] setObject:objc1[@"data"][@"href"] forKey:@"chongzhiwangzhi"];//存在本地沙盒
              
             
              huifuchongzhiViewController *huifuchong = [[huifuchongzhiViewController alloc]init];
              
              CATransition *animation = [CATransition animation];
              animation.duration = 0.5;
              animation.timingFunction = UIViewAnimationCurveEaseInOut;
              animation.type = @"pageCurl";
              animation.type = kCATransitionPush;
              animation.subtype = kCATransitionFromRight;
              [self.view.window.layer addAnimation:animation forKey:nil];


              [self presentViewController:huifuchong animated:NO completion:nil];
              
              }
              
          } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              
          }];
    }else if (shurujineshu == nil)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入充值金额";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.textAlignment = UITextAlignmentCenter;
            
            meishurushouji.font = [UIFont systemFontOfSize:13];
        }else if (__kScreenHeight__ >= 667)
        {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入充值金额";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.font = [UIFont systemFontOfSize:15];
            meishurushouji.textAlignment = UITextAlignmentCenter;
        }
    }else if (bancksuo == nil)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请选择充值银行";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.textAlignment = UITextAlignmentCenter;
            
            meishurushouji.font = [UIFont systemFontOfSize:13];
        }else if (__kScreenHeight__ >= 667)
        {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请选择充值银行";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.font = [UIFont systemFontOfSize:15];
            meishurushouji.textAlignment = UITextAlignmentCenter;
        }

    }
    
    if (bc == 1 && shurujineshu != nil && bancksuo != nil) {
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *sta=  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        [manager.requestSerializer setValue:sta forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        [manager POST:@"http://debug.otouzi.com:8012/user/quickrecharge"
           parameters:@{@"transamt": shurujineshu,
                        @"bankcode": bancksuo
                        }
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSDictionary *objc1 = [[NSDictionary alloc] init];
                  
                  objc1 = responseObject;
                  NSLog(@"登录成功%@",responseObject);
                  
                  
                  
                  if ([[objc1 objectForKey:@"code"]isEqualToNumber:@200]) {
                      
                  [[NSUserDefaults standardUserDefaults] setObject:objc1[@"data"][@"href"] forKey:@"chongzhiwangzhi"];//存在本地沙盒
                  
                  
                  huifuchongzhiViewController *huifuchong = [[huifuchongzhiViewController alloc]init];
                  
                  CATransition *animation = [CATransition animation];
                  animation.duration = 0.5;
                  animation.timingFunction = UIViewAnimationCurveEaseInOut;
                  animation.type = @"pageCurl";
                  animation.type = kCATransitionPush;
                  animation.subtype = kCATransitionFromRight;
                  [self.view.window.layer addAnimation:animation forKey:nil];
                  
                  
                  [self presentViewController:huifuchong animated:NO completion:nil];
                  
                  }
                  
              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  
              }];
        
    }else if (bc == 1 && shurujineshu == nil)
    {
        if (__kScreenHeight__ == 568) {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(190*__kScreenWidth__/750, 670*__kScreenHeight__/1334, 340*__kScreenWidth__/750, 70*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入充值金额";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.textAlignment = UITextAlignmentCenter;
            
            meishurushouji.font = [UIFont systemFontOfSize:13];
        }else if (__kScreenHeight__ >= 667)
        {
            UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(220*__kScreenWidth__/750, 735*__kScreenHeight__/1334, 338*__kScreenWidth__/750, 80*__kScreenHeight__/1334)];
            meishurushouji.textColor = [UIColor whiteColor];
            meishurushouji.text = @"请输入充值金额";
            meishurushouji.layer.cornerRadius = 7;
            meishurushouji.clipsToBounds = YES;
            meishurushouji.textAlignment = NSTextAlignmentCenter;
            meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
            [self.view addSubview:meishurushouji];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationDelegate:self];
            meishurushouji.alpha =0.0;
            [UIView commitAnimations];//2秒后消失
            meishurushouji.font = [UIFont systemFontOfSize:15];
            meishurushouji.textAlignment = UITextAlignmentCenter;
        }

    }
    
    
}
- (void)shurujinedianji:(UITextField *)textField
{
    shurujineshu = textField.text;

    NSLog(@"###%@",shurujineshu);

    
    float ad = [shurujineshu floatValue];
    
    NSString *oldStr = monnay2;
    NSString *newStr = [oldStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSLog(@"%@",newStr);
    
    float ac = [newStr floatValue];
    
    sunmonay.text = [NSString stringWithFormat:@"%.2lf",ad+ac];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)xuzhixiang:(id)sender
{
    [self showShareView];
}
- (void)showShareView{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = NO;
                         
                         //使用block，来执行一个动画
                         //向下的平移
                         //                         .transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight-1230/3-kNavigationBarHeight));
                         
                         zhedang.hidden = NO;
                     }];
    
}
//隐藏尾部视图
- (void)hideShareView{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview.hidden = YES;
                     }];
    
}
-(void)maskViewAction:(id)sender
{
    zhedang.hidden = YES;
    [self hideShareView];
}
-(void)xuzhitui:(id)sender
{
    
    zhedang.hidden = YES;
    [self hideShareView];
    
}

- (id)init
{
    if (self = [super initWithNibName:nil bundle:nil]){
        
    }
    
    return self;
}
-(void)huifu:(id)sender
{
    zhedang.hidden = YES;
    [self hideShareView];

    huifuzhongxinViewController *huifuchong1 = [[huifuzhongxinViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    [self presentViewController:huifuchong1 animated:NO completion:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [[NSUserDefaults standardUserDefaults]objectForKey:@"kehuzhanghao"];
    
    UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(250*__kScreenWidth__/750, 900*__kScreenHeight__/1334, 252*__kScreenWidth__/750, 42*__kScreenHeight__/1334)];
    meishurushouji.textColor = [UIColor whiteColor];
    meishurushouji.text = @" 您的账号已复制到剪贴板";
    meishurushouji.layer.cornerRadius = 7;
    meishurushouji.clipsToBounds = YES;
    
    meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
    [lastwindou addSubview:meishurushouji];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationDelegate:self];
    meishurushouji.alpha =0.0;
    [UIView commitAnimations];//2秒后消失
    if (__kScreenHeight__ == 568) {
        meishurushouji.font = [UIFont systemFontOfSize:9];
    }else if (__kScreenHeight__ >= 667)
    {
        meishurushouji.font = [UIFont systemFontOfSize:11];
    }

    
}
-(void)fuzhi:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [[NSUserDefaults standardUserDefaults]objectForKey:@"kehuzhanghao"];

    UILabel *meishurushouji = [[UILabel alloc]initWithFrame:CGRectMake(250*__kScreenWidth__/750, 900*__kScreenHeight__/1334, 252*__kScreenWidth__/750, 42*__kScreenHeight__/1334)];
    meishurushouji.textColor = [UIColor whiteColor];
    meishurushouji.text = @" 您的账号已复制到剪贴板";
    meishurushouji.layer.cornerRadius = 7;
    meishurushouji.clipsToBounds = YES;
   
    meishurushouji.backgroundColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:75/255.0 alpha:1];
    [lastwindou addSubview:meishurushouji];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationDelegate:self];
    meishurushouji.alpha =0.0;
    [UIView commitAnimations];//2秒后消失
    if (__kScreenHeight__ == 568) {
         meishurushouji.font = [UIFont systemFontOfSize:9];
    }else if (__kScreenHeight__ >= 667)
    {
         meishurushouji.font = [UIFont systemFontOfSize:11];
    }

    
    
}
-(void)tongyitiaokuan1:(id)sender
{
    
    [self showShareView1];
    
}
- (void)showShareView1{
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview1.hidden = NO;
                         
                         //使用block，来执行一个动画
                         //向下的平移
                         //                         .transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight-1230/3-kNavigationBarHeight));
                         
                         zhedang1.hidden = NO;
                     }];
    
}

//隐藏尾部视图
- (void)hideShareView1{
    
    
    [UIView animateWithDuration:.35
                     animations:^{
                         xieyiview1.hidden = YES;
                     }];
    
}
-(void)maskViewAction2:(id)sender
{
    zhedang1.hidden = YES;
    [self hideShareView1];
}



@end
