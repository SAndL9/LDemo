//
//  ViewController.m
//  PTXDatePickerView
//
//  Created by pantianxiang on 17/1/12.
//  Copyright © 2017年 pantianxiang. All rights reserved.
//

#import "ViewController.h"
#import "PTXDatePickerView/PTXDatePickerView.h"

#define PTXScreenWidth [[UIScreen mainScreen] bounds].size.width
#define PTXScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <PTXDatePickerViewDelegate>

@property (nonatomic, strong) PTXDatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;


@property (nonatomic, strong) NSDate *selectedDate; //代表dateButton上显示的时间。

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [_dateButton setShowsTouchWhenHighlighted:YES];

    
//    [self performSelector:@selector(hide) withObject:nil afterDelay:5];
}

-(void)hide{
    [_datePickerView hideViewWithAnimation:YES]; //测试方法。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PTXDatePickerViewDelegate
- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date {
    self.selectedDate = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [_dateButton setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
    
    //释放
//    [_datePickerView removeFromSuperview];
//    self.datePickerView = nil;
}

#pragma mark - Button Action

- (IBAction)selectDate:(id)sender {
    if (!_datePickerView) {
        _datePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, PTXScreenHeight, PTXScreenWidth, 246.0)];
        _datePickerView.delegate = self;
        _datePickerView.minYear = 2000;
        
        [self.view addSubview:_datePickerView];
    }
    
    [_datePickerView showViewWithDate:_selectedDate animation:YES];
}

@end
