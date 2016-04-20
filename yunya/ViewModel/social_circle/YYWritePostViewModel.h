//
//  YYWritePostViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/4/9.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYWritePostViewModel : SCViewModel



/**
 *  发布新帖
 *
 *  @param dic 传入的参数
 */
- (void)fetchAddPostWithDic:(NSDictionary *)dic;
@end
