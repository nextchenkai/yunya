//
//  HXAudioTool.h
//  HXMusicPlayDemo
//
//  Created by 王雪成 on 16/3/25.
//  Copyright © 2016年 王雪成 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioStreamer.h"
#import "MusicFile.h"

@interface SCAudioTool : NSObject

/**
 *  获取播放器
 *
 *  @param fileName <#fileName description#>
 *
 *  @return 返回播放器 id AudioStreamer网络播放器  AVAudioPlayer本地播放器
 */
+ (id)getAudioPlayer:(MusicFile *)file;

/**
 *  播放音乐
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
+ (void)playMusic:(MusicFile *)file;

/**
 *  暂停播放
 *
 *  @param fileName <#fileName description#>
 */
+ (void)pauseMusic:(MusicFile *)file;

/**
 *  停止音乐
 *
 *  @param fileName <#fileName description#>
 */
+ (void)stopMusic:(MusicFile *)file;

@end
