//
//  SpecialModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  特殊model 由key和value构成
 *  key:属性名;
 *  value:属性值;
 *  形如:  @key:身高
          @value:170cm;
 */

@interface SpecialModel : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

@end
