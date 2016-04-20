//
//  YYLoginViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/3/19.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"




@interface YYLoginViewModel : SCViewModel

//美化视图
- (void)initview;

//登陆
- (void)fetchLoginWithDic:(NSDictionary *)params;
@end
