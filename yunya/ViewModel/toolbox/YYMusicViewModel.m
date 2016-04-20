//
//  YYMusicViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMusicViewModel.h"
#import "MusicFile.h"

@implementation YYMusicViewModel

- (void)fetchMusic {
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getmusiclist.do"] withparameter:nil WithReturnValeuBlock:^(id returnValue) {
        [self fetchMusicSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchMusicSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *array = [dict objectForKey:@"data"];
        NSArray *result = [MusicFile mj_objectArrayWithKeyValuesArray:array];
        for (MusicFile *file in result) {
            file.fileurl = [NSString stringWithFormat:@"%@%@",imgIP,file.fileurl];
        }
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}
@end
