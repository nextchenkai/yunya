//
//  Package.h
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  待产包
 */

@interface Package : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *isready;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *num;

@end
