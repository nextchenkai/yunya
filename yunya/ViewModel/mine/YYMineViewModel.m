//
//  YYMineViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMineViewModel.h"
#import "PersonalProfile.h"

@implementation YYMineViewModel

- (void)fetchPersonalProfileWithDN:(NSString *)dn withMemberId:(NSString *)memberId {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/myselfdata.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchPersonalProfileSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchPersonalProfileSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        PersonalProfile *result = [PersonalProfile mj_objectWithKeyValues:dict];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

@end
