//
//  LLPageViewControllerDemo.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageViewControllerDemo.h"
#import "LLPageViewController.h"
#import "LLRedViewController.h"
#import "LLBlueViewController.h"
#import "LLGreenViewController.h"
#import "LLOrangeViewController.h"
#import <Masonry/Masonry.h>

@interface LLPageViewControllerDemo ()

@end

@implementation LLPageViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    LLRedViewController *vc = [[LLRedViewController alloc]init];
    LLBlueViewController *vc1 = [[LLBlueViewController alloc]init];
    LLOrangeViewController *vc2 = [[LLOrangeViewController alloc]init];
    LLGreenViewController *vc3 = [[LLGreenViewController alloc]init];
    LLRedViewController *vc4 = [[LLRedViewController alloc]init];
    LLBlueViewController *vc5 = [[LLBlueViewController alloc]init];
    LLOrangeViewController *vc6 = [[LLOrangeViewController alloc]init];
    LLGreenViewController *vc7 = [[LLGreenViewController alloc]init];
    NSMutableArray *dataSourceArray = @[vc,vc1,vc2,vc3,vc4,vc5,vc6,vc7].mutableCopy;
    NSMutableArray *titleArray = @[@"秒",@"分",@"刻",@"时",@"天",@"周",@"月",@"年"].mutableCopy;
    LLPageViewController *segVC = [[LLPageViewController alloc]init];
    segVC.viewControllers = dataSourceArray;
    segVC.pageTitleArrays = titleArray;
//    segVC.view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
    segVC.selectedIndex = 2;
    [self addChildViewController:segVC];
    [self.view addSubview:segVC.view];
    
    [segVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 0, 0, 0));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        segVC.pageTitleArrays = @[@"秒1",@"分2",@"刻3",@"时4",@"天5",@"周6",@"月7",@"年8"].mutableCopy;
    });
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
