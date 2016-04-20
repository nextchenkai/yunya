//
//  YYPackageViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPackageViewModel.h"

@implementation YYPackageViewModel

- (void)fetchPackageWithDN:(NSString *)dn withMemberId:(NSString *)memberId {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/toolexpectantpackagelist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchPackageSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchPackageSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [Package mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

- (void)savePackage:(Package *)package withUser:(Userinfo *)user {
    NSDictionary *params = @{@"dn":user.dn,@"memberid":user.memberid,@"id":package.id,@"isready":package.isready};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/toolexpectantpackageset.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self savePackageSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)savePackageSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(@"2");
    }
}

@end
