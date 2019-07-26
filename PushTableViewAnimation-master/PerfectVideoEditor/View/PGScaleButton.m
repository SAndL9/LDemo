//
//  PGScaleButton.m
//  LiteCamera
//
//  Created by zangqilong on 14/11/3.
//  Copyright (c) 2014年 PG. All rights reserved.
//

#import "PGScaleButton.h"
#import "POP.h"

@implementation PGScaleButton



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	POPBasicAnimation *scale = [self pop_animationForKey:@"scale"];
	
	
	if (scale)
    {
		scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.3, 1.3)];
	}
    else
    {
		scale = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
		scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.3, 1.3)];
        scale.duration = 0.1;
		[self pop_addAnimation:scale forKey:@"scale"];
	}

	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	POPBasicAnimation *scale = [self pop_animationForKey:@"scale"];
	
	if (scale)
    {
		scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
	}
    else
    {
		scale = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
		scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        scale.duration = 0.1;
		[self pop_addAnimation:scale forKey:@"scale"];
	}
	
	[super touchesEnded:touches withEvent:event];
}


@end
