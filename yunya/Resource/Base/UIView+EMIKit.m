//
//  UIView+EMIKit.m
//  yunya
//
//  Created by WongSuechang on 16/3/25.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "UIView+EMIKit.h"

@implementation UIView (EMIKit)
- (void)sc_addSubViews:(NSArray *)subviews {
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}
@end
