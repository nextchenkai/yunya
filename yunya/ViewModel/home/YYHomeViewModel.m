//
//  YYHomeViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeViewModel.h"
#import "YYHomeViewController.h"
#import "HomeInfo.h"
#import "SCMTextButton.h"

@implementation YYHomeViewModel

- (void)fetchHomeInfoWithUserPhone:(NSString *)dn withType:(NSString *)type {
    NSDictionary *params = @{@"dn":dn,@"type":type};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/memberindex.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchHomeInfoSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchHomeInfoSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    NSLog(@"首页信息:\n%@",dict);
    if(success==1){
        HomeInfo *info = [HomeInfo mj_objectWithKeyValues:dict];
        //数组转换
        NSArray *toolArray = info.tool;
        info.tool = [Tool mj_objectArrayWithKeyValuesArray:toolArray];
        NSArray *recArray = info.recommend;
        info.recommend = [Recommend mj_objectArrayWithKeyValuesArray:recArray];
        NSArray *taskArray = info.task;
        info.task = [Task mj_objectArrayWithKeyValuesArray:taskArray];
        NSArray *braceletArray = info.bracelet;
        info.bracelet = [Bracelet mj_objectArrayWithKeyValuesArray:braceletArray];
        
        self.returnBlock(info);
    }else {
        self.returnBlock(nil);
    }

}

- (CircleMenu *)newCircleMenuWithArray:(NSArray *)braceletArray {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(Bracelet *bracelet in braceletArray){
        SCMTextButton *button = [[SCMTextButton alloc] initWithTitle:bracelet.name withOtherContent:[NSString stringWithFormat:@"%@%@",bracelet.dvalue,bracelet.unit] withFrame:CGRectMake(0, 0, 60, 60)];
        [button setBackgroundImage:[UIImage imageNamed:@"index_qipao"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [arr addObject:button];
    }
    CircleMenu *circleMenu = [[CircleMenu alloc] initWithFrame:CGRectMake(8, -(screenWidth-16)/2+30, screenWidth-16, 400)];
    circleMenu.arrButton = arr;
    return circleMenu;
}

- (NSMutableArray *)translateToArrayWithHomeInfo:(HomeInfo *)info {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if(info){
        [array addObject:@[[NSString TransNil:info.motherstate]]];
        // TODO
        [array addObject:@[@"tool"]];
        if(info.task){
            [array addObject:info.task];
        }
        if(info.recommend){
            [array addObject:info.recommend];
        }
        //    [array addObject:info.attention];
        return array;
    }
    return nil;
    
}

- (void)finishTask:(Task *)task WithDN:(NSString *)dn withMemberId:(NSString *)memberid{
    NSDictionary *params = @{@"dn":dn,@"memberid":memberid,@"type":task.type,@"taskid":task.id};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/finshtask.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self finishTaskSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)finishTaskSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else {
        self.returnBlock(nil);
    }
}
@end
