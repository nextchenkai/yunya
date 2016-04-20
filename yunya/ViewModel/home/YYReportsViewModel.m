//
//  YYReportsViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportsViewModel.h"
#import "Schedule.h"

@implementation YYReportsViewModel

- (void)fetchReportsWithDN:(NSString *)dn withMemberId:(NSString *)memberid {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/prenatalexamlist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchReportsSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchReportsSuccessWithDic:(NSDictionary *)returnValue {
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
@end
