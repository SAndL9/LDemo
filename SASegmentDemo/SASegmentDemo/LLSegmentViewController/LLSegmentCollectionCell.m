//
//  LLSegmentCollectionCell.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLSegmentCollectionCell.h"
#import <Masonry/Masonry.h>

@interface LLSegmentCollectionCell ()

/**
 线宽度
 */
@property (nonatomic, assign) CGFloat belowLineWidth;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LLSegmentCollectionCell

#pragma mark-
#pragma mark- View Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _belowLineWidth = 1.0f;
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- 代理类名 delegate


#pragma mark-
#pragma mark- Event response


#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

- (void)setIsSelectd:(BOOL)isSelectd{
    _isSelectd = isSelectd;
    if (_isSelectd) {
        _lineView.hidden = NO;
        _titleLabel.textColor = _selectColor;
        _lineView.backgroundColor = _selectColor;
    }else{
        _lineView.hidden = YES;
        _titleLabel.textColor = _nomalColor;
        _lineView.backgroundColor = _nomalColor;
    }
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5, 0, 5));
        make.top.equalTo(self.contentView.mas_bottom).offset(-2);
        make.height.mas_equalTo(2);
    }];
   
}


@end
