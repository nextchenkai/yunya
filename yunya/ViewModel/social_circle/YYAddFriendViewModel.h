//
//  YYAddFriendViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYAddFriendViewModel : SCViewModel


/**
 *  请求论坛数据
 *
 *  @param dic 传入的参数
 */
- (void)fetchSearchFriendWithDic:(NSDictionary *)dic;

/**
 *  好友申请
 *
 *  @param dic 传入的参数
 */
- (void)fetchAddFriendWithDic:(NSDictionary *)dic;
@end
