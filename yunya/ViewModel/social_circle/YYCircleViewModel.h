//
//  YYCircleViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYCircleViewModel : SCViewModel

/**
 *  请求论坛数据
 *
 *  @param dic 传入的参数
 */
- (void)fetchPostWithDic:(NSDictionary *)dic;

/**
 *  请求好友列表数据
 *
 *  @param dic 传入的参数
 */
- (void)fetchFriendWithDic:(NSDictionary *)dic;
@end
