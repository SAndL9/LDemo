//
//  SARippleView.m
//  SARippleAnimation
//
//  Created by 李磊 on 7/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "SARippleView.h"

@implementation SARippleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    //开始动画半径
    CGFloat rabius = 60;
    //开始jiao
    CGFloat startAngle = 0;
    
    //中心点
    CGPoint point = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    
    //结束jiao
    CGFloat endAngle = 2 *M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:rabius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    
    layer.strokeColor = [UIColor colorWithRed:9/255.0 green:113/255.0 blue:206/255.0 alpha:1].CGColor;;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
}


@end
