//
//  YYEmoticonPackage.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonPackage.h"
#import "YYEmoticonManegaer.h"

@implementation YYEmoticonPackage

//初始化
- (instancetype)init:(NSString *)folder{
    self = [super init];
    if (self) {
        self.folder = folder;
        
        //初始化一些数组
        self.emoticons = [NSMutableArray arrayWithCapacity:0];
        self.emoticonGroups = [NSMutableArray arrayWithCapacity:0];
        
        //获取当前表情包的infoPlist的路径
        NSString *infoPlistPath =  [NSString stringWithFormat:@"%@/%@/info.plist",[YYEmoticonManegaer getbundlePath],self.folder];
        // 把infoPlist的内容加载到内存
        // 获取 emoticons.plist 内容
        NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
        
        self.group_name_cn = [infoDict objectForKey:@"group_name_cn"];
        self.group_name_tw = [infoDict objectForKey:@"group_name_tw"];
        
        NSMutableArray *emoticonArr = [infoDict objectForKey:@"emoticons"];
        
        
        // 遍历表情包里的表情数据，生成表情模型存到数组
        for (NSDictionary *dict in emoticonArr) {
            YYEmoticonModel *emoticon = [[YYEmoticonModel alloc] init:self.folder dic:dict];
            [self.emoticons addObject:emoticon];
        }


        
    }
    return self;
}


//根据行列，加载表情分组
- (void)loadEmoticonGroups:(int)rows columns:(int)columns{
    [self.emoticonGroups removeAllObjects];
    int maxCount = rows*columns -1;
    YYEmoticonGroup *emoticonGroup = [[YYEmoticonGroup alloc] init:self.folder];
    emoticonGroup.group_name_cn = self.group_name_cn;
    emoticonGroup.group_name_tw = self.group_name_tw;
    int index = 0;
    for (YYEmoticonModel *emoticon in self.emoticons) {
        [emoticonGroup.emoticons addObject:emoticon];
        ++index;
        if (index % maxCount == 0) {
            // 当index 为 每页个数的整数倍时，把当页的分组添加到分组数组中，重新初始化分组
            [self.emoticonGroups addObject:emoticonGroup];
            YYEmoticonGroup *emoticonGroup = [[YYEmoticonGroup alloc] init:self.folder];
            emoticonGroup.group_name_cn = self.group_name_cn;
            emoticonGroup.group_name_tw = self.group_name_tw;
        }else if(emoticon == self.emoticons.lastObject){
            // 若为最后个表情，表示当页完毕，也将分组添加到分组数组中
            [self.emoticonGroups addObject:emoticonGroup];
        }
    }
}



@end
