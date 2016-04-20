//
//  HXMusicData.h
//  HXMusicPlayDemo
//
//  Created by 王雪成 on 16/3/25.
//  Copyright © 2016年 王雪成 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicFile;

@interface SCMusicData : NSObject
@property (nonatomic, strong) NSArray *musics;

/**
 *  返回当前歌曲数据
 *
 *  @return <#return value description#>
 */
- (MusicFile *)playingMusic;

/**
 *  设置当前歌曲数据
 *
 *  @param playingMusic <#playingMusic description#>
 */
- (void)setPlayingMusic:(MusicFile *)playingMusic;

/**
 *  上一首歌曲数据
 *
 *  @return <#return value description#>
 */
- (MusicFile *)previousMusic;

/**
 *  下一首歌曲数据
 *
 *  @return <#return value description#>
 */
- (MusicFile *)nextMusic;

@end
