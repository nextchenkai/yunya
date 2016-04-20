//
//  YYReportDetailViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportDetailViewModel.h"
#import "Inspect.h"

@implementation YYReportDetailViewModel

- (void)fetchReportWithDN:(NSString *)dn withMemberId:(NSString *)memberid withDate:(NSString *)date {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"cdate":date};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/prenatalexamdetail.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchReportSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
- (void)fetchReportSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSString *imgurl = [dict objectForKey:@"imgurl"];
        if(!imgurl){
            imgurl = @"";
        }
        NSArray *array = [dict objectForKey:@"data"];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSDictionary *a in array) {
            Inspect *inspect = [Inspect mj_objectWithKeyValues:a];
            NSArray *detail = [InspectDetail mj_objectArrayWithKeyValuesArray:inspect.detail];
            inspect.detail = detail;
            [result addObject:inspect];
        }
        NSDictionary *m = @{@"data":result,@"imgurl":imgurl};
        self.returnBlock(m);
    }else{
        self.returnBlock(nil);
    }
}
@end
