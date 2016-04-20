//
//  NSString+Utils.m
//  yunya
//
//  Created by WongSuechang on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+ (NSString *)TransNil:(NSString *)str {
    if([StringToNull notNullString:str]){
        return str;
    }else{
        return @" ";
    }
}

@end
