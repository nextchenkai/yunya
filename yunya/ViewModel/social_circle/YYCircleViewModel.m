//
//  YYCircleViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYCircleViewModel.h"
#import "YYCircleViewController.h"

@interface YYCircleViewModel ()
{

}
@end

@implementation YYCircleViewModel


- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYCircleViewController *) viewController;
    }
    return self;
}


- (void)fetchPostWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/forumdata.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchPostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchPostSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"加载失败" duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"帖子加载成功");
        self.returnBlock(returnValue);
    }
}

- (void)fetchFriendWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/friendlist.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchPostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
- (void)fetchFriendSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"加载失败" duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"好友加载成功");
        self.returnBlock(returnValue);
    }
}
@end
