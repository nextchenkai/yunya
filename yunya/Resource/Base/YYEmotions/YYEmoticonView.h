//
//  YYEmoticonView.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEmoticonModel.h"
#import "YYEmoticonPreviewView.h"
#import "YYEmoticonManegaer.h"

@protocol YYEmoticonViewDelegate;

@interface YYEmoticonView : UIView

@property(assign,nonatomic) CGFloat emoticonWidth;//emoji表情显示的宽
@property(assign,nonatomic) UIEdgeInsets margin;//边缘
@property(assign,nonatomic) int rows;//行数
@property(assign,nonatomic) int columns;//列数
@property(assign,nonatomic) BOOL isDeleting;//是否正在删除
@property(assign,nonatomic) CGFloat itemWidth;//表情点击范围的宽
@property(assign,nonatomic) CGFloat itemHeight;//表情点击范围的高
@property(assign,nonatomic) int touchedIndex;
@property(strong,nonatomic) YYEmoticonPreviewView *previewView;
@property(strong,nonatomic) NSMutableArray<YYEmoticonModel *> *emoticons;//展示的表情

//代理
@property(assign,nonatomic) id<YYEmoticonViewDelegate> delegate;
//初始化
- (instancetype)init:(CGRect)frame;
//给表情赴值
- (void)setemoticon:(NSMutableArray<YYEmoticonModel *> *)emoticons;
//给行列赴值
- (void)setrows:(int)rows columns:(int)columns;

- (void)tapAction:(UITapGestureRecognizer *)sender;
@end

@protocol YYEmoticonViewDelegate <NSObject>

@optional
/**
 *  选择了某个表情
 *
 *  @param emoticonView
 *  @param emoticon
 */
-(void)didSelectEmoticon:(YYEmoticonView *)emoticonView emoticon:(YYEmoticonModel *)emoticon;
/**
 *  开始删除
 *
 *  @param emoticonView
 */
-(void)emoticonViewDidBeginDelete:(YYEmoticonView *)emoticonView;
/**
 *  结束删除
 *
 *  @param emoticonView
 */
-(void)emoticonViewDidEndDelete:(YYEmoticonView *)emoticonView;
/**
 *  选择了删除
 *
 *  @param emoticonView
 */
-(void)emoticonViewDidSelectDelete:(YYEmoticonView *)emoticonView;

@end