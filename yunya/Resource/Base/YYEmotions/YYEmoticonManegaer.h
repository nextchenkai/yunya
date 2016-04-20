//
//  YYEmoticonManegaer.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYEmoticonPackage.h"
#import "YYEmoticonModel.h"
#import "YYEmoticonTextAttachment.h"
/**
 *  表情控制类单例
 */
@interface YYEmoticonManegaer : NSObject

//表情包
@property(nonatomic,strong) NSMutableArray<YYEmoticonPackage *> *emoticonPackages;

+ (YYEmoticonManegaer *)shareInstance;
/**
 *   获取bundlepath
 *
 *  @return bundlePath
 */
+ (NSString *)getbundlePath;
/**
 *  重写初始化方法
 *
 *  @return
 */
- (instancetype)init;
/**
 *  根据字符串获取对应表情
 *
 *  @param text 字符串
 *
 *  @return 表情
 */
+ (YYEmoticonModel *)emoticonWithText:(NSString *)text;
/**
 *  根据表情模型生成表情的attributedString
 *
 *  @param emoticon 表情模型
 *  @param width    宽度
 *
 *  @return attributedString
 */
+ (NSMutableAttributedString *)attributedStringWithEmoticon:(YYEmoticonModel *)emoticon width:(CGFloat)width;
/**
 *  字符串中的表情字符串转化为表情
 *
 *  @param text          字符串
 *  @param emoticonWidth 宽度
 *
 *  @return attributedString
 */
+ (NSAttributedString *)emoticonAttributeTextWithText:(NSString *)text emoticonWidth:(CGFloat)emoticonWidth;
@end
