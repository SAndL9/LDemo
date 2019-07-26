//
//  LLPageViewController.h
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLPageViewControllerDataSource ;


@interface LLPageViewController : UIViewController

/**标题*/
@property (nonatomic, strong) NSArray<NSString *> *pageTitleArrays;

/**包含的子控制器*/
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

/**选中的索引*/
@property (nonatomic, assign) NSInteger selectedIndex;

/**标题未选中的颜 */
@property (nonatomic, strong) UIColor *normalColor;

/* 标题选中的颜色 */
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, weak) id<LLPageViewControllerDataSource>dataSource;

@end

@protocol LLPageViewControllerDataSource<NSObject>

@required
- (NSUInteger)numbersOfPageInPageViewController:(LLPageViewController *)pageViewController;

- (NSString *)pageViewController:(LLPageViewController *)pageViewController titleAtIndex:(NSUInteger)index;

- (UIViewController *)pageViewController:(LLPageViewController *)pageViewController childViewControllerAtIndex:(NSUInteger)index;

@optional
- (NSUInteger)pageViewController:(LLPageViewController *)pageViewController badgeNumberAtIndex:(NSUInteger)index;

//- (UIView *)pageViewController:(LLPageViewController *)pageViewController headerCustomViewAtIndex:(NSUInteger)index;
@end
