//
//  PGArrowView.m
//  PerfectVideoEditor
//
//  Created by zangqilong on 14/12/4.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import "PGArrowView.h"

@interface PGArrowView ()
{
    CAShapeLayer *arrowLayer;
}
@end

@implementation PGArrowView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        arrowLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:arrowLayer];
    }
    return self;
}

- (void)startAnimation
{
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(69.5, 57.5)];
    [bezierPath addLineToPoint: CGPointMake(79.5, 49.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 57.5)];
   
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    bezierPath.lineWidth = 1;
     [[UIColor whiteColor] setStroke];
    [bezierPath stroke];
    
    UIBezierPath* bezierPath2 = UIBezierPath.bezierPath;
    [bezierPath2 moveToPoint: CGPointMake(69.5, 57.5)];
    [bezierPath2 addLineToPoint: CGPointMake(79.5, 66.5)];
    [bezierPath2 addLineToPoint: CGPointMake(88.5, 57.5)];
    
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    bezierPath2.lineWidth = 1;
      [[UIColor whiteColor] setStroke];
    [bezierPath2 stroke];
    
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
