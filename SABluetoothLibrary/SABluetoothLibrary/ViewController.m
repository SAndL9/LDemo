//
//  ViewController.m
//  SABluetoothLibrary
//
//  Created by LiLei on 7/12/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SAPeripheral.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, [UIScreen mainScreen].bounds.size.width - 100, 45)];
    [self.view addSubview:blueLabel];
    blueLabel.backgroundColor = [UIColor whiteColor];
    
    blueLabel.textColor = [UIColor blueColor];
    [[SAPeripheral sharePeripheralInstance] openCentralManagerScan];
    [SAPeripheral sharePeripheralInstance].electronicWeigherScanMacCode = @"80EACA000205";
    [[SAPeripheral sharePeripheralInstance] setElectronicScaleResultDataBlock:^(SAElectronicScaleResultDataModel *dataModel) {
        NSLog(@"控制器里面的电子秤的---%lu--%d----%@---%@---%@---",(unsigned long)dataModel.workState,dataModel.isPeelingSuttleWeight,dataModel.weightValueStr,dataModel.unitStr,dataModel.weightUnitStr);
        blueLabel.text = dataModel.weightUnitStr;
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Bluetooth"];

    
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
