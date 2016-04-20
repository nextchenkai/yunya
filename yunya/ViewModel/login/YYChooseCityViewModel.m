//
//  YYChooseCityViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseCityViewModel.h"
#import "YYChooseCityViewController.h"

@implementation YYChooseCityViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYChooseCityViewController *) viewController;
    }
    return self;
}
//获取所有城市
- (void)fetchCityName{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/allCityData.do"] withparameter:nil WithReturnValeuBlock:^(id returnValue) {
        self.returnBlock(returnValue);
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
@end
