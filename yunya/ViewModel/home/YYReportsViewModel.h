//
//  YYReportsViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYReportsViewModel : SCViewModel

- (void)fetchReportsWithDN:(NSString *)dn withMemberId:(NSString *)memberid;

@end
