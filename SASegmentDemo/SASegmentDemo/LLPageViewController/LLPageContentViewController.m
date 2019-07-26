//
//  LLPageContentViewController.m
//  SASegmentDemo
//
//  Created by LiLei on 12/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLPageContentViewController.h"
#import <Masonry/Masonry.h>
#import "LLPageView.h"

static NSInteger const pageViewHeight = 45;

@interface LLPageContentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LLPageViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LLPageView *pageView;
@end

@implementation LLPageContentViewController

#pragma mark-
#pragma mark- View Life Cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupSubviewsContraints];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.collectionView];
    self.pageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, pageViewHeight);
    self.collectionView.frame = CGRectMake(0, pageViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - pageViewHeight);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
#pragma mark-
#pragma mark- 代理类名 delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    [self.pageView setSelectedIndex:index animation:YES];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
 
}

#pragma mark-
#pragma mark- Event response
//-(void)selectIndex:(NSInteger)index{
//    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//}


#pragma mark-
#pragma mark- UICollectionViewDelegate&&UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numbersOfPageInPageViewController:)]) {
        return [self.dataSource numbersOfPageInPageViewController:self];
    }else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewController:childViewControllerAtIndex:)]) {
        UIViewController *vc = [self.dataSource pageViewController:self childViewControllerAtIndex:indexPath.row];
        vc.view.frame = cell.bounds;
        [self addChildViewController:vc];
        [cell.contentView addSubview:vc.view];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - pageViewHeight);
}

#pragma mark-
#pragma mark- LLPageViewDelegate
- (void)segmentView:(LLPageView *)view didSelectedIndex:(NSInteger)index {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)numbersOfPageInPageView:(LLPageView *)view{
    return [self.dataSource numbersOfPageInPageViewController:self];
}

- (NSString *)pageView:(LLPageView *)pageView itemTitleIndex:(NSInteger)index{
    return [self.dataSource pageViewController:self titleAtIndex:index];
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

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    self.pageView.selectedIndex = selectedIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
}

- (LLPageView *)pageView{
    if (!_pageView) {
        _pageView = [[LLPageView alloc]init];
        _pageView.delegate = self;
    }
    return _pageView;
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
