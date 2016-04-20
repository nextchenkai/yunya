//
//  YYReportDetailViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYReportDetailViewModel : SCViewModel
- (void)fetchReportWithDN:(NSString *)dn withMemberId:(NSString *)memberid withDate:(NSString *)date;
@end
