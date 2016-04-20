//
//  ForumDetail.h
//  yunya
//
//  Created by 陈凯 on 16/4/10.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  留言
 */
@interface ForumDetail : NSObject
//“nickname”:”昵称”
//“headimg”:”头像”
//“forumdetailid”:”留言”
//“ctime”:”时间”
//“isdoctor”:”用户类型 1医生 2会员”
//“memberid”:”用户ID”
//“content”:”内容”，
//“tomembernickname”:”回复给某人的昵称”，
//“tomemberid”:”回复给某人的id”，
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *headimg;
@property(nonatomic,copy) NSString *forumdetailid;
@property(nonatomic,copy) NSString *ctime;
@property(nonatomic,copy) NSString *isdoctor;
@property(nonatomic,copy) NSString *memberid;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *tomembernickname;
@property(nonatomic,copy) NSString *tomemberid;
@end
