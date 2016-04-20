//
//  YYHospitalDetailViewModel.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYHospitalDetailViewModel : SCViewModel
//获取医院详情
- (void)fetchHospitalInfoWithInt:(int) hospitalid;
@end
