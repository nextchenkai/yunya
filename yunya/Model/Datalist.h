//
//  datalist.h
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface Datalist : NSObject
@property(nonatomic,copy) NSString *code;//城市首字母
@property(nonatomic,strong) NSMutableArray<Data *> *data;//城市信息
@end
