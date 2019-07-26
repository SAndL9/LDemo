//
//  LLContentSegmentView.h
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLContentSegmentViewDelegate;



@interface LLContentSegmentView : UIView

@property (nonatomic, weak) id<LLContentSegmentViewDelegate>delegate;


/**
 存放对应的内容控制器
 */
@property (nonatomic, strong)NSMutableArray <UIViewController *>*dataArray;


/**
 初始化方法
 
 @param frame frame
 @param contentArray 视图控制器数组
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray <UIViewController *>*)contentArray;

/**
 手动选中某个页面
 
 @param index 默认为1（即从1开始）
 */
-(void)selectIndex:(NSInteger)index;

@end

@protocol LLContentSegmentViewDelegate <NSObject>

@optional
/**
 滑动回调
 @param index 对应的下标（从1开始）
 */
- (void)contentScrollViewToIndex:(NSInteger)index;

@end
