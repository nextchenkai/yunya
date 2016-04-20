//
//  YYChangePsdViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYChangePsdViewModel : SCViewModel
//
//@property(nonatomic,assign) int counttime;//到计时
//@property(nonatomic,strong) NSTimer *time;//计时器

- (void)fetchYanzmWithTel:(NSString *)telStr;

- (void)updatePsdWithDN:(NSString *)dn withPsd:(NSString *)psd withCode:(NSString *)code;
@end
