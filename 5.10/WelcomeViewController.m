//
//  WelcomeViewController.m
//  555
//
//  Created by otouzi on 16/1/21.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UICommons.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
   // [self creatWithNavGation];

}
- (void)viewDidLoad {
    [super viewDidLoad];
     _window =[UIApplication sharedApplication].windows.lastObject ;//当前的window
    scrVl=[[UIScrollView alloc] init];
    scrVl.pagingEnabled = YES;
    scrVl.delegate=self;
    scrVl.frame=CGRectMake(0, 0,self.window.frame.size.width, self.window.frame.size.height);
    scrVl.bounces = NO;
    scrVl.contentSize=CGSizeMake(self.window.frame.size.width*4, self.window.frame.size.height);
    [self.window addSubview:scrVl];
    
    
    
    
    
    for (int i=0; i<4; i++) {
        [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%dhelp%d",5,i+1] rect:CGRectMake(self.window.frame.size.width*i, 0,self.window.frame.size.width ,self.window.frame.size.height)]];
    }
    
    
    [self buttonPhoto:nil hilPhoto:@"helpBtn.png" rect:CGRectMake(self.window.frame.size.width*3+105,self.window.frame.size.height-50, 294/2,67/2) title:@"" select:@selector(hiddenScroller:) Tag:1 View:scrVl textColor:[UIColor whiteColor]];
    
    
    thePGLeft=[[PageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    
    thePGLeft.dotColorCurrentPage=[UIColor yellowColor];
    
    thePGLeft.center=CGPointMake(kScreenWidth/2,120*kScreenHeight/1334);
    
    thePGLeft.numberOfPages=4;
    [self.window addSubview:thePGLeft];
    

    
}
-(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect{
    UIImageView*view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    view.frame=rect;
    return view;
}
-(UIButton*)buttonPhoto:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title select:(SEL)sel Tag:(int)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:Hphoto] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:photo] forState:UIControlStateHighlighted];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    [ViewA addSubview:button];
    return button;
}
-(void)hiddenScroller:(id)sender
{
    
    
    
    [UIView animateWithDuration:2.0
                     animations:^{
                         scrVl.alpha = 0.0;
                         thePGLeft.alpha=0.0;
                         [self dismissViewControllerAnimated:YES completion:^{
                             ;
                         }];
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
}

#pragma UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [thePGLeft setCurrentPage:offset.x / bounds.size.width];
    
}

#pragma mark - 导航栏
- (void)creatWithNavGation{
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    navigationgView.backgroundColor = kColorDeepBlue;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 70/2, kScreenWidth, 30/2);
    
    _titleLabel.font = [UIFont systemFontOfSize:30/2];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 88*__kScreenWidth__/750, 88*__kScreenHeight__/1334);
    [backBtn setImage:[UIImage imageNamed:@"6moreCentreSJ"] forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(backBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
}



- (void)backBtnAction:(UIButton*)sender
{
   
    [self dismissViewControllerAnimated:NO completion:nil];
    
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

@end
