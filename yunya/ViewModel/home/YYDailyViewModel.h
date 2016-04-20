//
//  YYHomeRecordViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "Daily.h"

@interface YYDailyViewModel : SCViewModel
- (void)fetchRecordWithUserPhone:(NSString *)dn withMemberId:(NSString *)memberid withPage:(NSInteger)page;

- (void)deleteDaily:(Daily *)daily;
@end
