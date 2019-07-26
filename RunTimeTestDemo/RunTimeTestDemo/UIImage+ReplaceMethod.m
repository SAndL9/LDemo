//
//  UIImage+ReplaceMethod.m
//  RunTimeTestDemo
//
//  Created by 张炯 on 16/12/20.
//  Copyright © 2016年 张炯. All rights reserved.
//

#import "UIImage+ReplaceMethod.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation UIImage (ReplaceMethod)

//https://allluckly.cn/runtime/runtime

//+(void)load{
////    SEL oriSelector = @selector(imageNamed:);
////    SEL swiSelctor = @selector(sa_imageNamed:);
////    
////    Method oriMethod = class_getInstanceMethod(self, oriSelector);
////    Method swiMethod = class_getInstanceMethod(self, swiSelctor);
////    method_exchangeImplementations(oriMethod, swiMethod);
//    
//    
//    Method m1 = class_getClassMethod([self class], @selector(imageNamed:));
//    Method m2 = class_getClassMethod([self class], @selector(sa_imageNamed:));
//    method_exchangeImplementations(m1, m2);
//}
//
//+ (UIImage *)sa_imageNamed:(NSString *)nameString{
//    NSLog(@"-----UIimage(sa_imageNamed:)-----");
//    UIImage *image;
//    image = [UIImage sa_imageNamed:[nameString stringByAppendingString:@"123"]];
//    return image;
//}

@end
