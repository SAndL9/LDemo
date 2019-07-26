//
//  LLPageContentViewController.h
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLPageViewControllerDataSource;

@interface LLPageContentViewController : UIViewController

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
- (NSInteger)numbersOfPageInPageViewController:(LLPageContentViewController *)pageViewController;

- (NSString *)pageViewController:(LLPageContentViewController *)pageViewController titleAtIndex:(NSUInteger)index;

- (UIViewController *)pageViewController:(LLPageContentViewController *)pageViewController childViewControllerAtIndex:(NSUInteger)index;

@optional
- (NSUInteger)pageViewController:(LLPageContentViewController *)pageViewController badgeNumberAtIndex:(NSUInteger)index;

//- (UIView *)pageViewController:(LLPageContentViewController *)pageViewController headerCustomViewAtIndex:(NSUInteger)index;
@end
