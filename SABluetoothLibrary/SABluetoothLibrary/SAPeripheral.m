//
//  ViewController.h
//  SABluetoothLibrary
//
//  Created by LiLei on 7/12/17.
//  Copyright © 2017年 李磊. All rights reserved.
//


#import "SAPeripheral.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "SAElectronicScaleResultDataModel.h"
#define kServiceUUID @"FFE0" //电子秤服务的UUID FFE0  指环 FFF0
//#define KRename @"11223"

typedef void (^CentralManagerDidUpdateBlock)(SACentralManagerState state);
typedef void (^ReturnElectronicScaleDataModelBlock)(SAElectronicScaleResultDataModel *dataModel);
typedef void(^PeripheralConnectionStateBlock)(SAPeripheralConnectionState state);
@interface SAPeripheral()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong, getter=getCentralManager) CBCentralManager *centralManager;
@property (nonatomic, copy) CentralManagerDidUpdateBlock updateBlock;
@property (nonatomic, copy) ReturnElectronicScaleDataModelBlock dataModelBlock;
@property (nonatomic, copy) PeripheralConnectionStateBlock connectionStateBlock;
@property (nonatomic, strong) NSMutableArray *peripheralDeviceArray;

@property (nonatomic, strong) CBPeripheral *tempPeripheral;

@end

@implementation SAPeripheral

+ (instancetype)sharePeripheralInstance{
    static SAPeripheral * _peripheralInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _peripheralInstance = [[SAPeripheral alloc] init];
        _peripheralInstance.state = SACentralManagerStateClose;
        [_peripheralInstance getCentralManager];
        _peripheralInstance.isScanAvailable = YES;
        _peripheralInstance.isScanConnect = YES;

    });
    return _peripheralInstance;
}

#pragma mark-
#pragma mark-CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state==CBCentralManagerStatePoweredOn) {
        self.state=SACentralManagerStateOpen;
        [self openCentralManagerScan];
        
    }else if (central.state==CBCentralManagerStatePoweredOff){
        self.state=SACentralManagerStateClose;

        [self cleanParameterForDisconnect];
    }else{
        self.state=SACentralManagerStateUnsupported;
        [self cleanParameterForDisconnect];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.updateBlock) {
            self.updateBlock(self.state);
        }
    });
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
 
    NSLog(@"advertisementData : %@  \nRSSI::: %@---Name:--%@",advertisementData,RSSI,peripheral.name);
 
    //[peripheral.name isEqualToString:@"LINKALL"]
//    if ([peripheral.name containsString:@"MI Band 2"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [central stopScan];
//                self.tempPeripheral = peripheral;
//                self.tempPeripheral.delegate = self;
//                [self.centralManager connectPeripheral:self.tempPeripheral options:nil];
//            });
//    }
//        if (![self.peripheralDeviceArray containsObject:peripheral]) {
//        self.tempPeripheral = peripheral;
//                NSLog(@"advertisementData : %@  \nRSSI::: %@",advertisementData,RSSI);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [central stopScan];
//                self.tempPeripheral.delegate = self;
//                [self.centralManager connectPeripheral:self.tempPeripheral options:nil];
//            });
//     
//                
//            }
    
   
    NSString *macCode = [NSString stringWithFormat:@"%@", [[advertisementData[@"kCBAdvDataServiceUUIDs"] firstObject] UUIDString] ? : @""];
    NSLog(@"mac---------%@",macCode);
    if (macCode.length == 36) {
        macCode = [macCode substringFromIndex:macCode.length - 12];
        NSLog(@"电子秤的mac地址---%@-----扫描的mac地址---%@",macCode,_electronicWeigherScanMacCode);
    }
    
    if ([macCode isEqualToString:_electronicWeigherScanMacCode]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [central stopScan];
            self.tempPeripheral = peripheral;
            self.tempPeripheral.delegate = self;
            [self.centralManager connectPeripheral:self.tempPeripheral options:nil];
        });
    }
    
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"已连接");
//    if ([peripheral.name isEqualToString:KRename]) {
//        NSLog(@"已连接");

//    [central stopScan];
//    }else{
//        [central cancelPeripheralConnection:peripheral];
//    }
    [central stopScan];
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接扫码仪失败 ---->>%@---%@",peripheral,error);
    [self cleanParameterForDisconnect];
}

// 已连接后丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"%s, line = %d, %@=断开连接", __FUNCTION__, __LINE__, peripheral.name);
}

#pragma mark-
#pragma mark-  CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral.services enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [peripheral discoverCharacteristics:nil forService:(CBService *)obj];
    }];
}

// 发现外设服务里的特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    [service.characteristics enumerateObjectsUsingBlock:^(CBCharacteristic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [peripheral setNotifyValue:YES forCharacteristic:obj];
    }];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSString *string = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"string===%@",string);
    
    if (self.dataModelBlock && string.length == 18) {
        self.dataModelBlock([self returnElectronicScakeResultDataSting:string]);
    }
   
}



#pragma mark-
#pragma mark-  private

- (void)openCentralManagerScan{
    if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
        //@[[CBUUID UUIDWithString:kServiceUUID]]
        [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    }
}

- (void)closeCentralManagerScan{
    if (_centralManager) {
        [self.centralManager stopScan];
    }
}

- (void)cleanParameterForDisconnect{
    self.isBinding = NO;
 
    self.electronicWeigherScanMacCode = nil;
}

- (void)unbindlingPeripheral{
    
}

- (void)cleanPeripheralConfiguration{
    
}

/** 返回电子秤传回数据 */
- (SAElectronicScaleResultDataModel *)returnElectronicScakeResultDataSting:(NSString *)string{
    if (string.length < 16) {
        return nil;
    }
    /** 读出串口数据为十八个字节
     1-2：为状态字,OL溢出，ST稳定，US不稳定；
     3：NULL
     4-5：去皮或净重   去皮，TR；净重，NT.
     6：NULL
     7-14：为重量值                        空格/－　数据　　单位符号
     15-16:为重量单位  kg , g , lb              1位　　 7位　　　2位
     17：CR  回车
     18：LF  换行 */
     SAElectronicScaleResultDataModel *model = [[SAElectronicScaleResultDataModel alloc]init];
    NSString * stateString = [string substringWithRange:NSMakeRange(0, 2)];
    NSString *isPeelingSuttleStr = [string substringWithRange:NSMakeRange(3, 2)];
    NSString * weightValueStr= [NSString stringWithFormat:@"%.3f",[[string substringWithRange:NSMakeRange(6, 8)] floatValue]];
    NSString * unitStr = [[string substringWithRange:NSMakeRange(14, 2)] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([stateString isEqualToString:@"ST"]) {
        model.workState = SAStableState;
        NSLog(@"稳定质量");
    }else if ([stateString isEqualToString:@"US"]){
        model.workState = SAInstabilityState;
        NSLog(@"不稳定质量");
    }else{
        model.workState = SAOverflowState;
        NSLog(@"溢出数据");
    }
    
    if ([isPeelingSuttleStr isEqualToString:@"TR"]) {
        model.isPeelingSuttleWeight = NO;
        NSLog(@"去皮数据");
    }else{
        model.isPeelingSuttleWeight = YES;
        NSLog(@"净重数据");
    }
    
    model.weightUnitStr = [NSString stringWithFormat:@"%@%@",weightValueStr,unitStr];
    model.unitStr = unitStr;
    model.weightValueStr = weightValueStr;
    NSLog(@"电子秤的---%lu--%d----%@---%@---%@---",(unsigned long)model.workState,model.isPeelingSuttleWeight,model.weightValueStr,model.unitStr,model.weightUnitStr);
    return model;
}


/**解析电子秤传回的数据*/
//- (SAElectronicScaleDataModel *)parsingElectronicScaleDataWithData:(NSData *)data{
//
//    NSString *hexadecimalString = [self convertDataToHexStr:data];
//    if (hexadecimalString.length != 12) return nil;
//    /**hexadecimalString前两位为起始位不管 34位为各类设置位需转换成二进制 5-10重量数值数 1112为单位*/
//
//    /**settingString代表设置的二进制字符串
//     5-7位代表小数点位置 都为三位不用管
//     3-4位工作模式 00 - 计重模式；01 - 计数模式；10 - 百分比模式
//     2位 1表示重量为负，0表示重量为正
//     1位 1表示重量稳定，0表示重量不稳定
//     0位 1表示重量溢出，0表示重量未溢出*/
//    NSString *settingString = [self getBinaryByhex:[hexadecimalString substringWithRange:NSMakeRange(2, 2)]];
//    if (settingString.length != 8) return nil;
//    SAElectronicScaleDataModel *model = [[SAElectronicScaleDataModel alloc] init];
//    NSString *workStateString = [settingString substringWithRange:NSMakeRange(3, 2)];
//    if ([workStateString isEqualToString:@"00"]) {
//        model.workPatternState = SAWeightPatternState;
//    }else if ([workStateString isEqualToString:@"01"]){
//        model.workPatternState = SACountPatternState;
//    }else{
//        model.workPatternState = SAPercentagePatternState;
//    }
//    model.isPositiveNumber = [[settingString substringWithRange:NSMakeRange(2, 1)] intValue] == 0 ? YES : NO;
//    model.isWeightStabilize = [[settingString substringWithRange:NSMakeRange(1, 1)] intValue] == 0 ? NO : YES;
//    model.isWeightOverflow = [[settingString substringWithRange:NSMakeRange(0, 1)] intValue] == 0 ? NO : YES;
//    NSString *weightString = [NSString stringWithFormat:@"%@%@%@",[hexadecimalString substringWithRange:NSMakeRange(8, 2)],[hexadecimalString substringWithRange:NSMakeRange(6, 2)],[hexadecimalString substringWithRange:NSMakeRange(4, 2)]];
//    float weight = [weightString floatValue] / 1000.000;
//    if (!model.isPositiveNumber) {
//        weight = -weight;
//    }
//    model.weight = [NSString stringWithFormat:@"%.3f",weight];
//    model.isUnitKg = [[hexadecimalString substringWithRange:NSMakeRange(10, 2)] intValue] == 0 ? YES : NO;
//    NSLog(@"重量为:%@  是否稳定:%d  单位是:%d  工作模式:%lu  是否为正数:%d",model.weight,model.isWeightStabilize,model.isUnitKg,(unsigned long)model.workPatternState,model.isPositiveNumber);
//    return model;
//}
//
///**data转化成16进制字符串*/
//- (NSString *)convertDataToHexStr:(NSData *)data {
//    if (!data || [data length] == 0) {
//        return @"";
//    }
//    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
//
//    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
//        unsigned char *dataBytes = (unsigned char*)bytes;
//        for (NSInteger i = 0; i < byteRange.length; i++) {
//            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
//            if ([hexStr length] == 2) {
//                [string appendString:hexStr];
//            } else {
//                [string appendFormat:@"0%@", hexStr];
//            }
//        }
//    }];
//    return string;
//}
//
///**16进制字符串转化为二进制字符串*/
//
//- (NSString *)getBinaryByhex:(NSString *)hex
//{
//    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
//    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
//    [hexDic setObject:@"0000" forKey:@"0"];
//    [hexDic setObject:@"0001" forKey:@"1"];
//    [hexDic setObject:@"0010" forKey:@"2"];
//    [hexDic setObject:@"0011" forKey:@"3"];
//    [hexDic setObject:@"0100" forKey:@"4"];
//    [hexDic setObject:@"0101" forKey:@"5"];
//    [hexDic setObject:@"0110" forKey:@"6"];
//    [hexDic setObject:@"0111" forKey:@"7"];
//    [hexDic setObject:@"1000" forKey:@"8"];
//    [hexDic setObject:@"1001" forKey:@"9"];
//    [hexDic setObject:@"1010" forKey:@"A"];
//    [hexDic setObject:@"1011" forKey:@"B"];
//    [hexDic setObject:@"1100" forKey:@"C"];
//    [hexDic setObject:@"1101" forKey:@"D"];
//    [hexDic setObject:@"1110" forKey:@"E"];
//    [hexDic setObject:@"1111" forKey:@"F"];
//
//    NSString *binaryString=[[NSString alloc] init];
//    for (int i=0; i<[hex length]; i++) {
//        NSRange rage;
//        rage.length = 1;
//        rage.location = i;
//        NSString *key = [hex substringWithRange:rage];
//        NSString *upKsy = [key uppercaseString];
//        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:upKsy]]];
//    }
//    return binaryString;
//}

#pragma mark-
#pragma mark-  setter and getter method
- (CBCentralManager *)getCentralManager{
    if (!_centralManager) {
        _centralManager=[[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

- (NSMutableArray *)peripheralDeviceArray{
    if (!_peripheralDeviceArray) {
        _peripheralDeviceArray = [NSMutableArray array];
    }
    return _peripheralDeviceArray;
}

-(void)setCentralManagerDidUpdateBlock:(void (^)(SACentralManagerState))updateBlock{
    self.updateBlock = updateBlock;
}

- (void)setElectronicScaleResultDataBlock:(void (^)(SAElectronicScaleResultDataModel *))dataModelBlock{
    self.dataModelBlock = dataModelBlock;
}

- (void)setPeripheralConnectionStateDidUpdateBlock:(void (^)(SAPeripheralConnectionState))updateBlock{
    self.connectionStateBlock = updateBlock;
}

@end
