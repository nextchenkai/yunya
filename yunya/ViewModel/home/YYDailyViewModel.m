//
//  YYHomeRecordViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyViewModel.h"
#import "Daily.h"

@implementation YYDailyViewModel
- (void)fetchRecordWithUserPhone:(NSString *)dn withMemberId:(NSString *)memberid withPage:(NSInteger)page{
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"currentpage":[NSNumber numberWithInteger:page]};
    NSLog(@"记录:\n%@",params);
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/dailylist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchRecordSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchRecordSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSLog(@"记录结果:\n%@",dict);
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSDictionary *dailyDic = [dict objectForKey:@"daily"];
        NSArray *dailys = [dailyDic objectForKey:@"datalist"];
        NSArray *dailyArray = [Daily mj_objectArrayWithKeyValuesArray:dailys];
        
        self.returnBlock(dailyArray);
    }else{
        self.returnBlock(nil);
    }
}

- (void)deleteDaily:(Daily *)daily {
    NSDictionary *params = @{@"dn":daily.dn,@"memberid":daily.memberid,@"id":daily.id};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/deletedaily.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self deleteDailySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)deleteDailySuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSLog(@"记录结果:\n%@",dict);
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}
@end
