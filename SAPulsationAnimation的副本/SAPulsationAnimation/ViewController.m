//
//  ViewController.m
//  SAPulsationAnimation
//
//  Created by 李磊 on 28/6/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SAPulsationAnimationView.h"

@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) SAPulsationAnimationView *rv;

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
   
    _redView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 60) / 2.0, (self.view.frame.size.height - 60) / 2.0, 60, 60)];
    _redView.clipsToBounds = YES;
    _redView.layer.cornerRadius = _redView.frame.size.width / 2.0;
    _redView.backgroundColor = [UIColor redColor];
    [self setup];
}
- (void)test{
    
//    _rv  = [[SAPulsationAnimationView alloc] initWithFrame:CGRectMake(0 , 0, 150, 150)];
//    [_rv animationWithDuraton:2.8];
//    _rv.center = _redView.center;
//    [self.view addSubview:_rv];
//    [self.view addSubview:_redView];
//    [self setup];
}
- (IBAction)aaa:(UIButton *)sender {
    
//    [_rv removeFromSuperview];
    [_testView removeFromSuperview];
    [_timer invalidate];
    
}

- (void)setup
{
    _testView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _testView.center = _redView.center;
    [self.view addSubview:_testView];
    [self.view addSubview:_redView];
    _testView.layer.backgroundColor = [UIColor clearColor].CGColor;
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = _testView.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor =[UIColor colorWithRed:9/255.0 green:113/255.0 blue:206/255.0 alpha:1].CGColor;//填充色
    pulseLayer.opacity = 0.0;
    
    //可以复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = _testView.bounds;
    replicatorLayer.instanceCount = 5;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 0.8;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [_testView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}


@end
