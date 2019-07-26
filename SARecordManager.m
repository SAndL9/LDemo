//
//  SARecordManager.m
//  SAAudio
//
//  Created by LiLei on 6/12/2018.
//

#import "SARecordManager.h"
#import <AVFoundation/AVFoundation.h>


@interface SARecordMessageProtocol : NSObject <SARecordMessageProtocol>

@end

@implementation SARecordMessageProtocol
@synthesize recordFilePath;
@synthesize recordTime;

@end

@interface SARecordManager () <SARecordMessageDelegate,AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;

/** caf文件路径 */
@property (nonatomic, copy) NSString *cafPath;

/** caf文件名字 */
@property (nonatomic, copy) NSString *kRecordAudioFile;

/** 播放 */
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, assign) BOOL isStop;
@end

@implementation SARecordManager


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)init{
    if (self = [super init]) {
        [self configureDefaultSetting];
    }
    return self;
}

#pragma mark-
#pragma mark- AVAudioPlayerDelegate
/** 播放完成的代理方法 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    _isStop = NO;
}


#pragma mark-
#pragma mark- Event response
- (void)startRecord{
    if ([_recorder prepareToRecord]) {
        if (_recorder.isRecording) {
            [_recorder stop];
        }else{
            [_recorder record];
        }
    }
    [_recorder peakPowerForChannel:0.0];
}

- (void)stopRecord{
    
    NSLog(@"kkkk---%f---%@",self.recorder.currentTime,self.cafPath);
    if ([self.delegate respondsToSelector:@selector(audioRecordObject:didFinishMessage:)]) {
        SARecordMessageProtocol *modelProtocol = [[SARecordMessageProtocol alloc]init];
        modelProtocol.recordTime = self.recorder.currentTime;
        modelProtocol.recordFilePath = self.cafPath;
        [self.delegate audioRecordObject:self didFinishMessage:modelProtocol];
    }
    [_recorder stop];
}

- (void)playRecordPath:(NSString *)filePath{
    if (filePath) {
        if (_isStop == YES) {
            [_player stop];
            _isStop = NO;
        }else{
            _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
            _player.delegate = self;
            _player.volume = 1.0;
            [_player play];
            _isStop = YES;
        }
    }else{
        NSLog(@"未找到播放路径");
    }
    
}


- (void)removeRecordPath:(NSString *)filePath{
    if (filePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }else{
        NSLog(@"未找到此路径");
    }
}

- (void)stopPlayAudio{
    [_player stop];
}
- (void)pausePlayAudio{
    [_player pause];
}

#pragma mark-
#pragma mark- Private Methods
/** 配置默认设置 */
- (void)configureDefaultSetting{
    _kRecordAudioFile = [NSString stringWithFormat:@"%lld.caf",(long long)([[NSDate date] timeIntervalSince1970] * 100000)];
   NSDictionary *recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 11025],AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                  [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                  [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,nil];
    NSError *error;
    _recorder = [[AVAudioRecorder alloc]initWithURL:[self getSavePath] settings:recorderSettingsDict error:&error];
    [self activeAudioSession];
    if (error) {
        NSLog(@"错误:%@",error);
    }
//    __weak typeof(self) (weakSelf) = self;
//    SADeviceJurisdictionView *viewSelf = [[SADeviceJurisdictionView alloc]init];
//    [viewSelf checkDeviceJurisdictionWithType:SAMicrophoneJurisdictionType showFromController:self allowBlock:^{
//        [weakSelf addTimer];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf playRecordImgViewAnimation];
//        });
    
//    }];
    
}


/** 获取temp存储 */
- (NSURL *)getSavePath{
    NSString *urlStr =[NSTemporaryDirectory() stringByAppendingPathComponent:_kRecordAudioFile];
    self.cafPath = urlStr;
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/** 配置音频会话 */
- (void)activeAudioSession{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    //设置播放器为扬声器模式
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    [session setActive:YES error:nil];
}

#pragma mark-
#pragma mark- Getters && Setters



#pragma mark-
#pragma mark- SetupConstraints


@end
