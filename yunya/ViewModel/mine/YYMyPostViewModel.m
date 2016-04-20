//
//  YYMyPostViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyPostViewModel.h"
#import "Posting.h"

@implementation YYMyPostViewModel

- (void)fetchPostingWithUserPhone:(NSString *)dn withMemberId:(NSString *)memberid withCurrentpage:(NSInteger)currentpage{
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"currentpage":[NSNumber numberWithInteger:currentpage]};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/myselfforumnlist.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchPostingSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchPostingSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSDictionary *forum = [dict objectForKey:@"forum"];
        NSArray *array = [forum objectForKey:@"data"];
        NSArray *result = [Posting mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}
- (void)fetchDeletePostWithUserPhone:(NSString *)dn withIsDoctor:(NSString *)isdoctor withMemberId:(NSString *)memberid withForumid:(NSString *)forumid{
    NSDictionary *params = @{@"dn":dn,@"isdoctor":isdoctor,@"memberid":memberid,@"forumid":forumid};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/delforum.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchDeletePostSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];

}


- (void)fetchDeletePostSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        [self.viewController.view makeToast:@"删除成功" duration:3.0 position:CSToastPositionCenter];
        self.returnBlock(returnValue);
    }else{
        [self.viewController.view makeToast:@"删除失败" duration:3.0 position:CSToastPositionCenter];
    }
}
@end
