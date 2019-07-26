//
//  ViewController.m
//  RunTimeTestDemo
//
//  Created by 张炯 on 16/12/20.
//  Copyright © 2016年 张炯. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
#import "UIView+RunTime.h"
#import "UIImage+ReplaceMethod.h"
#import "UIViewController+replaceMethod.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *selectPropertyButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPrivateButton;
@property (weak, nonatomic) IBOutlet UIButton *selectMethodButton;
@property (weak, nonatomic) IBOutlet UIButton *useHaveKnownPropertyButton;
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
@property (weak, nonatomic) IBOutlet UIButton *dynamicAddMethodButton;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
@property (weak, nonatomic) IBOutlet UIButton *eatButton;
@property (weak, nonatomic) IBOutlet UIButton *changeSystemMethodButton;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    objc_msgSend(tableView, @selector(cellForRowAtIndexPath:),indexPath);
    
    Method m1 = class_getInstanceMethod([Person class], @selector(exercise));
    Method m2 = class_getInstanceMethod([Person class], @selector(eat));
    method_exchangeImplementations(m1, m2);
    
//    Method m1 = class_getInstanceMethod([Person class], @selector(sayName));
//    Method m2 = class_getInstanceMethod([Tool class], @selector(changeMethod));
//    
//    method_exchangeImplementations(m1, m2);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}

/**
 1.RunTime简称运行时,就是系统在运行的时候的一些机制，其中最主要的是消息机制。
 2.对于C语言，函数的调用在编译的时候会决定调用哪个函数，编译完成之后直接顺序执行，无任何二义性。
 3.OC的函数调用成为消息发送。属于动态调用过程。在编译的时候并不能决定真正调用哪个函数（事实证明，在编 译阶段，OC可以调用任何函数，即使这个函数并未实现，只要申明过就不会报错。而C语言在编译阶段就会报错）。
 4.只有在真正运行的时候才会根据函数的名称找到对应的函数来调用。
 */


- (IBAction)pressSelectPropertyButtonAction:(UIButton *)sender {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertiesName = property_getName(properties[i]);
        NSString *str = [NSString stringWithCString:propertiesName encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
    }
}

- (IBAction)pressSelectPrivateButtonAction:(UIButton *)sender {
    typedef struct objc_ivar *Ivar;
    unsigned int count;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *str = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivarName : %@", str);
    }
}

- (IBAction)pressSelectMethodButtonAction:(UIButton *)sender {
    unsigned count = 0;
    // 获取所有方法
    Method *methods = class_copyMethodList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        // 方法类型是SEL选择器类型
        SEL methodName = method_getName(method);
        NSString *str = [NSString stringWithCString:sel_getName(methodName) encoding:NSUTF8StringEncoding];
        
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"methodName : %@, arguments Count: %d", str, arguments);
    }
}

- (IBAction)useHaveKnownPropertyButtonAction:(id)sender {
    [_testTextField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (IBAction)pressDynamicAddMethodButtonAction:(UIButton *)sender {
    Person *michael = [[Person alloc] init];
    [michael performSelector:@selector(runTime) withObject:nil];
}

- (IBAction)pressRunButtonAction:(id)sender {
    Person *michael = [[Person alloc] init];
    [michael exercise];
}

- (IBAction)pressEatButtonAction:(UIButton *)sender {
    Person *michael = [[Person alloc] init];
    [michael eat];
}

- (IBAction)pressChangeSystemMethodAction:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"tangyan"];
    _testImageView.image= image;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
