//
//  ViewController.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SAPageDemoViewController.h"
#import "LLSegmentDemoViewController.h"
#import "LLPageViewControllerDemo.h"
#import "LLPageContentViewControllerDemo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)llpage:(id)sender {
    SAPageDemoViewController *vc = [[SAPageDemoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)llSegment:(id)sender {
    LLSegmentDemoViewController *vc = [[LLSegmentDemoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)llPageAction:(id)sender {
    LLPageViewControllerDemo *vc = [[LLPageViewControllerDemo alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)button:(id)sender {
    LLPageContentViewControllerDemo *vc = [[LLPageContentViewControllerDemo alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
