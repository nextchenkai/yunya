//
//  YYMyMessageViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyMessageViewModel.h"
#import "FriendApply.h"

@implementation YYMyMessageViewModel

- (void)fetchApplyWithDN:(NSString *)dn withMemberId:(NSString *)memberid{
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"isdoctor":@"2"};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getreadyauthfriendlist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchApplySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchApplySuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"datalist"];
        NSArray *result = [FriendApply mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

- (void)passFriendWithid:(NSString *)friendid {
    NSDictionary *params = @{@"friendsid":friendid,@"isallow":@"1"};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/authfirendapply.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self passFriendSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}


- (void)passFriendSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}
@end
