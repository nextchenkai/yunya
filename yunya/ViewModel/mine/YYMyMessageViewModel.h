//
//  YYMyMessageViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYMyMessageViewModel : SCViewModel
- (void)fetchApplyWithDN:(NSString *)dn withMemberId:(NSString *)memberid;

- (void)passFriendWithid:(NSString *)friendid;
@end
