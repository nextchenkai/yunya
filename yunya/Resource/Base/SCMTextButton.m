//
//  SCMTextButton.m
//  yunya
//
//  Created by WongSuechang on 16/3/21.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCMTextButton.h"

@implementation SCMTextButton

- (instancetype)initWithTitle:(NSString *)title withOtherContent:(NSString *)content withFrame:(CGRect)rect{
    self = [super initWithFrame:rect];
    if(self){
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:title forState:UIControlStateNormal];
//        self.content = content;
        //添加内容label
        [self addContentLabelWithContent:content];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGPoint origin = contentRect.origin;
    CGSize size = contentRect.size;
    return CGRectMake(origin.x+4, origin.y+4, size.width-8, size.height/2-8);
}

- (void)addContentLabelWithContent:(NSString *)content {
    CGPoint origin = self.bounds.origin;
    CGSize size = self.bounds.size;
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(origin.x+4, size.height/2+1, size.width-8, size.height/2-1-8)];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentLabel setTextColor:[UIColor whiteColor]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:10]];
    self.contentLabel.text = content;
    [self addSubview:self.contentLabel];
}

@end
