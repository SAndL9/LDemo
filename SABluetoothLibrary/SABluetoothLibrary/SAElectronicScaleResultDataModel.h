//
//  ViewController.h
//  SABluetoothLibrary
//
//  Created by LiLei on 7/12/17.
//  Copyright © 2017年 李磊. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, SAWorkState) {
    SAStableState      = 0,  /**稳定*/
    SAOverflowState    = 1 << 0, /**溢出*/
    SAInstabilityState = 1 << 1 /**不稳定*/
};


@interface SAElectronicScaleResultDataModel : NSObject

/** 稳定溢出不稳定状态 */
@property (nonatomic, assign) SAWorkState workState;

/** 是否去皮 NO 净重  YES */
@property (nonatomic, assign) BOOL isPeelingSuttleWeight;

/** 重量 <保留3位小数>*/
@property (nonatomic, copy) NSString *weightValueStr;

/** 单位 g kg lb */
@property (nonatomic, copy) NSString *unitStr;

/** 重量<保留3位小数> + 单位<g kg lb> */
@property (nonatomic, copy) NSString *weightUnitStr;

@end
