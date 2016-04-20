//
//  Encrypt.h
//  EMINest
//
//  Created by WongSuechang on 15/3/16.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@class Encrypt;
@interface Encrypt : NSObject


+ (NSString *)hexStringFromString:(NSString *)passWord;

@end
