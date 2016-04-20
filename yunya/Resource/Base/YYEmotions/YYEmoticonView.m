//
//  YYEmoticonView.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonView.h"


@interface YYEmoticonView ()

@end

@implementation YYEmoticonView

//初始化
- (instancetype)init:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化一些数组
        self.emoticons = [NSMutableArray arrayWithCapacity:0];
        
        self.emoticonWidth = 32;
        self.margin = UIEdgeInsetsMake(0, 10, 20, 10);
        
        
        self.backgroundColor = [UIColor clearColor];
//        self.previewView = [[YYEmoticonPreviewView alloc] initWithFrame:CGRectMake(0, 0, 64, 91)];
//        [self addSubview:self.previewView];
//        self.previewView.hidden = YES;
//        //手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        
//        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}
//给表情赴值
- (void)setemoticon:(NSMutableArray<YYEmoticonModel *> *)emoticons{
    self.emoticons = emoticons;
    [self setNeedsDisplay];
}
//给行列赴值
- (void)setrows:(int)rows columns:(int)columns{
    self.rows = rows;
    self.columns = columns;
    
    self.itemWidth = (self.width - self.margin.left - self.margin.right) / (CGFloat)columns;
    self.itemHeight = (self.height - self.margin.top - self.margin.bottom) / (CGFloat)rows;
}
- (void)drawRect:(CGRect)rect{
    NSMutableArray<YYEmoticonModel *> *emoticonss = self.emoticons;
    if (emoticonss != nil) {
        int index = 0;
        for (YYEmoticonModel *emoticon in self.emoticons) {
            NSString *pngPath = emoticon.pngPath;
            if (pngPath != nil) {
                UIImage *image = [UIImage imageWithContentsOfFile:pngPath];
                if (image != nil) {
                    CGFloat leftMargin = (self.itemWidth - image.size.width) / 2.0;   //计算出居中所需的边缘
                    CGFloat topMargin = (self.itemHeight - image.size.height) / 2.0;
                    CGFloat x = self.margin.left + self.itemWidth * (index % self.columns) + leftMargin;   //x坐标
                    CGFloat y = self.margin.top + self.itemHeight * (index / self.columns) + topMargin;   //y坐标
                    [image drawInRect:CGRectMake(x, y, image.size.width, image.size.height)];
                }
            }
            index++;
            //最后一个表情位置用来放删除键
            if (index >= self.rows * self.columns - 1) {
                break;
            }
        }
        //如果有删除按钮，在最后一个位置画删除按钮
        NSString *deletePath = [NSString stringWithFormat:@"%@%@",[YYEmoticonManegaer getbundlePath],@"/compose_emotion_delete.imageset/compose_emotion_delete.png" ];
        UIImage *image = [UIImage imageWithContentsOfFile:deletePath];
        if (image != nil) {
            CGFloat leftMargin = (self.itemWidth - image.size.width) / 2.0;   //计算出居中所需的边缘
            CGFloat topMargin = (self.itemHeight - image.size.height) / 2.0;
            CGFloat x = self.margin.left + self.itemWidth * ((self.rows * self.columns - 1) % self.columns) + leftMargin;   //x坐标
            CGFloat y = self.margin.top + self.itemHeight * ((self.rows * self.columns - 1) / self.columns) + topMargin;   //y坐标
            [image drawInRect:CGRectMake(x, y, image.size.width, image.size.height)];
        }
    }
}
- (void)tapAction:(UITapGestureRecognizer *)sender{
    NSMutableArray<YYEmoticonModel *> *emoticonss = self.emoticons;
    if (emoticonss != nil) {
        int index = [self indexWithLocation:[sender locationInView:self]];
        if (index != -1) {
            if (index == (self.rows * self.columns)-1) {
                //删除键
                [self.delegate emoticonViewDidSelectDelete:self];
            }else if((index < self.rows * self.columns - 1) && index < self.emoticons.count) {
                YYEmoticonModel *emoticon = self.emoticons[index];
                //选择了表情
                [self.delegate didSelectEmoticon:self emoticon:emoticon];
            }
        }
    }
}
//- (void)longPressAction:(UILongPressGestureRecognizer *)sender{
//    
//}


//触摸的是哪个表情
- (int)indexWithLocation:(CGPoint)location{
    //触摸不在范围内，返回-1
    if (location.x < self.margin.left || location.x > (self.width - self.margin.right) || location.y < self.margin.top || location.y > (self.height - self.margin.bottom)) {
        return -1;
    } else {
        //触摸的行、列
        int column = (location.x - self.margin.left) / self.itemWidth;
        int row = (location.y - self.margin.top) / self.itemHeight;
        return row * self.columns + column;
    }
}
@end
