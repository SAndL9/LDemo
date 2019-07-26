//
//  SAToolManager.m
//  SAUpdateVersion
//
//  Created by 李磊 on 21/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "SAToolManager.h"

static SAToolManager *saToolMagager;


@implementation SAToolManager



+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saToolMagager  = [super allocWithZone:zone];
    });
    return saToolMagager;
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saToolMagager = [[SAToolManager alloc]init];
    });
    return saToolMagager;
}


-(id)copyWithZone:(NSZone *)zone{
    return saToolMagager;
}


@end
