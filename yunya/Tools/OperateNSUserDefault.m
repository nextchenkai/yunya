//
//  OperateNSUserDefault.m
//  yunya
//
//  Created by 陈凯 on 16/3/21.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "OperateNSUserDefault.h"

@implementation OperateNSUserDefault

//存入用户信息
+ (void)saveUserDefault:(NSDictionary *)dic{
    Userinfo *user = [Userinfo mj_objectWithKeyValues:dic];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    @try {
        //手机号
        [userDefaults setObject:user.dn forKey:@"dn"];
        //昵称
        [userDefaults setObject:user.nickname forKey:@"nickname"];
        //会员id
        [userDefaults setObject:user.memberid forKey:@"memberid"];
        //type
        [userDefaults setObject:user.type forKey:@"type"];
        //city
        [userDefaults setObject:user.city forKey:@"city"];
        //citycode
        [userDefaults setObject:user.citycode forKey:@"citycode"];
        //是否登陆过
        [userDefaults setObject:user.islogin forKey:@"islogin"];
        //医院id
        [userDefaults setObject:user.hospitalid forKey:@"hospitalid"];
        //医院
        [userDefaults setObject:user.hospital forKey:@"hospital"];
        //是否医生
        [userDefaults setObject:user.isdoctor forKey:@"isdoctor"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    //同步到磁盘
    [userDefaults synchronize];
}

//读取用户信息
+ (id)readUserDefault{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults stringForKey:@"dn"].length>0){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    @try {
        [dic setObject:[userDefaults stringForKey:@"dn"] forKey:@"dn"];
        [dic setObject:[userDefaults stringForKey:@"nickname"] forKey:@"nickname"];
        [dic setObject:[userDefaults stringForKey:@"type"] forKey:@"type"];
        [dic setObject:[userDefaults stringForKey:@"memberid"] forKey:@"memberid"];
        [dic setObject:[userDefaults stringForKey:@"city"] forKey:@"city"];
        [dic setObject:[userDefaults stringForKey:@"citycode"] forKey:@"citycode"];
        [dic setObject:[userDefaults stringForKey:@"islogin"] forKey:@"islogin"];
        [dic setObject:[userDefaults stringForKey:@"hospitalid"] forKey:@"hospitalid"];
        [dic setObject:[userDefaults stringForKey:@"hospital"] forKey:@"hospital"];
        [dic setObject:[userDefaults stringForKey:@"isdoctor"] forKey:@"isdoctor"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    Userinfo *user = [Userinfo mj_objectWithKeyValues:dic];
    return user;
    }
    return nil;
}
//新增临时userdefault的值
+ (void)addUserDefaultWithKeyAndValue:(NSString *)key value:(id)value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    //同步到磁盘
    [userDefaults synchronize];
}
//读取临时userdefaultd的值
+ (NSString *)readUserDefaultWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefaults stringForKey:key];
    return value;
}
@end
