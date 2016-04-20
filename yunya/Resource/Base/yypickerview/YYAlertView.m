//
//  YYAlertView.m
//  yunya
//
//  Created by 陈凯 on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYAlertView.h"

@implementation YYAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithUIView:(UIView *)view frame:(CGRect)frame WithButtonBlock:(ButtonBlock)buttonBlock{
    self = [super init];
    if(self){
        self.frame = frame;
        self.otherview = view;
        self.backgroundColor = [UIColor whiteColor];
        self.buttonBlock = buttonBlock;
        [self createview];
    }
    return self;
}

- (void)createview{
    //label
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.label];
    //otherview
    [self addSubview:self.otherview];
    //button
    self.button = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-230)/2, self.frame.size.height-40, 230, 30)];
    self.button.backgroundColor = [UIColor colorWithHexString:@"FB9BA9"];
    self.button.titleLabel.textColor = [UIColor whiteColor];
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
}

//确定事件
- (void)alertAction{
    self.buttonBlock();
};

- (void)setLabelText:(NSString *)title{
    self.label.text = title;

}
@end
