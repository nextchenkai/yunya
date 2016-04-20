//
//  Posting.h
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  帖子
 */
@interface Posting : NSObject

@property (nonatomic, copy) NSString *imgurl;//图片

@property (nonatomic, copy) NSString *ctime;//时间

@property (nonatomic, copy) NSString *content;//内容

@property (nonatomic, copy) NSString *nickname;//昵称

@property (nonatomic, copy) NSString *title;//标题

@property (nonatomic, copy) NSString *count;//评论数

@property (nonatomic, copy) NSString *headimg;//头像

@property (nonatomic, copy) NSString *isdoctor;//是否医生

@property (nonatomic, copy) NSString *forumid;//帖子id

@property (nonatomic, copy) NSString *memberid;

@end
