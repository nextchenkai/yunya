//
//  CityList.h
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Datalist.h"
#import "Data.h"

@interface CityList : NSObject
@property(nonatomic,copy) NSString *success;//是否成功
@property(nonatomic,strong) NSMutableArray<Datalist *> *datalist;//城市列表
@end
