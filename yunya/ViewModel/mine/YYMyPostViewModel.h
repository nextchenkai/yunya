//
//  YYMyPostViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYMyPostViewModel : SCViewModel
- (void)fetchPostingWithUserPhone:(NSString *)dn withMemberId:(NSString *)memberid withCurrentpage:(NSInteger)currentpage;
- (void)fetchDeletePostWithUserPhone:(NSString *)dn withIsDoctor:(NSString *)isdoctor withMemberId:(NSString *)memberid withForumid:(NSString *)forumid;
@end
