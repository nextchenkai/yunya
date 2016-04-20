//
//  YYScheduleViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYScheduleViewModel : SCViewModel

- (void)fetchScheduleWithDN:(NSString *)dn withMemberId:(NSString *)memberId;
- (void)updatePergnantdayWithArray:(NSArray *)array;
@end
