//
//  YYEmoticonPreviewView.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEmoticonModel.h"

@interface YYEmoticonPreviewView : UIView


//初始化
- (instancetype)init:(CGRect)frame;
//给表情赴值
- (void)setemoticon:(YYEmoticonModel *)emoticon;
@end
