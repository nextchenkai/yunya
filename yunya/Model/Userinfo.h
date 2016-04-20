//
//  Userinfo.h
//  yunya
//
//  Created by 陈凯 on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
//  会员注册成功后的信息

#import <Foundation/Foundation.h>

@interface Userinfo : NSObject
//”手机号”
@property(nonatomic,copy) NSString *dn;
//”昵称”，
@property(nonatomic,copy) NSString *nickname;
//类型”
@property(nonatomic,copy) NSString *type;
//”会员ID”
@property(nonatomic,copy) NSString *memberid;
//”城市
@property(nonatomic,copy) NSString *city;
//”城市编码
@property(nonatomic,copy) NSString *citycode;
//是否登陆过
@property(nonatomic,copy) NSNumber *islogin;
@property(nonatomic,copy) NSString *hospitalid;
@property(nonatomic,copy) NSString *hospital;
@property(nonatomic,copy) NSString *isdoctor;//1,医生 2,会员

@end
