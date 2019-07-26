//
//  SARecordManager.h
//  SAAudio
//
//  Created by LiLei on 6/12/2018.
//

#import <Foundation/Foundation.h>

/**
 录音管理类
 */
@protocol SARecordMessageDelegate;

@protocol SARecordMessageProtocol <NSObject>

/**
 录音时间
 */
@property (nonatomic, assign) NSInteger recordTime;

/**
 录音路径
 */
@property (nonatomic, copy) NSString *recordFilePath;

@end

@interface SARecordManager : NSObject

@property (nonatomic, weak) id<SARecordMessageDelegate> delegate;

//开始录音
- (void)startRecord;
//停止录音
- (void)stopRecord;
//播放录音路径
- (void)playRecordPath:(NSString *)filePath;
//删除录音路径
- (void)removeRecordPath:(NSString *)filePath;

- (void)stopPlayAudio;

- (void)pausePlayAudio;

@end


@protocol SARecordMessageDelegate <NSObject>

@optional

- (void)audioRecordObject:(SARecordManager *)recordManager didFinishMessage:(id<SARecordMessageProtocol>)audioMessage;

@end

