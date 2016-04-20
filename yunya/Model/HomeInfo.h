//
//  HomeInfo.h
//  yunya
//
//  Created by WongSuechang on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bracelet.h"
#import "HomeInfo.h"
#import "Tool.h"
#import "Attention.h"
#import "Recommend.h"
#import "Task.h"
/// 首页内容

@interface HomeInfo : NSObject

@property (nonatomic, strong) NSArray<Bracelet *> *bracelet;

@property (nonatomic, strong) NSArray<Recommend *> *recommend;

@property (nonatomic, copy) NSString *babystate;

@property (nonatomic, copy) NSString *leftexamday;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *type;//用户状态：会员类型-1还未选择用户类型 0普通家属 1备孕中 2怀孕呢 3生完宝宝”,

@property (nonatomic, copy) NSString *success;

@property (nonatomic, strong) NSArray<Tool *> *tool;

@property (nonatomic, copy) NSString *motherstate;

@property (nonatomic, strong) NSArray<Attention *> *attention;

@property (nonatomic, strong) NSArray<Task *> *task;

@property (nonatomic, copy) NSString *babyimg;

@end
