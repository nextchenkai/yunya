//
//  EMINestHomeButton.m
//  EMINest
//
//  Created by WongSuechang on 16/2/25.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeButton.h"

@implementation YYHomeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
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
    CGFloat imageX = 20;
    CGFloat imageY = 4;
    CGFloat imageW = 40;
    CGFloat imageH = 40;

    return CGRectMake(imageX, imageY, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect {


    CGFloat titleX = 0;
    CGFloat titleY = 50;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 30;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
