//
//  YYReportAddViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportAddViewModel.h"
#import "Inspect.h"

@implementation YYReportAddViewModel

- (void)fetchInspectItemWithDN:(NSString *)dn withMemberId:(NSString *)memberid {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/prenatalexaminspectlist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchItemSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchItemSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSDictionary *a in array) {
            Inspect *inspect = [Inspect mj_objectWithKeyValues:a];
            NSArray *detail = [InspectDetail mj_objectArrayWithKeyValuesArray:inspect.detail];
            inspect.detail = detail;
            [result addObject:inspect];
        }
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

- (void)addReportWithDN:(NSString *)dn withMemberId:(NSString *)memberid withImageUrl:(NSString *)imgurl withDate:(NSString *)date withReport:(NSArray *)array {
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for(Inspect *inspect in array){
        
        for(InspectDetail *detail in inspect.detail){
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:inspect.inspectid forKey:@"inspectid"];
            [dict setValue:detail.inspectdetailid forKey:@"inspectdetailid"];
            [dict setValue:detail.svalue forKey:@"svalue"];
            [data addObject:dict];
        }
    }
    
//    NSArray *array1 = [Inspect mj_keyValuesArrayWithObjectArray:array];
    if(!imgurl){
        imgurl = @"";
    }
    if(!date){
        date = [DateTools dateToString:[NSDate date]];
    }
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"imgurl":imgurl,@"examtime":date,@"data":data};
    NSLog(@"新增产检报告:\n%@",params);
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/addprenatalexamdetail.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self addReportSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
- (void)addReportSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}
@end
