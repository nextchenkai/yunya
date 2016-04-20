//
//  SCViewModel.m
//  EMINest
//
//  Created by WongSuechang on 16/2/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@implementation SCViewModel

- (instancetype) initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if(self){
        self.viewController = viewController;
    }
    return self;
}

#pragma 接收block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSDictionary *) errorDic
{
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void) netFailure
{
    self.failureBlock();
}

@end
