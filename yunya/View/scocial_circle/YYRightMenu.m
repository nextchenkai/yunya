//
//  YYRightMenu.m
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYRightMenu.h"

@implementation YYRightMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame firstBlock:(firstBlock)firstBlock secondBlock:(secondBlock)secondBlock{
    self = [[[NSBundle mainBundle] loadNibNamed:@"YYRightMenu" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        self.frame = frame;
        self.firstBlock = firstBlock;
        self.secondBlock = secondBlock;
        [self.firstBtn addTarget:self action:@selector(first) forControlEvents:UIControlEventTouchUpInside];
        [self.secondbtn addTarget:self action:@selector(second) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setButtonTitlesWithArray:(NSArray *)array{
    [self.firstBtn setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
    [self.secondbtn setTitle:[array objectAtIndex:1] forState:UIControlStateNormal];
}
- (void)first{
    self.firstBlock();
}
- (void)second{
    self.secondBlock();
}
@end
