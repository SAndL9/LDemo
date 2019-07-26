//
//  ViewController.m
//  SAButtonDemo
//
//  Created by 李磊 on 6/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "SAViewController.h"
@interface ViewController () <UIPopoverPresentationControllerDelegate>

/**  */
@property (nonatomic, strong) UIButton *button1;

/**  */
@property (nonatomic, strong) UIButton *button2;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(30, 100, 120, 35);

    [_button1 setTitle:@"按钮一" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:_button1];
    [_button1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    _button1.backgroundColor = [UIColor greenColor];

        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.frame = CGRectMake(170, 100, 120, 35);
    [_button2 setTitle:@"按钮二" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:_button2];
    [_button2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    _button2.backgroundColor = [UIColor greenColor];
    

    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterOrdinalStyle];
    NSString *fStr = [numberFormatter stringFromNumber:@1234567905356.24];
    NSLog(@"fStr-------------===%@",fStr);
    
    
    
    self.title = @"Presentation";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"pop" style:UIBarButtonItemStyleDone target:self action:@selector(popView:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
}

- (void)popView:(UIBarButtonItem *)rightBar {
    TableViewController *view = [[TableViewController alloc] init];
    view.preferredContentSize = CGSizeMake(120, 200);//popover视图的大小
    view.modalPresentationStyle = UIModalPresentationPopover;//如果没有这句，pop不会被初始化
    UIPopoverPresentationController *pop = view.popoverPresentationController;
    pop.backgroundColor = [UIColor redColor];
    pop.delegate = self;//设置代理
    pop.permittedArrowDirections = UIPopoverArrowDirectionAny;//弹出的方向
    pop.barButtonItem = self.navigationItem.rightBarButtonItem;//导航栏右侧的按钮
    [self presentViewController:view animated:YES completion:nil];//present即可
    
    
    
    
}
#pragma mark -- UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}


- (void)btn1Click {
    if(_button2.isSelected) {
        _button2.selected = NO;
    }
    
    NSLog(@"选择的是button1");
    
    TableViewController *view = [[TableViewController alloc] init];
    view.preferredContentSize = CGSizeMake(120, 44*5);//popover视图的大小
    view.modalPresentationStyle = UIModalPresentationPopover;//如果没有这句，pop不会被初始化
    view.popoverPresentationController.sourceView = _button1;
    
    view.popoverPresentationController.sourceRect = _button1.bounds;
    
    view.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    view.popoverPresentationController.delegate = self;
    [self presentViewController:view animated:YES completion:nil];
    
    _button1.selected = YES;
}

- (void)btn2Click {
    if(_button1.isSelected) {
        _button1.selected = NO;
       
    }
     NSLog(@"选择的是button2");
    
     SAViewController *view = [[SAViewController alloc] init];
    view.preferredContentSize = CGSizeMake(150, 200);//popover视图的大小
    view.modalPresentationStyle = UIModalPresentationPopover;//如果没有这句，pop不会被初始化
    view.popoverPresentationController.sourceView = _button2;
   
    view.popoverPresentationController.sourceRect = _button2.bounds;
    
    view.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    view.popoverPresentationController.delegate = self;
    [self presentViewController:view animated:YES completion:nil];
    
    _button2.selected = YES;
    
}



- (void)labelSetup{
    UILabel *btnTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 60)];
    btnTitleLabel.backgroundColor = [UIColor grayColor];
    btnTitleLabel.textColor =[UIColor redColor];
    btnTitleLabel.font = [UIFont systemFontOfSize:12];
    btnTitleLabel.numberOfLines = 0;
    btnTitleLabel.text = @"独享价30.0元\n购买后仅供自己观看学习";//使用斜杠一定不要忘记写numberOfLines 否则无效
    btnTitleLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributer = [[NSMutableAttributedString alloc]initWithString:btnTitleLabel.text];
    
    [attributer addAttribute:NSForegroundColorAttributeName
                       value:[UIColor orangeColor]
                       range:NSMakeRange(0, 8)];
    [attributer addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:16]
                       range:NSMakeRange(0, 8)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];//调整行间距
    [paragraphStyle setLineSpacing:4];
    [attributer addAttribute:NSParagraphStyleAttributeName
                       value:paragraphStyle
                       range:NSMakeRange(0, btnTitleLabel.text.length)];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];//为了美观调整行间距，但是当调整行间距时上面设置的居中不能用看 所以要加这一句 [paragraphStyle setAlignment:NSTextAlignmentCenter] 不然没有居中效果
    btnTitleLabel.attributedText = attributer;
    [self.view addSubview:btnTitleLabel];
}

@end
