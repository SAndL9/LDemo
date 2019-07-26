//
//  ViewController.m
//  RadarAnimation
//
//  Created by 储诚鹏 on 16/11/30.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

#import "ViewController.h"
#import "RadarView.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong)RadarView *rv;

@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(test) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat sh = [UIScreen mainScreen].bounds.size.height;
    _redView = [[UIView alloc]initWithFrame:CGRectMake(sw / 2.0 - 30, sh / 2.0 - 30, 60, 60)];
    _redView.backgroundColor = [UIColor redColor];
   
    
}

- (void)test{
  
    _rv  = [[RadarView alloc] initWithFrame:CGRectMake(0 , 0, 150, 150)];
    [_rv animationWithDuraton:3.5];
    _rv.center = _redView.center;
    [self.view addSubview:_rv];
    [self.view addSubview:_redView];
    
}

- (IBAction)startSearch:(UIButton *)sender {
    [_rv removeFromSuperview];
    [_timer invalidate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
