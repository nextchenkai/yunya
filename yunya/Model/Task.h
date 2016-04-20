//
//  Task.h
//  yunya
//
//  Created by WongSuechang on 16/3/21.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  任务
 */
@interface Task : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *state;// 0未完成 1已完成

@property (nonatomic, copy) NSString *type;//任务类型0系统 1人工

@property (nonatomic, copy) NSString *content;

@end