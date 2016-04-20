//
//  YYAlertView.h
//  yunya
//
//  Created by 陈凯 on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYAlertView : UIView
//button的点击回调
typedef void (^ButtonBlock)();

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIView *otherview;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)ButtonBlock buttonBlock;

- (instancetype)initWithUIView:(UIView *)view frame:(CGRect)frame WithButtonBlock:(ButtonBlock)buttonBlock;

- (void)setLabelText:(NSString *)title;
@end
