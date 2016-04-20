//
//  YYChooseHospitalViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseHospitalViewModel.h"
#import "YYChooseHospitalViewController.h"

@interface YYChooseHospitalViewModel()

@end

@implementation YYChooseHospitalViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYChooseHospitalViewController *) viewController;
    }
    return self;
}
//获取所有医院
- (void)fetchHospitalNameWithString:(NSString *)citycode{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getallhospital.do"] withparameter:@{@"citycode":citycode} WithReturnValeuBlock:^(id returnValue) {
        self.returnBlock(returnValue);
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}


@end
