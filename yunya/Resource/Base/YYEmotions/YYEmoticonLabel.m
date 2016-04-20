//
//  YYEmoticonLabel.m
//  yunya
//
//  Created by 陈凯 on 16/4/9.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonLabel.h"


@implementation YYEmoticonLabel


/**
 *  获取带表情图片的字符串
 *
 *  @return 返回转换好的字符串
 */
- (NSString *)emoticonText{
    __block NSString *temp = @"";
    //便利属性
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        // 如果retult字典中包含 "NSAttachment" 是一个表情.
        YYEmoticonTextAttachment *attachment = [attrs objectForKey:@"NSAttachment"];
        if (attachment != nil) {
            // 获取表情的名称
            temp = [NSString stringWithFormat:@"%@%@",temp,attachment.name_chs];
        }else{
            //截取字符串
            NSString *str = [self.attributedText.string substringWithRange:range];
            //拼接
            temp = [NSString stringWithFormat:@"%@%@",temp,str];
        }
        
    }];
    // 返回拼接好的字符串
    return temp;
}


//刷新attributedText的表情（例：手动输入[哈哈]，将其转化为对应的表情）【逻辑太复杂了，实在不知道微博是怎么实现的】【注释可能看不懂，因为我也不知道怎么去描述】

- (void)reloadAttributedText{
    //将自身字符串转化成包含图片表情的attributedText
    NSAttributedString *temp = [YYEmoticonManegaer emoticonAttributeTextWithText:self.text emoticonWidth:self.font.lineHeight];
    if (temp != nil) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:temp];
        // 给附件添加Font属性
        [attrString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, temp.length)];
        self.attributedText = attrString;
    }

    
}

@end
