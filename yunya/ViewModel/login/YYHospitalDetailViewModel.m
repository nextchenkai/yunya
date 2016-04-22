//
//  YYHospitalDetailViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHospitalDetailViewModel.h"
#import "YYHospitalDetailViewController.h"

@implementation YYHospitalDetailViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYHospitalDetailViewController *) viewController;
    }
    return self;
}

//获取医院详情
- (void)fetchHospitalInfoWithInt:(int) hospitalid{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/gethospitalDetail.do"] withparameter:@{@"id":[NSString stringWithFormat:@"%d",hospitalid]} WithReturnValeuBlock:^(id returnValue) {
        self.returnBlock(returnValue);
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];

}

- (void)saveHospitalWithDN:(NSString *)dn withMemberid:(NSString *)memberid withHospitalid:(NSString *)hospitalid {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"hospitalid":hospitalid};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/sethospital.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self savehospitalSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)savehospitalSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}

@end
