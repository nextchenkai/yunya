//
//  YYEmoticonPackage.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYEmoticonModel.h"
#import "YYEmoticonGroup.h"
/**
 *   表情包
 */
@interface YYEmoticonPackage : NSObject

// 表情包对应的文件夹名称
@property(nonatomic,copy) NSString *folder;

// 表情包名称(简体)
@property(nonatomic,copy) NSString *group_name_cn;

// 表情包名称(繁体)
@property(nonatomic,copy) NSString *group_name_tw;

// 表情模型数组
@property(nonatomic,strong) NSMutableArray<YYEmoticonModel *> *emoticons;
// 表情分组数组
@property(nonatomic,strong) NSMutableArray<YYEmoticonGroup *> *emoticonGroups;
//初始化
- (instancetype)init:(NSString *)folder;

//根据行列，加载表情分组
- (void)loadEmoticonGroups:(int)rows columns:(int)columns;
@end
