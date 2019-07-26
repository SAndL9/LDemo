//
//
//  ViewController.h
//  SABluetoothLibrary
//
//  Created by LiLei on 7/12/17.
//  Copyright © 2017年 李磊. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SAElectronicScaleResultDataModel.h"
/**
 *  手机蓝牙的状态
 */
typedef NS_ENUM(NSInteger, SACentralManagerState) {
    /**
     * 从未读取状态，初始化时
     */
    SACentralManagerStateNever,
    /**
     *  蓝牙处于打开
     */
    SACentralManagerStateOpen,
    /**
     *  蓝牙处于关闭
     */
    SACentralManagerStateClose,
    /**
     *  不支持蓝牙操作
     */
    SACentralManagerStateUnsupported,
};

/**
 *  外围设备的连接状态
 */
typedef NS_ENUM(NSInteger, SAPeripheralConnectionState) {
    /**
     *  外围设备已经被发现
     */
    SAPeripheralConnectionStateDidDiscoverd = 0,
    /**
     *  外围设备已经绑定成功
     */
    SAPeripheralConnectionStateDidBunded,
    /**
     *  外围设备经绑定失败
     */
    SAPeripheralConnectionStateBundingFailed,
    /**
     *  外围设备将要解绑
     */
    SAPeripheralConnectionStateWillUnbunding,
    /**
     *  外围设备已经失去连接
     */
    SAPeripheralConnectionStateDidDisconnect,
};

@interface SAPeripheral : NSObject

/**
 *  单例出一个管理蓝牙对象
 *
 *  @return 管理蓝牙对象
 */
+ (instancetype)sharePeripheralInstance;

/**
 *  手机蓝牙状态
 */
@property (nonatomic, assign) SACentralManagerState state;

@property (nonatomic, assign) BOOL isScanConnect;

/**
 *  手机app是否已绑定外围设备
 */
@property (nonatomic, assign) BOOL isBinding;

/** 是否能够扫入*/
@property (nonatomic,assign) BOOL isScanAvailable;

/** 电子秤的mac地址 */
@property (nonatomic, copy) NSString *electronicWeigherScanMacCode;

/**
 *  打开蓝牙扫描
 */
- (void)openCentralManagerScan;

/**
 *  关闭蓝牙扫描
 */
- (void)closeCentralManagerScan;

/**
 *  解除与外围设备的连接
 */
- (void)unbindlingPeripheral;

/**
 *  清楚蓝牙配置，会解除与外围设备的连接
 */
- (void)cleanPeripheralConfiguration;

/**
 *  检测手机蓝牙状态发生变化
 *
 *  @param updateBlock 手机蓝牙状态发生变化的block
 */
- (void)setCentralManagerDidUpdateBlock:(void(^)(SACentralManagerState state))updateBlock;

/**检测外围设备连接状态变化*/
- (void)setPeripheralConnectionStateDidUpdateBlock:(void(^)(SAPeripheralConnectionState state))updateBlock;

/** 返回电子秤的结果 */
- (void)setElectronicScaleResultDataBlock:(void(^)(SAElectronicScaleResultDataModel *dataModel))dataModelBlock;

@end
