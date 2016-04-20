//
//  YYRefreshHeaderView.m
//  yunya
//
//  Created by WongSuechang on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYRefreshHeaderView.h"

@implementation YYRefreshHeaderView
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare{
    [super prepare];

    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_000%zd", i]];
        [idleImages addObject:image];
    }
    for (NSUInteger i = 10; i<=18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_00%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_000%zd", i]];
        [refreshingImages addObject:image];
    }
    for (NSUInteger i = 10; i<=18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_00%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
