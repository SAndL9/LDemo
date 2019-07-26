//
//  Person.m
//  RunloopAndRuntime
//
//  Created by lanouhn on 16/6/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic,strong) NSString *address;

@end

@implementation Person

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _address = @"威科姆B座";
        self.name = @"蓝鸥科技";
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"address:%@,name:%@",self.address,self.name];
}

- (void)sayHello
{
    NSLog(@"hello,I'm at %@",self.address);
}

- (void)interface
{
    NSLog(@"I'm %@",self.name);
}

@end
