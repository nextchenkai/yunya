//
//  YYEmoticonGroup.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonGroup.h"

@implementation YYEmoticonGroup

//初始化
- (instancetype)init:(NSString *)folder{
    self = [super init];
    if (self) {
        self.folder = folder;
        //初始化一些数组
        self.emoticons = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

@end
