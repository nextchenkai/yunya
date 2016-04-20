//
//  YYChooseDiseaseViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseDiseaseViewModel.h"
#import "Disease.h"

@implementation YYChooseDiseaseViewModel

- (void)fetchDiseaseWithDN:(NSString *)dn withMemberId:(NSString *)memberid {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getdisease.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchDiseaseSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchDiseaseSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [Disease mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

@end
