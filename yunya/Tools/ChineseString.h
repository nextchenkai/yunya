//
//  ChineseString.h
//  EMINest
//
//  Created by WongSuechang on 14-9-24.
//  Copyright (c) 2014年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "pinyin.h"



@interface ChineseString : UIViewController
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;


//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;

@end
