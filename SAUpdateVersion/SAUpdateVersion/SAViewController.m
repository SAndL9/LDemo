//
//  SAViewController.m
//  SAUpdateVersion
//
//  Created by 李磊 on 13/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()
/**  */
@property (nonatomic, copy) NSString *str;
@end

@implementation SAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"str-------%@",self.str);
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
