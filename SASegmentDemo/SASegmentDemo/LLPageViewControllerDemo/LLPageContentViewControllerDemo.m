//
//  LLPageContentViewControllerDemo.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageContentViewControllerDemo.h"
#import "LLPageContentViewController.h"
#import "LLPageViewController.h"
#import "LLRedViewController.h"
#import "LLBlueViewController.h"
#import "LLGreenViewController.h"
#import "LLOrangeViewController.h"
#import <Masonry/Masonry.h>
@interface LLPageContentViewControllerDemo ()<LLPageViewControllerDataSource>

@property (nonatomic, strong) LLPageContentViewController *pageVC;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@end

@implementation LLPageContentViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pageVC = [[LLPageContentViewController alloc]init];
    _pageVC.view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
    _pageVC.dataSource = self;
    _pageVC.selectedIndex = 2;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 0, 0, 0));
    }];
}
- (NSInteger)numbersOfPageInPageViewController:(LLPageContentViewController *)pageViewController{
    return 6;
}

- (NSString *)pageViewController:(LLPageContentViewController *)pageViewController titleAtIndex:(NSUInteger)index{
    return self.titleArray[index];
}

- (UIViewController *)pageViewController:(LLPageContentViewController *)pageViewController childViewControllerAtIndex:(NSUInteger)index{
    return self.viewControllerArray[index];
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]initWithObjects:@"秒",@"分",@"刻",@"时",@"天",@"周",@"月",@"年", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)viewControllerArray{
    if (!_viewControllerArray) {
        LLRedViewController *vc = [[LLRedViewController alloc]init];
        LLBlueViewController *vc1 = [[LLBlueViewController alloc]init];
        LLOrangeViewController *vc2 = [[LLOrangeViewController alloc]init];
        LLGreenViewController *vc3 = [[LLGreenViewController alloc]init];
        LLRedViewController *vc4 = [[LLRedViewController alloc]init];
        LLBlueViewController *vc5 = [[LLBlueViewController alloc]init];
        LLOrangeViewController *vc6 = [[LLOrangeViewController alloc]init];
        LLGreenViewController *vc7 = [[LLGreenViewController alloc]init];
        _viewControllerArray = [[NSMutableArray alloc]initWithObjects:vc,vc1,vc2,vc3,vc4,vc5,vc6,vc7, nil];
    }
    return _viewControllerArray;
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
