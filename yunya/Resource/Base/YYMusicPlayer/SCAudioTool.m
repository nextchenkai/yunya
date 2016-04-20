//
//  HXAudioTool.m
//  HXMusicPlayDemo
//
//  Created by 王雪成 on 16/3/25.
//  Copyright © 2016年 王雪成 emi365. All rights reserved.
//

#import "SCAudioTool.h"
#import "AudioStreamer.h"
#import <AVFoundation/AVFoundation.h>

@implementation SCAudioTool

/**
 *存放所有的音乐播放器
*/
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers {
    if (_musicPlayers == nil) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

+ (id)getAudioPlayer:(MusicFile *)file {
    
    if (!file) {
        //如果没有传入文件名，那么直接返回
        return nil;
    }
    
    //1.取出对应的播放器
    id player = [self musicPlayers][file.name];
    
    if (!player) {
        
        if([file.fileurl rangeOfString:@"http"].location != NSNotFound) {
            //网络音乐
            NSURL *url = [NSURL URLWithString:file.fileurl];
            player = [[AudioStreamer alloc] initWithURL:url];
        } else {
            //本地音乐
            //音频文件的URL
            NSURL *url = [[NSBundle mainBundle] URLForResource:file.fileurl withExtension:nil];
            //根据url创建播放器
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            
            AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
            if (![audioPlayer prepareToPlay]) {
                //如果缓冲失败，那么就直接返回
                return nil;
            }
        }
        
        //存入字典
        [self musicPlayers][file.name] = player;
    }
    
    return player;
}

+ (void)playMusic:(MusicFile *)file {
    if (!file) {
        //如果没有传入文件名,那么直接返回
        return;
    }
    
    id player = [self getAudioPlayer:file];
    
    if ([player isKindOfClass:[AudioStreamer class]]) {
        //网络音乐
        AudioStreamer *streamer = (AudioStreamer *)player;
        [streamer start];
    } else if ([player isKindOfClass:[AVAudioPlayer class]]) {
        AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
        //暂停
        [audioPlayer play];
    }
}

+ (void)pauseMusic:(MusicFile *)file {
    if (!file) {
        //如果没有传入文件名,那么直接返回
        return;
    }

    id player = [self getAudioPlayer:file];
    
    if ([player isKindOfClass:[AudioStreamer class]]) {
        //网络音乐
        AudioStreamer *streamer = (AudioStreamer *)player;
        [streamer pause];
    } else if ([player isKindOfClass:[AVAudioPlayer class]]) {
        AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
        //暂停
        [audioPlayer pause];
    }
}

+ (void)stopMusic:(MusicFile *)file {
    if (!file) {
        //如果没有传入文件名，那么就直接返回
        return;
    }
    
    id player = [self getAudioPlayer:file];
    
    if ([player isKindOfClass:[AudioStreamer class]]) {
        //网络音乐
        AudioStreamer *streamer = (AudioStreamer *)player;
        [streamer stop];
    } else if ([player isKindOfClass:[AVAudioPlayer class]]) {
        AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
        //暂停
        [audioPlayer stop];
    }
    
    //3.将播放器从字典中移除
    [[self musicPlayers] removeObjectForKey:file];
}

@end
