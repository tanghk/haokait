//
//  NetworkState.m
//  555
//
//  Created by otouzi on 16/4/20.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "NetworkState.h"
#import "Masonry.h"
#import "UICommons.h"
@implementation NetworkState

+ (instancetype)sharedNetworkState {
    static NetworkState *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkState alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //_array = [NSMutableArray array];
        [self createMaskView];
    }
    return self;
}

+(void)showNetworkStatePrompt{




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
    _rechargeView.frame = CGRectMake((kScreenWidth-873/3)/2, 870*kPlusHeightScale, 873/3, 470*kPlusHeightScale);
    
    _rechargeView.layer.cornerRadius = 5;
    _rechargeView.hidden = YES;
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    [_lastWindow addSubview:_rechargeView];
    
    
    //文本内容
    _contentLabel = [[UILabel alloc]init];
    //_contentLabel.frame = CGRectMake(80*kPlusScale, 34*kHeightScale, _rechargeView.width-(80+80)*kPlusScale, 100);
    _contentLabel.numberOfLines = 1;
    _contentLabel.font = [UIFont systemFontOfSize:30/2];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    

      _contentLabel.text = [NSString stringWithFormat:@"网络连接超时，请检查您的网络设置。"];

    
    [_rechargeView addSubview:_contentLabel];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_rechargeView.mas_top).offset(116*kPlusHeightScale);
        make.left.equalTo(_rechargeView.mas_left);
        make.right.equalTo(_rechargeView.mas_right);
        make.height.mas_equalTo(15);
    }];
    //确认
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    sureButton.frame = CGRectMake(82*kPlusScale, _contentLabel.height+_contentLabel.origin.y+60*kPlusHeightScale, (_rechargeView.width-(82)*kPlusScale)/2, 110*kPlusScale);
    
    
    
    [sureButton setTitle:@"我知道了" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:45/3];
    sureButton.titleLabel.textColor = [UIColor whiteColor];
    UIColor *sureColor = kColorMain;
    sureButton.layer.cornerRadius = 5;
    [sureButton setBackgroundColor:sureColor];
    [sureButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_rechargeView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rechargeView.mas_centerX);
        make.top.equalTo(_contentLabel.mas_bottom).offset(116*kPlusHeightScale);
        make.width.mas_equalTo(303*kPlusScale);
        make.height.mas_equalTo(125*kPlusHeightScale);
        
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



@end
