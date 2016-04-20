//
//  YYEmoticonModel.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  单个表情数据模型
 */
@interface YYEmoticonModel : NSObject

@property(nonatomic,copy) NSString *folder;//存放表情的文件夹

@property(nonatomic,copy) NSString *chs;//表情简体名称

@property(nonatomic,copy) NSString *cht;//表情繁体名称

@property(nonatomic,copy) NSString *png;//表情对应的图片

@property(nonatomic,copy) NSString *pngPath;//图片的完整路径

//初始化
- (instancetype)init:(NSString *)folder dic:(NSDictionary *)dic;

@end
