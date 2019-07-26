//
//  UIViewController+replaceMethod.m
//  RunTimeTestDemo
//
//  Created by 张炯 on 16/12/20.
//  Copyright © 2016年 张炯. All rights reserved.
//

#import "UIViewController+replaceMethod.h"
#import <objc/runtime.h>

@implementation UIViewController (replaceMethod)

+(void)load{
    //只需要运行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //交换viewWillAppear: 和 glt_viewWillAppear: 方法
        SEL oriSelector = @selector(viewWillAppear:);
        SEL swiSelctor = @selector(glt_viewWillAppear:);
        
        //注意：导入头文件 #import <objc/message.h>
        Method oriMethod = class_getInstanceMethod(class, oriSelector);
        Method swiMethod = class_getInstanceMethod(class, swiSelctor);
        
        BOOL success = class_addMethod(class, oriSelector, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        
        if (success) {
            class_replaceMethod(class, swiSelctor, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
            method_exchangeImplementations(oriMethod, swiMethod);
        }
    });
}

#pragma mark - 替换后的子类viewWillAppear
-(void)glt_viewWillAppear:(BOOL)animated{
    [self glt_viewWillAppear:animated];
    NSLog(@"-----UIimage(sa_imageNamed:)-----");
}

@end
