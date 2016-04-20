//
//  YYDetailPostViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/4/10.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYDetailPostViewModel : SCViewModel


/**
 *  请求论坛详情数据
 *
 *  @param dic 传入的参数
 */
- (void)fetchDetailPostWithDic:(NSDictionary *)dic;

/**
 *  回复留言
 *
 *  @param dic 传入的参数
 */
- (void)fetchReplyPostWithDic:(NSDictionary *)dic;


/**
 *  删除留言
 *
 *  @param dic 传入的参数
 */
- (void)fetchDeletePostWithDic:(NSDictionary *)dic;

@end
