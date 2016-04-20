//
//  YYReportAddViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYReportAddViewModel : SCViewModel

/**
 *  获取产检项目
 *
 *  @param dn
 *  @param memberid
 */
- (void)fetchInspectItemWithDN:(NSString *)dn withMemberId:(NSString *)memberid;

/**
 *  新增产检报告
 *
 *  @param dn
 *  @param memberid
 *  @param imgurl
 *  @param array    
 */
- (void)addReportWithDN:(NSString *)dn withMemberId:(NSString *)memberid withImageUrl:(NSString *)imgurl withDate:(NSString *)date withReport:(NSArray *)array;
@end
