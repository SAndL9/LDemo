//
//  LLPageViewController.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageViewController.h"
#import "LLPageView.h"
static NSInteger const pageViewHeight = 30;

@interface LLPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, LLPageViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) LLPageView *pageView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation LLPageViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    UIViewController *vc = [self.dataSourceArray objectAtIndex:self.selectedIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    self.pageView.frame = CGRectMake(0, 0, self.view.frame.size.width, pageViewHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviewsContraints];
    _currentIndex = 0;
}

#pragma mark-
#pragma mark- UIPageViewControllerdelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSourceArray indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self.dataSourceArray objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSourceArray indexOfObject:viewController];
    if (index == self.dataSourceArray.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    
    index++;
    return [self.dataSourceArray objectAtIndex:index];
}

- (void)segmentView:(LLPageView *)view didSelectedIndex:(NSInteger)index {
    NSLog(@"kkkkkkk-----%ld",index);
    UIViewController *vc = [self.dataSourceArray objectAtIndex:index];
    if (index > _currentIndex) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    _currentIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.dataSourceArray indexOfObject:nextVC];
    _currentIndex = index;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.pageView.selectedIndex = _currentIndex;
    }  
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.dataSourceArray.count;
}
#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}

- (LLPageView *)pageView{
    if (!_pageView) {
        _pageView = [[LLPageView alloc]init];
        _pageView.delegate = self;
    }
    return _pageView;
}


- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        for (UIView *subView in _pageViewController.view.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                NSLog(@"—————%@———————",subView);
            }else{
            
            }
        }
    }
    
    return _pageViewController;
}
- (void)setPageTitleArrays:(NSArray<NSString *> *)pageTitleArrays{
    _pageTitleArrays = pageTitleArrays;
//    self.pageView.datas = pageTitleArrays;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    
    [self.dataSourceArray addObjectsFromArray:_viewControllers];
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.pageView.normalColor = normalColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    self.pageView.selectedColor = selectedColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.pageView.selectedIndex = selectedIndex;
    _currentIndex = selectedIndex;
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.pageView];
    [self.view bringSubviewToFront:self.pageView];
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
