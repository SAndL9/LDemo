//
//  Person.m
//  RunTimeTestDemo
//
//  Created by 张炯 on 16/12/20.
//  Copyright © 2016年 张炯. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person

void runTime(id self,SEL sel){
    NSLog(@"---runtime---%@ %@",self,NSStringFromSelector(sel));
}


+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(runTime)) {
        // 动态添加eat方法
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型)
        class_addMethod(self, @selector(runTime), (IMP)runTime, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (void)exercise{
    NSLog(@"---exercise---");
}

- (void)eat{
    NSLog(@"---eat---");
}

@end
