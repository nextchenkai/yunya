//
//  PersonalProfile.h
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Disease.h"

@interface PersonalProfile : NSObject

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *bloodtypeid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *beforebirthabortion;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *birthtype;

@property (nonatomic, copy) NSString *marryage;

@property (nonatomic, copy) NSString *afterbirthabortion;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *mroccupation;

@property (nonatomic, copy) NSString *mrage;

@property (nonatomic, copy) NSString *birthhistory;

@property (nonatomic, copy) NSString *profession;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, strong) NSArray<Disease *> *diseasehistory;

@property (nonatomic, copy) NSString *lastabortiondate;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *childrenage;

@property (nonatomic, strong) NSArray<Disease *> *diseasenow;

@property (nonatomic, copy) NSString *citycode;

@property (nonatomic, copy) NSString *bloodtype;

@property (nonatomic, copy) NSString *headimg;

@property (nonatomic, copy) NSString *memberid;

@property (nonatomic, copy) NSString *dn;
@end

