//
//  YYPushValueInstance.h
//  yunya
//
//  Created by 陈凯 on 16/4/18.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYPushValueInstance : NSObject

//单例
+ (YYPushValueInstance *)shareInstance;
//初始化
- (instancetype)init;

@property(nonatomic,copy) NSString *city;//城市名
@property(nonatomic,copy) NSString *citycode;//城市编码
@property(nonatomic,copy) NSString *hospitalid;//医院id
@property(nonatomic,copy) NSString *hospital;//医院名字
@end
