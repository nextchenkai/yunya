//
//  YYUpdateProfileViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "PersonalProfile.h"

@interface YYUpdateProfileViewModel : SCViewModel

- (NSArray *)turnWithProfile:(PersonalProfile *)profile;
- (void)fetchBloodType;
- (void)updateProfile:(PersonalProfile *)profile;

@end
