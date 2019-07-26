//
//  LLSegmentCollectionCell.h
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSegmentCollectionCell : UICollectionViewCell

/**
 标签
 */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *nomalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, assign) BOOL isSelectd;



@end
