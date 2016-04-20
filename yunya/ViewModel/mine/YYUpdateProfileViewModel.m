//
//  YYUpdateProfileViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYUpdateProfileViewModel.h"
#import "SpecialModel.h"
#import "BloodType.h"

@implementation YYUpdateProfileViewModel

- (NSArray *)turnWithProfile:(PersonalProfile *)profile {
    if(profile){
        NSMutableArray *personalArray = [[NSMutableArray alloc] init];//个人资料的私人资料
        NSMutableArray *bearArray = [[NSMutableArray alloc] init];//个人资料的生育资料
        NSMutableArray *spouseArray = [[NSMutableArray alloc] init];//个人资料的私人资料
        
        if(profile.headimg.length==0){
            [personalArray addObject:@""];
        }else{
            [personalArray addObject:profile.headimg];
        }
        [personalArray addObjectsFromArray:[self turnPersonArrayWithProfile:profile]];
        
        [bearArray addObjectsFromArray:[self turnBearArrayWithProfile:profile]];
        
        [spouseArray addObjectsFromArray:[self turnSpouseArrayWithProfile:profile]];
        
        NSArray *result = @[personalArray,bearArray,spouseArray];
        return result;
    }
    return nil;
}

/**
 *  个人资料转私人资料SpecialModel数组
 *
 *  @param profile 个人资料
 *
 *  @return 个人数组
 */
- (NSArray *)turnPersonArrayWithProfile:(PersonalProfile *)profile {
    NSMutableArray *personalArray = [[NSMutableArray alloc] init];
    NSArray *keys = @[@"用户昵称",@"地区",@"年龄",@"职业",@"婚龄",@"身高",@"体重",@"既病史",@"现病史",@"血型"];
    
    for(int i=0;i<10;i++){
        SpecialModel *model = [[SpecialModel alloc] init];
        model.key = keys[i];
        NSString *value;
        switch (i) {
            case 0:
                value = profile.nickname;
                break;
            case 1:
                value = profile.city;
                break;
            case 2:
                value = profile.age;
                break;
            case 3:
                value = profile.profession;
                break;
            case 4:
                value = profile.marryage;
                break;
            case 5:
                value = profile.height;
                break;
            case 6:
                value = profile.weight;
                break;
            case 7:
                value = @"";
                break;
            case 8:
                value = @"";
                break;
            case 9:
                value = profile.bloodtype;
                break;
            default:
                break;
        }
        model.value = value;
        [personalArray addObject:model];
    }
    return personalArray;
}

/**
 *  个人资料转为生育情况的SpecialModel数组
 *
 *  @param profile 
 *
 *  @return
 */
- (NSArray *)turnBearArrayWithProfile:(PersonalProfile *)profile {
    NSMutableArray *bearArray = [[NSMutableArray alloc] init];
    NSArray *keys = @[@"已生育数",@"已育儿童年龄",@"已育儿童性别",@"已产胎儿形式",@"生育前流产次数",@"生育后流产次数",@"最后一次流产日期"];
    for(int i=0;i<keys.count;i++){
        SpecialModel *model = [[SpecialModel alloc] init];
        model.key = keys[i];
        NSString *value;
        switch (i) {
            case 0:
                value = profile.birthhistory;
                break;
            case 1:
                value = profile.childrenage;
                break;
            case 2:
            {
                NSString *str = profile.sex;
                NSArray *array = [str componentsSeparatedByString:@","];
                NSMutableArray *typeArray = [[NSMutableArray alloc] init];
                for (NSString *type in array) {
                    if([type isEqualToString:@"0"]){
                        [typeArray addObject:@"女"];
                    }else {
                        [typeArray addObject:@"男"];
                    }
                }
                value = [typeArray componentsJoinedByString:@","];
            }
                break;
            case 3:
            {
                NSString *str = profile.birthtype;
                NSArray *array = [str componentsSeparatedByString:@","];
                NSMutableArray *typeArray = [[NSMutableArray alloc] init];
                for (NSString *type in array) {
                    if([type isEqualToString:@"0"]){
                        [typeArray addObject:@"顺产"];
                    }else {
                        [typeArray addObject:@"剖腹产"];
                    }
                }
                value = [typeArray componentsJoinedByString:@","];
            }
                break;
            case 4:
                value = profile.beforebirthabortion;
                break;
            case 5:
                value = profile.afterbirthabortion;
                break;
            case 6:
                value = profile.lastabortiondate;
                break;
            
            default:
                break;
        }
        model.value = value;
        [bearArray addObject:model];
    }
    return bearArray;
}

- (NSArray *)turnSpouseArrayWithProfile:(PersonalProfile *)profile {
    NSMutableArray *spouseArray = [[NSMutableArray alloc] init];
    NSArray *keys = @[@"配偶年龄",@"配偶职业"];
    for(int i=0;i<keys.count;i++){
        SpecialModel *model = [[SpecialModel alloc] init];
        model.key = keys[i];
        NSString *value;
        switch (i) {
            case 0:
                value = profile.mrage;
                break;
            case 1:
                value = profile.mroccupation;
                break;
            default:
                break;
        }
        model.value = value;
        [spouseArray addObject:model];
    }
    return spouseArray;
}

- (void)fetchBloodType {
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getAllBooldtype.do"] withparameter:nil WithReturnValeuBlock:^(id returnValue) {
        [self fetchfetchBloodTypeSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchfetchBloodTypeSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSArray *data = [dict objectForKey:@"data"];
        NSArray *result = [BloodType mj_objectArrayWithKeyValuesArray:data];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

- (void)updateProfile:(PersonalProfile *)profile {
    NSDictionary *params = profile.mj_keyValues;
    NSLog(@"个人资料:\n%@\n",params);
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/setmyselfdata.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self updateProfileSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)updateProfileSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    self.returnBlock([NSNumber numberWithLong:success]);
}

@end
