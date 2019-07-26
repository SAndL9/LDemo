//
//  LLTopSegmentView.h
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLTopSegmentViewDelegate;

@interface LLTopSegmentView : UIView

@property (nonatomic, weak) id <LLTopSegmentViewDelegate>delegate;

/**
 标题数组
 */
@property (nonatomic, copy) NSArray <NSString *> *items;

/**
 未选择时文字颜色,默认黑色
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 选择时的文字颜色,默认红色
 */
@property (nonatomic, strong) UIColor *titleSelectColor;


/**
 选择宽度 默认120
 */
@property (nonatomic, assign) CGFloat segmentWidth;

/**
 当前被选中的下标，设置默认选中下标为0
 */
@property (nonatomic,assign) NSInteger selectedSegmentIndex;

/**
 *  初始化方法
 *
 *  @param items 标题数组
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

/**
 选中下标
 */
- (void)topSegmentSelectIndex:(NSInteger)index;

@end

@protocol LLTopSegmentViewDelegate <NSObject>

@optional
/**
 改变下标
 @param segIndex 当前选中下标
 */
- (void)changeSegmentAtIndex:(NSInteger)segIndex;

@end



