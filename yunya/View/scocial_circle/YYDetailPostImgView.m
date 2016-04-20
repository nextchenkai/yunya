//
//  YYDetailPostImgView.m
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDetailPostImgView.h"

@implementation YYDetailPostImgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithImgArray:(NSMutableArray *)imgArray frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat y = 0;
        for (int i = 0; i<imgArray.count; i++) {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, 400)];
            [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,[imgArray objectAtIndex:i]]]];
            
            y = y +400+4;
            [_imgviewArray addObject:imageview];
            
            [self addSubview:imageview];
        }
    }
    
    return self;
}
@end
