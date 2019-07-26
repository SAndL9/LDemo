//
//  ViewController.m
//  SADownPopView
//
//  Created by 李磊 on 29/6/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SADownPopView.h"
@interface ViewController ()
@property (nonatomic, strong) SADownPopView *saDownPopView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)pop:(UIButton *)sender {
    _saDownPopView = [[SADownPopView alloc]init];
    [_saDownPopView showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
