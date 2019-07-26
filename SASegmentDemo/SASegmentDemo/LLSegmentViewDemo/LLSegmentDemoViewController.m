//
//  LLSegmentDemoViewController.m
//  SASegmentDemo
//
//  Created by LiLei on 11/7/18.
//  Copyright © 2018年 李磊. All rights reserved.
//

#import "LLSegmentDemoViewController.h"
#import "LLTopSegmentView.h"
#import "LLContentSegmentView.h"
#import <Masonry/Masonry.h>
#import "LLRedViewController.h"
#import "LLBlueViewController.h"
#import "LLOrangeViewController.h"
#import "LLGreenViewController.h"
@interface LLSegmentDemoViewController ()<LLTopSegmentViewDelegate,LLContentSegmentViewDelegate>

@property (nonatomic, strong) LLTopSegmentView *topSegmentView;
@property (nonatomic, strong) LLContentSegmentView *contentSegmentView;
@end

@implementation LLSegmentDemoViewController

#pragma mark-
#pragma mark- View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubviewsContraints];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _topSegmentView.selectedSegmentIndex = 2;
//        _topSegmentView.items = @[@"秒1",@"分2",@"刻3",@"时4",];//@"天5",@"周6",@"月7",@"年8"
//    });
}

#pragma mark-
#pragma mark- Request


#pragma mark-
#pragma mark- SANetworkResponseProtocol


#pragma mark-
#pragma mark- LLTopSegmentViewDelegate delegate

- (void)changeSegmentAtIndex:(NSInteger)segIndex{
    NSLog(@"changeSegmentAtIndex----%ld",(long)segIndex);
    [self.contentSegmentView selectIndex:segIndex];
}

- (void)contentScrollViewToIndex:(NSInteger)index{
    [self.topSegmentView topSegmentSelectIndex:index];
    NSLog(@"contentScrollViewToIndex----%ld",(long)index);
}
#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters
- (LLTopSegmentView *)topSegmentView{
    if (!_topSegmentView) {
        _topSegmentView = [[LLTopSegmentView alloc]init];
        _topSegmentView.segmentWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 4;
        _topSegmentView.items = @[@"秒",@"分",@"刻",@"时",@"天",@"周",@"月",@"年"];//
        _topSegmentView.delegate = self;
    }
    return _topSegmentView;
}

- (LLContentSegmentView *)contentSegmentView{
    if (!_contentSegmentView) {
        _contentSegmentView = [[LLContentSegmentView alloc]init];
        LLRedViewController *vc = [[LLRedViewController alloc]init];
        LLBlueViewController *vc1 = [[LLBlueViewController alloc]init];
        LLOrangeViewController *vc2 = [[LLOrangeViewController alloc]init];
        LLGreenViewController *vc3 = [[LLGreenViewController alloc]init];
        LLRedViewController *vc4 = [[LLRedViewController alloc]init];
        LLBlueViewController *vc5 = [[LLBlueViewController alloc]init];
        LLOrangeViewController *vc6 = [[LLOrangeViewController alloc]init];
        LLGreenViewController *vc7 = [[LLGreenViewController alloc]init];
        _contentSegmentView.dataArray = @[vc,vc1,vc2,vc3,vc4,vc5,vc6,vc7].mutableCopy;
        _contentSegmentView.delegate = self;
    }
    return _contentSegmentView;
}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.view addSubview:self.topSegmentView];
    [self.view addSubview:self.contentSegmentView];
    [self.topSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(45);
    }];
    [self.contentSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(-0);
        make.top.equalTo(self.topSegmentView.mas_bottom).offset(2);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
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
