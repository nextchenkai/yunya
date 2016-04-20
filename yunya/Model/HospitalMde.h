//
//  HospitalMde.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HospitalDataList.h"
#import "HospitalData.h"

@interface HospitalMde : NSObject
@property(nonatomic,copy) NSString *success;//是否成功
@property(nonatomic,strong) NSMutableArray<HospitalDataList *> *datalist;//医院列表

@end
