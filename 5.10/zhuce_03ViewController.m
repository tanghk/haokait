//
//  zhuce_03ViewController.m
//  555
//
//  Created by 李浩宇 on 16/3/29.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "zhuce_03ViewController.h"
#import "UICommons.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "NewbieController.h"
@interface zhuce_03ViewController ()
{
    UILabel *_titleLabel;
}

@end

@implementation zhuce_03ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"注册成功";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    
    
    
#pragma mark - 背景图
    UIImageView *imge_deng = [[UIImageView alloc]init];
    [self.view addSubview:imge_deng];
    [imge_deng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height - 64);
        
    }];
    [imge_deng setImage:[UIImage imageNamed:@"zhuce_03.png"]];
    
    
#pragma mark -立即体验按钮
    if (__kScreenHeight__ == 568) {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.89*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (__kScreenHeight__ == 667)
    {
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.895*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        UIImage *im2 = [UIImage imageNamed:@""];
        UIButton *denglu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.892*__kScreenHeight__, __kScreenWidth__, 0.079*__kScreenHeight__)];
        [denglu setBackgroundImage:im2 forState:UIControlStateNormal];
        denglu.backgroundColor = [UIColor clearColor];
        [self.view addSubview:denglu];
        [denglu addTarget:self action:@selector(chenggongl:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

#pragma mark - 去逛逛
    if (__kScreenHeight__ == 568) {
       
        UIButton *guang = [[UIButton alloc]init];
        [self.view addSubview:guang];
        [guang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0.821*__kScreenHeight__);
            make.left.mas_offset(0.355*__kScreenWidth__);
            make.width.mas_offset(0.287*__kScreenWidth__);
            make.height.mas_offset(0.05*__kScreenHeight__);
        }];
        guang.backgroundColor = [UIColor clearColor];
        [guang addTarget:self action:@selector(guangguang:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (__kScreenHeight__ == 667)
    {
        UIButton *guang = [[UIButton alloc]init];
        [self.view addSubview:guang];
        [guang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0.821*__kScreenHeight__);
            make.left.mas_offset(0.355*__kScreenWidth__);
            make.width.mas_offset(0.287*__kScreenWidth__);
            make.height.mas_offset(0.048*__kScreenHeight__);
        }];
        guang.backgroundColor = [UIColor clearColor];
        [guang addTarget:self action:@selector(guangguang:) forControlEvents:UIControlEventTouchUpInside];
        

    }else{
        
        UIButton *guang = [[UIButton alloc]init];
        [self.view addSubview:guang];
        [guang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0.81*__kScreenHeight__);
            make.left.mas_offset(0.355*__kScreenWidth__);
            make.width.mas_offset(0.287*__kScreenWidth__);
            make.height.mas_offset(0.06*__kScreenHeight__);
        }];
        guang.backgroundColor = [UIColor clearColor];
        [guang addTarget:self action:@selector(guangguang:) forControlEvents:UIControlEventTouchUpInside];
        

    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chenggongl:(id)sender
{
    NewbieController *newbie = [[NewbieController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:newbie animated:NO completion:nil];
    
    newbie.productId = @"996";

}
-(void)fanhui:(id)sender
{
   
  
        AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        TabbarViewController *tab = [[TabbarViewController alloc]init];
        delete.window.rootViewController = tab;
        

    
}
-(void)guangguang:(id)sender
{
    AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabbarViewController *tab = [[TabbarViewController alloc]init];
    delete.window.rootViewController = tab;
    
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
