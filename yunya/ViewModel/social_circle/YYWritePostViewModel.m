//
//  YYWritePostViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/4/9.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYWritePostViewModel.h"
#import "YYWritePostViewController.h"

@implementation YYWritePostViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYWritePostViewController *) viewController;
    }
    return self;
}


- (void)fetchAddPostWithDic:(NSDictionary *)dic{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/addforum.do"] withparameter:dic WithReturnValeuBlock:^(id returnValue) {
        [self fetchAddPostSuccess:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchAddPostSuccess:(id)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"发布失败" duration:1.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"帖子发布成功");
        self.returnBlock(returnValue);
    }
}

@end
