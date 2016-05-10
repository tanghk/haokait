//
//  promptLabel.m
//  555
//
//  Created by otouzi on 16/4/8.
//  Copyright © 2016年 李浩宇. All rights reserved.
//

#import "promptLabel.h"
#import "CoreLockConst.h"
#import "CALayer+Anim.h"

@implementation promptLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图初始化
        [self viewPrepare];
    }
    
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图初始化
        [self viewPrepare];
    }
    
    return self;
}


/*
 *  视图初始化
 */
-(void)viewPrepare{
    
    self.font = [UIFont systemFontOfSize:16.0f];
}





/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg{
    
    self.text = msg;
    self.textColor = CoreLockCircleLineNormalColor;
}




/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg{
    
    self.text = msg;
    self.textColor = CoreLockWarnColor;
    
    //添加一个shake动画
    [self.layer shake];
}


@end
