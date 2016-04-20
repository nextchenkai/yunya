//
//  YYMyNoticeViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyNoticeViewModel.h"
#import "Notice.h"

@implementation YYMyNoticeViewModel

- (void)fetchNoticeWithDN:(NSString *)dn withMemberId:(NSString *)memberid {
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"isdoctor":@"2"};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getnoticemsg.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchNoticeSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchNoticeSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [Notice mj_objectArrayWithKeyValuesArray:array];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}
//getnoticemsg.do
//{
//    “dn”:”手机号”
//    “memberid”:
//    “isdoctor”: 1医生 2会员
//}
//“sptype”:” 1医生 2会员”
//“speopleid”:”发送人员ID”，
//“snickname”:”发送人员昵称”，
//“sheadimg”:”发送人员头像”，
//“msgcontent”:”消息内容”，
//“state”:” 0未读 1已读”，
//“ctime”:”发送时间”

@end
