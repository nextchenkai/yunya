//
//  YYChooseHospitalViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYChooseHospitalViewModel : SCViewModel
//获取所有医院
- (void)fetchHospitalNameWithString:(NSString *)citycode;
@end
