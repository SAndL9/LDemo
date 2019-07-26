//
//  ViewController.m
//  PerfectVideoEditor
//
//  Created by zangqilong on 14/12/4.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import "ViewController.h"
#import "FXBlurView.h"
#import "FBShimmeringView.h"
#import "PGCardTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isShowAnimation;
}
@property (weak, nonatomic) IBOutlet FBShimmeringView *shimmeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shimmeView.contentView = _titleLabel;
    _shimmeView.shimmering = YES;

    isShowAnimation = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGCardTableViewCell *cell = (PGCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cardCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    
    if (isShowAnimation) {
        PGCardTableViewCell *cardCell = (PGCardTableViewCell *)cell;
        [cardCell startAnimationWithDelay:initialDelay + ((indexPath.row) * stutter)];
        if (indexPath.row == 10) {
            isShowAnimation = NO;
        }
    }
    
   
    
}
@end
