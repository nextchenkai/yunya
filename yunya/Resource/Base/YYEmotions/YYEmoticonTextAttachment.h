//
//  YYEmoticonTextAttachment.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYEmoticonTextAttachment : NSTextAttachment

@property(nonatomic,copy) NSString *name_chs;// 表情的名称(简体)

@property(nonatomic,copy) NSString *name_cht;// 表情的名称(繁体)
@end
