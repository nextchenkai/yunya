//
//  YYEmoticonPreviewView.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonPreviewView.h"


@interface YYEmoticonPreviewView ()
@property(strong,nonatomic) UIImage *backgroundImage;//背景图片
@property(assign,nonatomic) CGRect emoticonRect;//表情frame
@property(strong,nonatomic) YYEmoticonModel *emoticon;//展示的表情
@end


@implementation YYEmoticonPreviewView

//初始化
- (instancetype)init:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundImage = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
        self.emoticonRect = CGRectMake(12, 4, self.width-12*2, self.width-12*2);
    }
    return self;
}

//给表情赴值
- (void)setemoticon:(YYEmoticonModel *)emoticon{
    self.emoticon = emoticon;
    
    [self  setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self.backgroundImage drawInRect:self.bounds];
    NSString *pngPath = self.emoticon.pngPath;
    if (pngPath != nil) {
        UIImage *image = [UIImage imageWithContentsOfFile:pngPath];
        if (image != nil) {
            [image drawInRect:self.emoticonRect];
        }
    }
}
@end
