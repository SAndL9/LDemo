//
//  PersonModel.h
//  ZJKeepDevelop
//
//  Created by 张炯 on 16/12/16.
//  Copyright © 2016年 Kedll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *age;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *phoneNumber;
@property(nonatomic,copy) NSString *ID;

@end
