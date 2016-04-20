//
//  YYPushValueInstance.m
//  yunya
//
//  Created by 陈凯 on 16/4/18.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPushValueInstance.h"

static YYPushValueInstance *instance = nil;
@implementation YYPushValueInstance


//单例
+ (YYPushValueInstance *)shareInstance{
    if (instance == nil) {
        instance = [[YYPushValueInstance alloc] init];
    }
    return instance;
}

//限制方法，类只能初始化一次
+ (id)allocWithZone:(struct _NSZone *)zone{
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}
//拷贝方法
- (id)copyWithZone:(NSZone *)zone{
    return instance;
}

//初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.city = @"";
        self.citycode = @"";
        self.hospital = @"";
        self.hospitalid = @"";
    }
    
    
    return self;
}
@end
