//
//  YYScheduleViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYScheduleViewModel.h"
#import "Schedule.h"

@implementation YYScheduleViewModel

- (void)fetchScheduleWithDN:(NSString *)dn withMemberId:(NSString *)memberId {
    
    NSDictionary *params = @{@"dn":dn,@"memberid":memberId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/prenatalexamlist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchScheduleSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchScheduleSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [Schedule mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}
- (void)updatePergnantdayWithArray:(NSArray *)array {
    NSDictionary *params = @{@"dn":array[0],@"memberid":array[1],@"examtime":array[2]};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/addprenatalexam.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self updatePergnantdaySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)updatePergnantdaySuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSLog(@"时间表上传结果:\n%@",dict);
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}

@end
