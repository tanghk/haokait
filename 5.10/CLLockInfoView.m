//
//  CLLockInfoView.m
//  CoreLock
//
//  Created by 成林 on 15/4/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockInfoView.h"
#import "CoreLockConst.h"
#import "CLLockVC.h"


@implementation CLLockInfoView

@synthesize success;
@synthesize pwd;
-(void)drawRect:(CGRect)rect{
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置属性
    CGContextSetLineWidth(ctx, CoreLockArcLineW);
    
    //设置线条颜色
    [CoreLockCircleLineNormalColor set];
    
    //新建路径
    CGMutablePathRef pathM =CGPathCreateMutable();
    
    CGFloat marginV = 3.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (rect.size.width - marginV * 2 - padding*2) / 3;
    
    //添加圆形路径
    for (NSUInteger i=0; i<9; i++) {
        
        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        
        CGFloat rectY = (rectWH + marginV) * col + padding;
        
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        if(success&&pwd){
            if ([pwd rangeOfString:[NSString stringWithFormat:@"%ld",i]].location != NSNotFound) {
                CGContextSetRGBFillColor(ctx,255/255.f, 255/255.f, 255/255.f,1);
                CGContextAddEllipseInRect(ctx,rect);
                //CGPathAddEllipseInRect(pathM, NULL, rect);
                CGContextFillPath(ctx);
            }else{
                CGPathAddEllipseInRect(pathM, NULL, rect);
            }
            
        }else{
            CGPathAddEllipseInRect(pathM, NULL, rect);
        }
    }
    
    //添加路径
    CGContextAddPath(ctx, pathM);
    
    //绘制路径
    CGContextStrokePath(ctx);
    
    //释放路径
    CGPathRelease(pathM);
}

@end