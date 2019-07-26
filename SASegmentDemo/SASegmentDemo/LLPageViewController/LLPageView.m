//
//  LLPageView.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageView.h"
#import "LLPageCollectionCell.h"

static NSInteger const kShowVisibleWidth = 80;

@interface LLPageView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *slideLine;

@end

@implementation LLPageView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:253/255.0 green:166/255.0 blue:57/255.0 alpha:1.0];
        _selectedColor = [UIColor redColor];
        _normalColor = [UIColor whiteColor];
        [self setupSubviewsContraints];
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.slideLine.frame = CGRectMake(4, self.bounds.size.height - 2, kShowVisibleWidth - 10, 2);
}

#pragma mark-
#pragma mark- UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(numbersOfPageInPageView:)]) {
        return [self.delegate numbersOfPageInPageView:self];
    }else{
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LLPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LLPageCollectionCell class]) forIndexPath:indexPath];
    cell.selectedColor = self.selectedColor;
    cell.normalColor = self.normalColor;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:itemTitleIndex:)]) {
        cell.title = [self.delegate pageView:self itemTitleIndex:indexPath.row];
    }
    
    cell.isSelected = ( self.selectedIndex == indexPath.row ) ? YES : NO;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [self setSelectedIndex:indexPath.row animation:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        [self.delegate segmentView:self didSelectedIndex:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kShowVisibleWidth, self.bounds.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *path = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    [self moveLineToIndexPath:path animation:YES];
}

#pragma mark-
#pragma mark- Private Methods
- (void)moveLineToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
    LLPageCollectionCell *cell = (LLPageCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"index-----%ld",indexPath.row);
    CGRect lineBounds = self.slideLine.bounds;
    lineBounds.size.width = cell.bounds.size.width;
    
    CGPoint lineCenter = self.slideLine.center;
    lineCenter.x = cell.center.x;
   
    if (animation) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.slideLine.bounds = lineBounds;
            self.slideLine.center = lineCenter;
        } completion:nil];
    } else {
        self.slideLine.bounds = lineBounds;
        self.slideLine.center = lineCenter;
    }
}

#pragma mark-
#pragma mark- Getters && Setters

- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation {
    _selectedIndex = selectedIndex;
    NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self moveLineToIndexPath:path animation:YES];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self moveLineToIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] animation:YES];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 4;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
         [_collectionView registerClass:[LLPageCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([LLPageCollectionCell class])];
    }
    return _collectionView;
}

- (UIView *)slideLine{
    if (!_slideLine) {
        _slideLine = [[UIView alloc]init];
        _slideLine.backgroundColor = _selectedColor;
    }
    return _slideLine;
}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
     [self addSubview:self.collectionView];
     [self.collectionView addSubview:self.slideLine];
    
}

@end
