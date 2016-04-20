//
//  YYDetailPostViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/4/10.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDetailPostViewModel.h"
#import "YYDetailPostViewController.h"

@implementation YYDetailPostViewModel



- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYDetailPostViewController *) viewController;
    }
    return self;
}


- (void)fetchDetailPostWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getforumdetail.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchDetailPostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchDetailPostSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"加载失败" duration:2.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"加载成功");
        self.returnBlock(returnValue);
    }
}

- (void)fetchReplyPostWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/addforumdetail.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchReplyPostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchReplyPostSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"回复失败" duration:1.0 position:CSToastPositionCenter];
    }else{
        //成功
       [self.viewController.view makeToast:@"回复成功" duration:1.0 position:CSToastPositionCenter];
        self.returnBlock(returnValue);
    }
}

- (void)fetchDeletePostWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/deleteforumdetailid.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchDeletePostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchDeletePostSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"删除失败" duration:1.0 position:CSToastPositionCenter];
    }else{
        //成功
        [self.viewController.view makeToast:@"删除成功" duration:1.0 position:CSToastPositionCenter];
        self.returnBlock(returnValue);
    }
}

@end
