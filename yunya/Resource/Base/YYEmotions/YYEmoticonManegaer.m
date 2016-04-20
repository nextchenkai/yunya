//
//  YYEmoticonManegaer.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonManegaer.h"


static YYEmoticonManegaer *instance = nil;//不能让外部访问，同时放在静态块中的

// 获取Emoticons.bundle的路径
static NSString *bundlePath = nil;

@implementation YYEmoticonManegaer

+ (YYEmoticonManegaer *)shareInstance{
    if(instance == nil){
        instance = [[YYEmoticonManegaer alloc] init];
    }
    return instance;
}

//限制方法，类只能初始化一次
//alloc的时候调用
+ (id) allocWithZone:(struct _NSZone *)zone{
    if(instance == nil){
        instance = [super allocWithZone:zone];
    }
    return instance;
}

//拷贝方法
- (id)copyWithZone:(NSZone *)zone{
    return instance;
}

+ (NSString *)getbundlePath{
    bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    return bundlePath;
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        //初始化数组
        self.emoticonPackages = [[NSMutableArray<YYEmoticonPackage *> alloc] init];
        // 获取 emoticons.plist的路径
        NSString *emoticonsPlistPath = [[[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"] stringByAppendingPathComponent:@"emoticons.plist"];
        // 获取 emoticons.plist 内容
        NSDictionary *emoticonsDict = [NSDictionary dictionaryWithContentsOfFile:emoticonsPlistPath];
        // 获取所有表情包数据
        NSMutableArray *packageArr = [emoticonsDict objectForKey:@"packages"];
        
        
        //todo
        //packageArr.count
        for (int i = 0; i < 1; i++) {
            //获取文件夹名
            NSString *folder = [packageArr[i] objectForKey:@"folder"];
            //根据表情包所在文件夹获取表情包
            YYEmoticonPackage *package = [[YYEmoticonPackage alloc] init:folder];
            //将表情包加入数组
            [self.emoticonPackages addObject:package];
        }
        

    }
    
    return self;
}
//根据字符串获取对应表情，返回值为可选类型
+ (YYEmoticonModel *)emoticonWithText:(NSString *)text{
    YYEmoticonModel *emoticon;
    for (YYEmoticonPackage *package in [YYEmoticonManegaer shareInstance].emoticonPackages) {
        for (YYEmoticonModel *emo in package.emoticons) {
            if ([emo.chs isEqualToString:text]) {
                emoticon = emo;
            }
        }
        if (emoticon != nil) {
            break;
        }
    }
    return emoticon;
}


//根据表情模型生成表情的attributedString
+ (NSMutableAttributedString *)attributedStringWithEmoticon:(YYEmoticonModel *)emoticon width:(CGFloat)width{
    // 创建附件
    YYEmoticonTextAttachment *attachment = [[YYEmoticonTextAttachment alloc] init];
    // 设置附件的大小
    attachment.bounds = CGRectMake(0, -4, width, width);
    
    // 给附件添加图片
    attachment.image = [UIImage imageWithContentsOfFile:emoticon.pngPath];
    // 将表情名称赋值给attachment附件
    attachment.name_chs = emoticon.chs;
    attachment.name_cht = emoticon.cht;
    // 创建一个属性文本,属性文本有一个附件,附件里面有一张图片
    NSAttributedString *attrString = [NSMutableAttributedString attributedStringWithAttachment:attachment];
    
    
    return [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
}

// 字符串中的表情字符串转化为表情
+ (NSAttributedString *)emoticonAttributeTextWithText:(NSString *)text emoticonWidth:(CGFloat)emoticonWidth{
    //将文本转化为attributedText备用
    NSMutableAttributedString *tempAttributeText;
    if(text){
        tempAttributeText = [[NSMutableAttributedString alloc] initWithString:text];
        //定义一份可变字符串用来获取表情字符串的range
        NSMutableString *tempText = [[NSMutableString alloc] initWithString:text];
        //用"["分隔字符串
        NSArray *temp = [text componentsSeparatedByString:@"["];
        
        for (NSString *str in temp) {
            //若分隔后的字符串中还包含"]"，就有可能是自定义表情字符串
            if ([str containsString:@"]"]) {
                NSArray *subTemp = [str componentsSeparatedByString:@"]"];
                if (subTemp.count >0) {
                    NSString *emoStr = subTemp[0];
                    //拼接上完整的表情字符串
                    NSString *emotionText = [NSString stringWithFormat:@"[%@]",emoStr];
                    //获取range
                    NSRange range = [tempText rangeOfString:emotionText];
                    //根据表情字符串查找表情模型
                    
                    YYEmoticonModel *emotion = [YYEmoticonManegaer emoticonWithText:emotionText];
                    
                    if (emotion != nil) {
                        //若找到表情模型，将可变字符串中的表情字符串替换为空字符串（以便下次获取range正确）
                        [tempText replaceCharactersInRange:range withString:@" "];
                        //而attributeText则将表情字符串替换为表情
                        [tempAttributeText replaceCharactersInRange:range withAttributedString:[YYEmoticonManegaer attributedStringWithEmoticon:emotion width:emoticonWidth]];
                    }
                    
                    
                    
                }
            }
        }
    }
    
    return tempAttributeText;
}
@end
