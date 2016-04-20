//
//  SearchFriend.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  根据昵称查询好友
 */
@interface SearchFriend : NSObject

@property (nonatomic, copy) NSString *nickname;//昵称

/**
 *  好友id
 */
@property (nonatomic, copy) NSString *fpeopleid;

/**
 *  1医生2会员
 */
@property (nonatomic, copy) NSString *isdoctor;//是否医生

@property (nonatomic, copy) NSString *headimg;//头像

@property (nonatomic, copy) NSString *dn;//手机号


/**
 *  0显示，1不显示
 */
@property (nonatomic, copy) NSString *state;//手机号是否显示

/**
 *  ”是否已经是好友 0 是的1不是”
 */
@property (nonatomic, copy) NSString *isfriend;
@end
