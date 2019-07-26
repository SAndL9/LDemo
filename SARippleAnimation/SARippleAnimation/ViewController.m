//
//  ViewController.m
//  SARippleAnimation
//
//  Created by 李磊 on 7/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SARippleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(clickAnimation) userInfo:nil repeats:YES];
}

- (void)clickAnimation{
    
    SARippleView *sarippleView = [[SARippleView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 150 ) / 2.0, 200, 150, 150)];
    sarippleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sarippleView];
    
    [UIView animateWithDuration:2 animations:^{
        
        sarippleView.transform = CGAffineTransformScale(sarippleView.transform, 2, 2);
        
        sarippleView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [sarippleView removeFromSuperview];
        NSLog(@"%ld",self.view.subviews.count);
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
