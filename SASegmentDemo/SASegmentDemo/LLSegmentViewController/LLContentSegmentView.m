//
//  LLContentSegmentView.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLContentSegmentView.h"
#import <Masonry/Masonry.h>
@interface LLContentSegmentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LLContentSegmentView

#pragma mark-
#pragma mark- View Life Cycle


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsContraints];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray <UIViewController *>*)contentArray{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = (NSMutableArray *)contentArray;
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- <#代理类名#> delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(contentScrollViewToIndex:)]) {
        int index = scrollView.contentOffset.x / self.frame.size.width;
        [self.delegate contentScrollViewToIndex:index];
    }
    
}

#pragma mark-
#pragma mark- Event response
-(void)selectIndex:(NSInteger)index{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically|UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    UIViewController *vc = [_dataArray objectAtIndex:indexPath.row];
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

#pragma mark-
#pragma mark- Private Methods


#pragma mark-
#pragma mark- Getters && Setters
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0.1;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0,0.1,0,0.1);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delaysContentTouches = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)setDataArray:(NSMutableArray<UIViewController *> *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
