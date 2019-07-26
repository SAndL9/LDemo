//
//  ViewController.m
//  SAUpdateVersion
//
//  Created by 李磊 on 12/7/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "ViewController.h"
#import "SAViewController.h"
@interface ViewController ()

@end

@implementation ViewController
//最后在dealloc中移除通知 和结束设备旋转的通知
- (void)dealloc{
    //...
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}

//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
    
  
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *locVersion= [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    NSComparisonResult resultVersion = [self compareOnlineVersion:@"1.2" toVersion:locVersion];
    
    NSLog(@"===========%ld---%@",(long)resultVersion,locVersion);
    
    switch (resultVersion) {
        case NSOrderedAscending:
            NSLog(@"线上版本小,有点尴尬");
            break;
        case NSOrderedDescending:
            NSLog(@"线上版本大,需要更新");
            break;
        case NSOrderedSame:
           NSLog(@"不需要做任何操作");
            break;
        default:
        break;
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        exit(0);
//    });
}


/**
 比较两个版本的大小
 typedef enum _NSComparisonResult {
 NSOrderedAscending = -1,    // < 升序
 NSOrderedSame,              // = 等于
 NSOrderedDescending   // > 降序
 } NSComparisonResult;

 @param versionOne 线上版本
 @param versionTwo 本地版本
 @return 比较大小
 */
- (NSComparisonResult)compareOnlineVersion:(NSString*)versionOne toVersion:(NSString*)versionTwo {
    NSArray* versionOneArr = [versionOne componentsSeparatedByString:@"."];
    NSArray* versionTwoArr = [versionTwo componentsSeparatedByString:@"."];
    NSInteger pos = 0;
    while ([versionOneArr count] > pos || [versionTwoArr count] > pos) {
        NSInteger v1 = [versionOneArr count] > pos ? [[versionOneArr objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [versionTwoArr count] > pos ? [[versionTwoArr objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            //版本2大
            return NSOrderedAscending;
        }
        else if (v1 > v2) {
            //版本1大
            return NSOrderedDescending;
        }
        pos++;
    }
    //版本相同
    return NSOrderedSame;
}

















- (IBAction)aaa:(id)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"卡科大卡了代码来得里的昆德拉打开卡的卡里的卡卡的卡卡卡来看待卡的吗阿来看待卡萨达姆卡领导们啊看了对嘛对嘛林科大卡了代码来得快" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//       
//    }];
//    [alert addAction:cancle];
//    [alert addAction:ok];
//    [self presentViewController:alert animated:YES completion:nil];
    
    SAViewController *vc = [[SAViewController alloc]init];
    [vc setValue:@"阿里巴巴与四十大盗" forKey:@"str"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
