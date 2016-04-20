//
//  SCViewModel.h
//  EMINest
//
//  Created by WongSuechang on 16/2/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SCHttpOperation.h"

@interface SCViewModel : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

- (instancetype) initWithViewController:(UIViewController *)viewController;
- (void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
                WithFailureBlock: (FailureBlock) failureBlock;


#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSDictionary *) errorDic;

#pragma 对网路异常进行处理
-(void) netFailure;
@end
