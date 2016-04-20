//
//  YYPackageViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "Package.h"
#import "Userinfo.h"

@interface YYPackageViewModel : SCViewModel

- (void)fetchPackageWithDN:(NSString *)dn withMemberId:(NSString *)memberId;

- (void)savePackage:(Package *)package withUser:(Userinfo *)user;

@end
