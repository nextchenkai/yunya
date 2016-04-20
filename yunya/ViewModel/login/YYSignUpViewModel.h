//
//  YYSignUpViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
///

#import "SCViewModel.h"

@interface YYSignUpViewModel : SCViewModel


//美化视图
- (void)initview;

/**
 *  请求验证码
 params telStr:手机号码
 */
- (void)fetchYanzmWithTel:(NSString *)telStr;

/**
 *  立即注册
 */
- (void)fetchRegiResultWithDic:(NSDictionary *)params;
/**
 *  60s后再获取
 */
- (void)fetchYanzmAfterSomeTime;
@end

