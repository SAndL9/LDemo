//
//  SAPageDemoViewController.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "SAPageDemoViewController.h"
#import "SAPageViewController.h"
#import <Masonry/Masonry.h>

#import "LLRedViewController.h"
#import "LLBlueViewController.h"
#import "LLOrangeViewController.h"
#import "LLGreenViewController.h"
@interface SAPageDemoViewController ()<SAPageViewControllerDelegate>

@end

@implementation SAPageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self test];
}

- (void)test{
    SAPageViewController *pageViewController = [[SAPageViewController alloc]init];
    LLRedViewController *vc = [[LLRedViewController alloc]init];
    LLBlueViewController *vc1 = [[LLBlueViewController alloc]init];
    LLOrangeViewController *vc2 = [[LLOrangeViewController alloc]init];
    LLGreenViewController *vc3 = [[LLGreenViewController alloc]init];
    pageViewController.pageTitles = @[@"红色",@"蓝色",@"橘色",@"绿色"];
    pageViewController.viewControllers = @[vc,
                                           vc1,
                                           vc2,vc3];
    pageViewController.scrollPosition = SATopViewItemScrollPositionMiddle;
    pageViewController.pageViewTopMargin = 0;
    pageViewController.topViewItemTitleNormalColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    pageViewController.topViewItemTitleSelectedColor = pageViewController.lineColor = [UIColor colorWithRed:0 green:148.0/255.0 blue:246.0/255.0 alpha:1.0];
    pageViewController.topViewItemWidth = (CGRectGetWidth(self.view.frame)-60)/4.0;
    pageViewController.currentSelectedIndex = 2;
    pageViewController.delegate = self;
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(80, 0, 50, 0));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pageViewController.pageTitles = @[@"红色2",@"蓝色3",@"橘色4",@"绿色5"];
    });
}


- (void)ViewController:(UIViewController* )viewcontroller atIndex:(NSInteger)index{
    
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
