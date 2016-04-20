//
//  HospitalDataList.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HospitalData.h"

@interface HospitalDataList : NSObject
@property(nonatomic,copy) NSString *county;//地区
@property(nonatomic,copy) NSString *countycode;//地区编码
@property(nonatomic,strong) NSMutableArray<HospitalData *> *data;//城市信息
@end
