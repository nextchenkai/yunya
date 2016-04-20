//
//  SCMTextButton.h
//  yunya
//
//  Created by WongSuechang on 16/3/21.
//  Copyright © 2016年 emi365. All rights reserved.
//

/**
 *  显示两行文本的Button
 *  自定义每行文字字体及内容
 */


#import "MenuButton.h"

@interface SCMTextButton : MenuButton

@property (nonatomic, strong) UILabel *contentLabel;
//@property (nonatomic, copy) NSString *content;

- (instancetype)initWithTitle:(NSString *)title withOtherContent:(NSString *)content withFrame:(CGRect)rect;

@end
