//
//  YYMySettingViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMySettingViewModel.h"

@implementation YYMySettingViewModel

- (void)updatePergnantdayWithArray:(NSArray *)array {
    NSDictionary *params = @{@"dn":array[0],@"memberid":array[1],@"datebirth":array[2],@"day":array[3]};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/myselfdata.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self updatePergnantdaySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)updatePergnantdaySuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}

@end
