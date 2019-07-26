//
//  LLPageView.h
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLPageViewDelegate;

@interface LLPageView : UIView

@property (nonatomic, weak) id <LLPageViewDelegate>delegate;

/** 选择的下标 */
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation;

@end

@protocol LLPageViewDelegate <NSObject>

/**
 选中

 @param view 当前view
 @param index 选择的下标
 */
- (void)segmentView:(LLPageView *)view didSelectedIndex:(NSInteger)index;

- (NSInteger)numbersOfPageInPageView:(LLPageView*)view;

- (NSString *)pageView:(LLPageView *)pageView itemTitleIndex:(NSInteger)index;

@end



