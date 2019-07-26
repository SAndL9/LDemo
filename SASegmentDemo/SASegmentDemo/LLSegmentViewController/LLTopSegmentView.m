//
//  LLTopSegmentView.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLTopSegmentView.h"
#import "LLSegmentCollectionCell.h"
#import <Masonry/Masonry.h>
#define kRedColor [[UIColor orangeColor] colorWithAlphaComponent:0.99]

@interface LLTopSegmentView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LLTopSegmentView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        [self initialProperty];
    }
    return self;
}

#pragma mark-
#pragma mark -  CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLSegmentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LLSegmentCollectionCell class]) forIndexPath:indexPath];
    cell.isSelectd = (indexPath.row == _selectedSegmentIndex ? YES : NO);
    cell.selectColor = self.titleSelectColor;
    cell.nomalColor = self.titleNormalColor;
    cell.titleLabel.text = [_items objectAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_segmentWidth, 40);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    _selectedSegmentIndex = indexPath.row;
    [collectionView reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSegmentAtIndex:)]) {
        [self.delegate changeSegmentAtIndex:indexPath.row];
    }
}


#pragma mark-
#pragma mark- Event response
- (void)updateView{
    [self.collectionView reloadData];
}


#pragma mark-
#pragma mark- Private Methods
- (void)initialProperty{
    _titleNormalColor = [UIColor blackColor];
    _titleSelectColor = kRedColor;
    _selectedSegmentIndex = 0;
    if (!_segmentWidth) {
        _segmentWidth = 120;
    }
    [self setupSubviewsContraints];
}

#pragma mark-
#pragma mark- Getters && Setters
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0.1;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0,0.1,0,0.1);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LLSegmentCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([LLSegmentCollectionCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self updateView];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor{
    _titleNormalColor = titleNormalColor;
    //[self updateView];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor = titleSelectColor;
    //[self updateView];
}


- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    _selectedSegmentIndex = selectedSegmentIndex;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathWithIndex:_selectedSegmentIndex] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self updateView];
}

- (void)topSegmentSelectIndex:(NSInteger)index{
    self.selectedSegmentIndex = index;
}

- (void)setSegmentWidth:(CGFloat)segmentWidth{
    _segmentWidth = segmentWidth;
//    [self updateView];
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.collectionView.backgroundColor =  [UIColor whiteColor];
    self.backgroundColor = self.backgroundColor;
}


@end
