//
//  YYAddFriendViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYAddFriendViewModel.h"
#import "YYAddFriendViewController.h"

@implementation YYAddFriendViewModel


- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYAddFriendViewController *) viewController;
    }
    return self;
}


- (void)fetchSearchFriendWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/findfriendlist.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchSearchFriendSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchSearchFriendSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"查询失败" duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"查询成功");
        self.returnBlock(returnValue);
    }
}

- (void)fetchAddFriendWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/firendapply.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchAddFriendSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchAddFriendSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"申请失败" duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"申请成功");
        self.returnBlock(returnValue);
    }
}
@end
