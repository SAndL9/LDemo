//
//  LLPageCollectionCell.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageCollectionCell.h"
#import <Masonry/Masonry.h>

@interface LLPageCollectionCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LLPageCollectionCell

#pragma mark-
#pragma mark- View Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsContraints];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    self.titleLabel.backgroundColor = self.backgroundColor;
//}

#pragma mark-
#pragma mark- <#代理类名#> delegate

#pragma mark-
#pragma mark- Event response


#pragma mark-
#pragma mark- Private Methods


#pragma mark-
#pragma mark- Getters && Setters
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    self.titleLabel.textColor = isSelected ? _selectedColor : _normalColor;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];

    }
    
    return _titleLabel;
}


#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
