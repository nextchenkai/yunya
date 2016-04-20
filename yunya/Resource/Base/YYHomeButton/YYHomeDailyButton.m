//
//  YYHomeDailyButton.m
//  yunya
//
//  Created by WongSuechang on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeDailyButton.h"

@implementation YYHomeDailyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        // 文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 文字颜色
        [self setTitleColor:[UIColor colorWithHexString:@"6b6b6b"] forState:UIControlStateNormal];
        // 字体
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
        
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat width = contentRect.size.width;
    //    CGFloat height = contentRect.size.height;
    CGFloat imageX = 16;
    CGFloat imageY = 5;
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    
    CGFloat titleX = 56;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width-56-8;
    CGFloat titleH = 30;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
