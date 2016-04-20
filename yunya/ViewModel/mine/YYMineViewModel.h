//
//  YYMineViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYMineViewModel : SCViewModel

- (void)fetchPersonalProfileWithDN:(NSString *)dn withMemberId:(NSString *)memberId;

@end
