//
//  Disease.h
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  疾病
 */
@interface Disease : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isCheck;

@end
