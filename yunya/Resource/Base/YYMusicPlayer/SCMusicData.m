//
//  YYMusicData.m
//  HXMusicPlayDemo
//
//  Created by 王雪成 on 16/3/25.
//  Copyright © 2016年 王雪成 emi365. All rights reserved.
//

#import "SCMusicData.h"
#import "MusicFile.h"

@implementation SCMusicData


static  MusicFile *_playingMusic;
        

- (MusicFile *)playingMusic {
    return _playingMusic;
}

- (void)setPlayingMusic:(MusicFile *)playingMusic {
    //如果传入的歌曲名不在音乐库中，那么就直接返回
    if (![self.musics containsObject:playingMusic]) {
        return;
    }

    _playingMusic = playingMusic;
}

- (MusicFile *)previousMusic {
    //设定一个初值
    NSInteger previousIndex = 0;
    if (_playingMusic) {
        //获取当前播放音乐的索引
        NSInteger playingIndex = [self.musics indexOfObject:_playingMusic];
        //设置下一首音乐的索引
        previousIndex = playingIndex - 1;
        //检查数组越界，如果下一首音乐是最后一首，那么重置为0
        if (previousIndex < 0) {
            previousIndex = [self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}

- (MusicFile *)nextMusic {
    //设定一个初值
    NSInteger nextIndex = 0;
    if (_playingMusic) {
        //获取当前播放音乐的索引
        NSInteger playingIndex = [self.musics indexOfObject:_playingMusic];
        //设置下一首音乐的索引
        nextIndex = playingIndex + 1;
        //检查数组越界，如果下一首音乐是最后一首，那么重置为0
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    
    return self.musics[nextIndex];
}

@end
