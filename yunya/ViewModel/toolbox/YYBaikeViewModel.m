//
//  YYBaikeViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaikeViewModel.h"
#import "BaikeSubject.h"

@implementation YYBaikeViewModel

- (void)fetchBaikeSubjectWithDN:(NSString *)dn withMemberId:(NSString *)memberId {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/toolknowpregnancylist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchBaikeSubjectSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchBaikeSubjectSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [BaikeSubject mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

@end
