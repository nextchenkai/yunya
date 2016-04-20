//
//  Friends.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  好友
 */
@interface Friends : NSObject

@property (nonatomic, copy) NSString *nickname;//昵称

@property (nonatomic, copy) NSString *headimg;//头像

@property (nonatomic, copy) NSString *dn;//手机号

/**
 *  1医生2会员
 */
@property (nonatomic, copy) NSString *isdoctor;//是否医生

/**
 *  0显示，1不显示
 */
@property (nonatomic, copy) NSString *state;//手机号是否显示

/**
 *  好友是会员的情况下
    0家属，1备孕，2怀孕，3宝宝出生
 */
@property (nonatomic, copy) NSString *membertype;

@end
