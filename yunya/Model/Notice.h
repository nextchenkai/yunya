//
//  Notice.h
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notice : NSObject
@property (nonatomic, copy) NSString *sptype;// 1医生 2会员”
@property (nonatomic, copy) NSString *speopleid;//发送人员ID”，
@property (nonatomic, copy) NSString *snickname;//发送人员昵称”，
@property (nonatomic, copy) NSString *sheadimg;//发送人员头像”，
@property (nonatomic, copy) NSString *msgcontent;//消息内容”，
@property (nonatomic, copy) NSString *state;//0未读 1已读”，
@property (nonatomic, copy) NSString *ctime;//发送时间”
@end
