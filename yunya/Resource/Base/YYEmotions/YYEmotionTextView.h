//
//  YYEmotionTextView.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEmoticonTextAttachment.h"
#import "YYEmoticonModel.h"
#import "YYEmoticonManegaer.h"

@interface YYEmotionTextView : UITextView


/**
 *  获取带表情图片的字符串
 *
 *  @return 返回转换好的字符串
 */
- (NSString *)emoticonText;

/**
 *  插入一个表情到textview中
 *
 *  @param emoticon 要插入的表情模型
 */
- (void)insertEmoticon:(YYEmoticonModel *)emoticon;

//刷新attributedText的表情（例：手动输入[哈哈]，将其转化为对应的表情）【逻辑太复杂了，实在不知道微博是怎么实现的】【注释可能看不懂，因为我也不知道怎么去描述】

- (void)reloadAttributedText;
@end
