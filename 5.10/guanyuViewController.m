//
//  guanyuViewController.m
//  555
//
//  Created by 李浩宇 on 16/4/12.
//  Copyright © 2016年 李浩宇. All rights reserved.
//
#import "WelcomeViewController.h"
#import "guanyuViewController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "AdviceFeedbackViewController.h"
@interface guanyuViewController ()
{
    
    UILabel *_titleLabel;
}

@end

@implementation guanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
    [self.view addSubview:navigationgView];
    
    
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn22"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(cheba5:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
  
#pragma mark - 背景图
    
    UIImageView *imge_deng = [[UIImageView alloc]init];
    [self.view addSubview:imge_deng];
    [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height - 64);
        
    }];
    [imge_deng setImage:[UIImage imageNamed:@"guanyu_main.png"]];
    
    UIView *ban = [[UIView alloc]init];
    [self.view addSubview:ban];
    [ban mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(62);
        make.left.mas_offset(0);
        make.width.mas_offset(200);
        make.height.mas_offset(2);
    }];
    ban.backgroundColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:61/255.0 alpha:1];
    
#pragma mrak - 去评分
    UIButton *btnpingfen = [UIButton new];
    
    
    [btnpingfen addTarget:self action:@selector(makefen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnpingfen];
    
    [btnpingfen mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.53*__kScreenHeight__-94);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);
        }else{
            make.top.mas_equalTo(0.53*__kScreenHeight__-109);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);
        }
        
    }];
    

#pragma mark - 欢迎页
    UIButton *btncome = [UIButton new];
    
    
    [btncome addTarget:self action:@selector(wellcome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btncome];
    
    [btncome mas_makeConstraints:^(MASConstraintMaker *make) {
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.53*__kScreenHeight__-47);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);

        }else{
            make.top.mas_equalTo(0.53*__kScreenHeight__-54);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);

        }
           }];

    
#pragma mark - 意见反馈
    UIButton *btn1 = [UIButton new];
    
    
    [btn1 addTarget:self action:@selector(adviceFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0.53*__kScreenHeight__);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(__kScreenWidth__);
        make.height.mas_equalTo(46);
    }];
    
    
#pragma mark - 客服热线
    UIButton *btncall = [UIButton new];
    
    
    [btncall addTarget:self action:@selector(kefucell:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btncall];
    
    [btncall mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.53*__kScreenHeight__+47);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);
        }else{
            make.top.mas_equalTo(0.53*__kScreenHeight__+54);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(46);
        }
       
    }];
 

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cheba5:(id)sender
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
-(void)adviceFeedBack{
    
    AdviceFeedbackViewController *advice = [[AdviceFeedbackViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:advice animated:NO completion:nil];
    
    
}
-(void)wellcome:(id)sender
{
    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:welcomeVC animated:NO completion:nil];

}
-(void)makefen:(id)sender
{
     NSString * APP_ID = @"1099021145";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",APP_ID]]];
}
-(void)kefucell:(id)sender
{
    
    
            // 拨号访问alertView
            //NSString *title = NSLocalizedString(@"A Short Title Is Best", nil);
            NSString *message = NSLocalizedString(@"400-9693-788", nil);
            NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"呼叫", nil);
    
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            }];
    
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    
    
                NSString *number = @"4009693788";// 此处读入电话号码
                // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
    
                NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
            }];
    
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
    
            [self presentViewController:alertController animated:YES completion:nil];
            

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
