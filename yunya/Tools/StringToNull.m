//
//  StringToNull.m
//  EMINest
//
//  Created by WongSuechang on 15/5/7.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import "StringToNull.h"

@implementation StringToNull

+(BOOL)notNullString:(NSString *)str
{
    if(str){
        if(![str isEqualToString:@""]){
            return YES;
        }
    }
    return NO;
}

@end
