//
//  YYChangePsdViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChangePsdViewModel.h"

@implementation YYChangePsdViewModel

//请求验证码
- (void)fetchYanzmWithTel:(NSString *)telStr{
    //网络请求
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getPhonevalidatecode.do"] withparameter:@{@"dn":telStr} WithReturnValeuBlock:^(id returnValue) {
        [self fetchYanzmSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
//请求成功
- (void)fetchYanzmSuccessWithDic:(NSDictionary *)returnValue{
    //是否成功的标志
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        //验证码发送失败了
        NSString *msg = [returnValue objectForKey:@"msg"];
        //弹框提示错误信息
        [self.viewController.view makeToast:msg duration:3.0 position:CSToastPositionCenter];
        NSLog(@"%@",msg);
    }else{
        NSLog(@"验证码发送成功");
    }
}

- (void)updatePsdWithDN:(NSString *)dn withPsd:(NSString *)psd withCode:(NSString *)code{
    //网络请求
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/modifypassword.do"] withparameter:@{@"dn":dn,@"code":code,@"password":psd} WithReturnValeuBlock:^(id returnValue) {
        [self fetchPsdSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
- (void)fetchPsdSuccessWithDic:(NSDictionary *)returnValue{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSString *success = [NSString stringWithFormat:@"%@",[dict objectForKey:@"success"]];
    if([success isEqualToString:@"1"]){
        self.returnBlock(returnValue);
    }else{
        self.returnBlock(nil);
    }
}
@end
