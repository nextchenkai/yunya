//
//  SystemUtils.h
//  EMINest
//
//  Created by WongSuechang on 15/8/6.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtils : NSObject

+(NSString *)getDeviceModel;

+(id)getUser;

+(id)getEnterprise;

+(void)saveWithUser:(id)user;

+(void)saveWithEnterprise:(id)enterprise;
@end
