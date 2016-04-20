//
//  YYBaikeArticlesViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaikeArticlesViewModel.h"
#import "Article.h"

@implementation YYBaikeArticlesViewModel

- (void)fetchArticleArrayWithTopicId:(NSString *)topicId {
    NSDictionary *params = @{@"topicid":topicId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/toolknowpregnancytopic.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchArticlesSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchArticlesSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSLog(@"结果:\n%@",dict);
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [Article mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

@end
