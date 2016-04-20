//
//  YYEmotionTextView.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmotionTextView.h"


@implementation YYEmotionTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**
*  重写copy方法，可以复制表情
*
*  @param sender 
*/
- (void)copy:(id)sender{
    
    __block NSString *copyString = @"";
    
    [self.attributedText enumerateAttributesInRange:self.selectedRange options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        YYEmoticonTextAttachment *attachment = [attrs objectForKey:@"NSAttachment"];
        if (attachment != nil) {
            copyString = [NSString stringWithFormat:@"%@%@",copyString,attachment.name_chs];
        }else{
            NSString *str = [self.attributedText.string substringWithRange:range];
            copyString = [NSString stringWithFormat:@"%@%@",copyString,str];
        }
    }];
    //复制粘贴框
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copyString;
}
/**
 *  重写cut方法
 *
 *  @param sender
 */
- (void)cut:(id)sender{
    __block NSString *copyString = @"";
    
    [self.attributedText enumerateAttributesInRange:self.selectedRange options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        YYEmoticonTextAttachment *attachment = [attrs objectForKey:@"NSAttachment"];
        if (attachment != nil) {
            copyString = [NSString stringWithFormat:@"%@%@",copyString,attachment.name_chs];
        }else{
            NSString *str = [self.attributedText.string substringWithRange:range];
            copyString = [NSString stringWithFormat:@"%@%@",copyString,str];
        }
    }];
    [super cut:sender];
    //复制粘贴框
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copyString;

}
/**
 *  重写粘贴方法
 *
 *  @param sender
 */
- (void)paste:(id)sender{
    [super paste:sender];
    [self reloadAttributedText];
}
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
/**
 *  插入一个表情到textview中
 *
 *  @param emoticon 要插入的表情模型
 */
- (void)insertEmoticon:(YYEmoticonModel *)emoticon{
    if (emoticon.pngPath != nil) {
        //图片表情
        
        // 创建一个属性文本,属性文本有一个附件,附件里面有一张图片
        NSMutableAttributedString *attrString = [YYEmoticonManegaer attributedStringWithEmoticon:emoticon width:self.font.lineHeight];
        // 给附件添加Font属性
        if(self.font){
            self.font = [UIFont systemFontOfSize:17.f];
        }
        [attrString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, 1)];
        // 拿出textView内容
        NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        // 获取textView选中的范围，把图片添加到已有内容里面
        NSRange sRange = self.selectedRange;
        [temp replaceCharactersInRange:sRange withAttributedString:attrString];
        
        // 在重新赋值回去
        self.attributedText = temp;
        // 重新设置选中范围,让光标在插入表情后面
        self.selectedRange = NSMakeRange(sRange.location + 1, 0);
        //让光标位置可见
        [self scrollRangeToVisible:self.selectedRange];
        // 手动触发textView文本改变
        // 发送通知,文字改变
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
        // 调用代理,文字改变
        [self.delegate textViewDidChange:self];
    }
    
    
}


//刷新attributedText的表情（例：手动输入[哈哈]，将其转化为对应的表情）【逻辑太复杂了，实在不知道微博是怎么实现的】【注释可能看不懂，因为我也不知道怎么去描述】

- (void)reloadAttributedText{
    //刷新后光标应在从后面数的第几个位置上
    int backwardIndex;
    //光标后面的子串
    NSAttributedString *backString = [self.attributedText attributedSubstringFromRange:NSMakeRange(self.selectedRange.location + self.selectedRange.length, self.attributedText.length - self.selectedRange.location)];
    //光标前面的子串
    NSAttributedString *foreString = [self.attributedText attributedSubstringFromRange:NSMakeRange(0,self.selectedRange.location)];
    if ([backString.string containsString:@"]"]) {
        NSRange foreRange  = [foreString.string rangeOfString:@"[" options:NSBackwardsSearch];
        //若找不到[，则刷新后光标的位置可以确定为从后面数的位置上
        if (foreRange.location == NSNotFound) {
            backwardIndex = (int)(self.attributedText.length - (self.selectedRange.location+self.selectedRange.length));
        }else{
            NSRange backRange = [backString.string rangeOfString:@"]" options:NSCaseInsensitiveSearch];
            NSAttributedString *maybeEmoticonStr = [self.attributedText attributedSubstringFromRange:NSMakeRange(foreRange.location, self.selectedRange.location + self.selectedRange.length + backRange.location + 1 - foreRange.location)];
            __block BOOL isEmoticonStr = NO;
            [maybeEmoticonStr enumerateAttributesInRange:NSMakeRange(0, maybeEmoticonStr.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                YYEmoticonTextAttachment *attachment = [attrs objectForKey:@"NSAttachment"];
                if (attachment != nil) {
                    isEmoticonStr = YES;
                }
            }];
            //若相等，则表示没有包含图片表情
            if (isEmoticonStr) {
                //若包含图片表情，则刷新后光标的位置可以确定为从后面数的位置上
                backwardIndex = (int)(self.attributedText.length - (self.selectedRange.location + self.selectedRange.length));
            }else{
                YYEmoticonModel *_emo = [YYEmoticonManegaer emoticonWithText:maybeEmoticonStr.string];
                if (_emo != nil) {
                    //若此字符串是能转化为表情，则刷新后光标位置应该为"]"后面
                    backwardIndex = (int)(self.attributedText.length - (self.selectedRange.location + self.selectedRange.length + backRange.location + 1));
                }else{
                    //若不能转化为表情，则刷新后光标的位置可以确定为从后面数的位置上
                    backwardIndex = (int)(self.attributedText.length - (self.selectedRange.location + self.selectedRange.length));
                }
            }
            
        }
    }else{
        //光标后面的字符串不会改变，则刷新后光标的位置可以确定为从后面数的位置上
        
        backwardIndex = (int)(self.attributedText.length - (self.selectedRange.location + self.selectedRange.length));
    }
    
    //将图片表情替换成对应的字符串
    __block NSString *tempStr = @"";
    NSLog(@"%@",self.attributedText);
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        YYEmoticonTextAttachment *attachment = [attrs objectForKey:@"NSAttachment"];
        if (attachment != nil) {
            //若是图片表情，则拼接图片表情对应的字符串
            tempStr = [NSString stringWithFormat:@"%@%@",tempStr,attachment.name_chs];
        }else{
            //截取字符串
            NSString *str = [self.attributedText.string substringWithRange:range];
            //拼接
            tempStr = [NSString stringWithFormat:@"%@%@",tempStr,str];
        }

    }];
    //在讲普通字符串转化成包含图片表情的attributedText
    NSAttributedString *temp = [YYEmoticonManegaer emoticonAttributeTextWithText:tempStr emoticonWidth:self.font.lineHeight];
    if (temp != nil) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:temp];
        // 给附件添加Font属性
        [attrString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, temp.length)];
        self.attributedText = attrString;
        self.selectedRange = NSMakeRange(self.attributedText.length - backwardIndex, 0);
    }
}


@end
