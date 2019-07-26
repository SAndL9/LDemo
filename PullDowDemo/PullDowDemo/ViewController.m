//
//  ViewController.m
//  PullDowDemo
//
//  Created by zhangmeng on 16/6/3.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#define size_width   [UIScreen mainScreen].bounds.size.width
#define size_height  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *backView; //展示筛选界面
@property (assign, nonatomic) BOOL flag; //标识筛选视图是否出现，YES出现
@end

@implementation ViewController
//创建弹出的视图
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size_width, size_height)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        //创建3个button
        for (int i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame = CGRectMake(0, 40*i, size_width, 40);
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            button.layer.borderWidth = 0.5;
            button.backgroundColor = [UIColor whiteColor];
            button.layer.borderColor = [UIColor darkGrayColor].CGColor;
            [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [button setTag:100+i];
            switch (i) {
                case 0:
                    [button setTitle:@"全部" forState:(UIControlStateNormal)];
                    break;
                case 1:
                    [button setTitle:@"男" forState:(UIControlStateNormal)];
                    break;
                case 2:
                    [button setTitle:@"女" forState:(UIControlStateNormal)];
                    break;
                default:
                    break;
            }
            [_backView addSubview:button];
            [self.view addSubview:_backView];
        }
    }
    return _backView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    //设置tableView的HeaderView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size_width, 120)];
    headerView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = headerView;
    self.flag = NO;
}
#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    return [self setupSectionHeaderView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
#pragma mark - 点击Button响应方法
- (void)handleButtonAction:(UIButton *)sender {
    NSString *titleStr;
    switch (sender.tag) {
        case 100:
            NSLog(@"全部");
            titleStr = @"全部";
            break;
        case 101:
            NSLog(@"男");
            titleStr = @"男";
            break;
        case 102:
            NSLog(@"女");
            titleStr = @"女";
            break;
        default:
            break;
    }
    [self returnTheBackView]; //回收视图
    //更新HeaderSection上Button的显示
    UIButton *selectButton = [self.view viewWithTag:888];
    [selectButton setTitle:titleStr forState:(UIControlStateNormal)];
    self.flag  = NO;
}
#pragma mark - 添加SectionHeaderView
- (UIView *)setupSectionHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,size_width, 40)];
    headerView.backgroundColor = [UIColor redColor];
    UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [selectButton setTitle:@"全部" forState:(UIControlStateNormal)];
    [selectButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    selectButton.frame  = CGRectMake(headerView.frame.size.width - 120, 5, 100, 30);
    [selectButton addTarget:self action:@selector(clickedTheSelectButton:) forControlEvents:(UIControlEventTouchUpInside)];
    selectButton.layer.masksToBounds = YES;
    selectButton.layer.borderColor = [UIColor whiteColor].CGColor;
    selectButton.layer.borderWidth = 2;
    selectButton.tag = 888;
    [headerView addSubview:selectButton];
    return headerView;
}
//点击筛选按钮
- (void)clickedTheSelectButton:(UIButton *)sender {
    //获得头视图在当前tableView中的位置
    CGRect rectInTableView = [self.tableView rectForHeaderInSection:0];
//     NSLog(@"111111111x=%f,y=%f,width=%f,height=%f",rectInTableView.origin.x,rectInTableView.origin.y,rectInTableView.size.width,rectInTableView.size.height);
   //转化左边系统为tableView的父视图
    CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    //判断当rectInSuperview.origin.y<=20时，这时sectionHeader悬停，不再取相对位置
    if (rectInSuperview.origin.y<=20) {
        rectInSuperview = CGRectMake(rectInSuperview.origin.x, 20, rectInSuperview.size.width, rectInSuperview.size.height);
    }
//     NSLog(@"222222222x=%f,y=%f,width=%f,height=%f",rectInSuperview.origin.x,rectInSuperview.origin.y,rectInSuperview.size.width,rectInSuperview.size.height);

    if (!self.flag) {
        //设置backView的frame
        self.backView.frame = CGRectMake(0, rectInSuperview.origin.y + rectInSuperview.size.height, self.backView.frame.size.width, 0);
        //弹出视图
        [UIView animateWithDuration:0.2 animations:^{
            self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, size_width, size_height);
        }];
    }else {
        //收回视图
        [self returnTheBackView];
    }
    self.flag = !self.flag;
}
//收回筛选视图方法
- (void)returnTheBackView {
    for (UIButton *button in self.backView.subviews) {
        [button removeFromSuperview];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, size_width, 0);
    }];
    self.backView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
