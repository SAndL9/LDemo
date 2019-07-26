//
//  PTXDatePickerView.h
//  PTXDatePickerView
//
//  Created by pantianxiang on 17/1/12.
//  Copyright © 2017年 pantianxiang. All rights reserved.
//  我的CSDN博客地址：http://blog.csdn.net/mrtianxiang
//

#import <UIKit/UIKit.h>




@protocol PTXDatePickerViewDelegate;

@interface PTXDatePickerView : UIView

@property (nonatomic, assign) NSInteger minYear; //时间列表最小年份，不能大于最大年份。默认为1970年。
@property (nonatomic, assign) NSInteger maxYear; //时间列表最大年份，不能小于最小年份。默认为当前年份。注意：仅当属性datePickerViewDateRangeModel的值为PTXDatePickerViewDateRangeModelCustom时才有效。

@property (nonatomic, assign, readonly, getter=isVisible) BOOL visible; //YES:处于显示状态，NO:处于隐藏状态。




@property (nonatomic, assign) id<PTXDatePickerViewDelegate> delegate;

/**
 *  显示时间选择器。
 *
 *  @param date 初始显示日期，传nil则默认显示当前日期。
 *  @param animation YES:有动画，NO:无动画。
 */
- (void)showViewWithDate:(NSDate *)date animation:(BOOL)animation;

/**
 *  隐藏时间选择器。
 *
 *  @param animation YES:有动画，NO:无动画。
 */
- (void)hideViewWithAnimation:(BOOL)animation;

@end

@protocol PTXDatePickerViewDelegate <NSObject>

- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date;

@end
