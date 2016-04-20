//
//  YYChooseDiseaseViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYChooseDiseaseViewModel : SCViewModel

- (void)fetchDiseaseWithDN:(NSString *)dn withMemberId:(NSString *)memberid;

@end
