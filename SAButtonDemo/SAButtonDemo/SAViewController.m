//
//  SAViewController.m
//  SAButtonDemo
//
//  Created by 李磊 on 7/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()


@end

@implementation SAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(10,10  ,(self.view.bounds.size.width - 20 ) / 3.0, 190)];
    _lab.text = @"这是吃数据阿卡就拉开卡拉奇欧派；阿拉丁齐文龙卡来看待家里";
    _lab.numberOfLines = 0;
    _lab.userInteractionEnabled = YES;
    _lab.backgroundColor = [UIColor redColor];
    _lab.textColor = [UIColor greenColor];
    [self.view addSubview:_lab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
