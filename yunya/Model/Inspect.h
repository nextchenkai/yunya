//
//  Inspect.h
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InspectDetail.h"

@interface Inspect : NSObject

@property (nonatomic, copy) NSString *inspectid;
@property (nonatomic, copy) NSString *title;
//@property (nonatomic, strong) NSArray *detail;
@property (nonatomic, strong) NSArray *detail;

@end
