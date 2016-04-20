//
//  YYOptStatusViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYOptStatusViewModel : SCViewModel

//美化视图
- (void)initview;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

//选择完状态的网络请求
- (void)fetchChooseStatusWithDic:(NSDictionary *)params;
@end
