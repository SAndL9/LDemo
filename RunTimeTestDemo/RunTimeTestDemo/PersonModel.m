//
//  PersonModel.m
//  ZJKeepDevelop
//
//  Created by 张炯 on 16/12/16.
//  Copyright © 2016年 Kedll. All rights reserved.
//

#import "PersonModel.h"
#import <objc/runtime.h>
@implementation PersonModel

//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"_name"];
//        self.age = [aDecoder decodeObjectForKey:@"_age"];
//        self.sex = [aDecoder decodeObjectForKey:@"_sex"];
//        self.phoneNumber = [aDecoder decodeObjectForKey:@"_phoneNumber"];
//        self.ID = [aDecoder decodeObjectForKey:@"_ID"];
//    }
//    return self;
//}
//
//
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:_name forKey:@"_name"];
//    [aCoder encodeObject:_age forKey:@"_age"];
//    [aCoder encodeObject:_sex forKey:@"_sex"];
//    [aCoder encodeObject:_phoneNumber forKey:@"_phoneNumber"];
//    [aCoder encodeObject:_ID forKey:@"_ID"];
//}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
            
        }
        free(ivars);
    } 
    return self;
}

@end
