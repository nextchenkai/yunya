//
//  Encrypt.m
//  EMINest
//
//  Created by WongSuechang on 15/3/16.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import "Encrypt.h"

@interface Encrypt()

+ (NSString *)md5:(NSString *)oriString;

@end

@implementation Encrypt

+ (NSString *)md5:(NSString *)oriString
{
    const char *cStr = [oriString UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6],result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

+ (NSString *)hexStringFromString:(NSString *)passWord
{
    NSString *tempString = [NSString stringWithFormat:@"%@",[self md5:passWord]];
    
    //设置普通的16进制
    const NSString *Str16Class = [NSString stringWithFormat:@"0123456789ABCDEF"];
    //设置自己的16进制
    const NSString *StrMy16Class = [NSString stringWithFormat:@"987654321ABCOXYZ"];
    //分别转化位char类型
    const char * My16Class = [StrMy16Class UTF8String];
    const char * A16Class = [Str16Class UTF8String];
    //设置返回值
    NSString *encryptedString = [[NSString alloc]init];
    encryptedString = @"";
    const char * APassword =[tempString UTF8String];
    //进行循环查找，替换成自己的16进制的数
    for (int i =0; i<[tempString length]; i++) {
        for (int j=0; j<16; j++) {
            if (APassword[i]==A16Class[j]) {
                //连加
                encryptedString = [NSString stringWithFormat:@"%@%c",encryptedString,My16Class[j]];
                continue;
            }
        }
        
    }
    
    return encryptedString;
}
@end
