//
//  CheckAppVersion.m
//  EMINest
//
//  Created by Emi-WongSuechang on 15/5/27.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import "CheckAppVersion.h"

@implementation CheckAppVersion

+(double)getVersionFromLocal
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    double currentVersionDouble = [currentVersion doubleValue];
    return currentVersionDouble;
}

@end
