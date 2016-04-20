//
//  DateTools.h
//  EMINest
//
//  Created by WongSuechang on 15-4-27.
//  Copyright (c) 2015年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTools : NSObject

+(NSString *)caculateWeek:(NSString *)dateString;

+(NSString *)dateToString:(NSDate *) date;

+(NSString *)dateTimeToString:(NSDate *) date;


+(NSDate *)stringToDate:(NSString *)dateString;
+(NSDate *)stringToDateTime:(NSString *)dateString;


//返回前后十年的年份数组
+(NSMutableArray *)tenyearsFromNow;

//返回月份数组
+(NSMutableArray *)monthMax;

//返回最大天数数组
+(NSMutableArray *)dayMax;


//返回月份中的天数数组
+(NSMutableArray *)dayInMonth:(NSString *)month year:(NSString *)year;
@end
