//
//  FriendApply.h
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendApply : NSObject
@property (nonatomic, copy) NSString *nickname;//用户昵称”，
@property (nonatomic, copy) NSString *friendsid;//friends表的ID”
@property (nonatomic, copy) NSString *mpeopleid;//好友ID”,
@property (nonatomic, copy) NSString *headimg;//头像”
@property (nonatomic, copy) NSString *dn;//手机号码”，
@property (nonatomic, copy) NSString *isdoctor;//1医生 2会员”
@property (nonatomic, copy) NSString *state;//手机号码是否显示0显示 1不显示”
@property (nonatomic, copy) NSString *membertype;//如果好友是会员的情况下 0是家属 1怀孕。。。”

@end
