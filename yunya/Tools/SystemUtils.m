//
//  SystemUtils.m
//  EMINest
//
//  Created by WongSuechang on 15/8/6.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import "SystemUtils.h"
#import <sys/sysctl.h>

@implementation SystemUtils

+(NSString *)getDeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+(id)getUser {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    User *user = [[User alloc] init];
//    user.gid = [ud stringForKey:@"userId"];
//    user.realName = [ud stringForKey:@"realName"];
//    user.nickName = [ud stringForKey:@"nickName"];
//    if(user.gid){
//        return user;
//    }
    return nil;
}

+(id)getEnterprise {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    Enterprise *enterprise = [[Enterprise alloc] init];
//    enterprise.gid = [ud stringForKey:@"enterpriseId"];
//    enterprise.enterpriseName = [ud stringForKey:@"enterpriseName"];
//    if(enterprise.gid){
//        return enterprise;
//    }
    return nil;
    
}

+(void)saveWithUser:(id)user {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setValue:((User *)user).gid forKey:@"userId"];
//    [ud setValue:((User *)user).realName forKey:@"realName"];
//    [ud setValue:((User *)user).nickName forKey:@"nickName"];
//    [ud setValue:((User *)user).phoneNumber forKey:@"phoneNumber"];
//    [ud setValue:((User *)user).password forKey:@"password"];
}

+(void)saveWithEnterprise:(id)enterprise {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setValue:((Enterprise *)enterprise).gid forKey:@"enterpriseId"];
//    [ud setValue:((Enterprise *)enterprise).enterpriseName forKey:@"enterpriseName"];
}

@end
