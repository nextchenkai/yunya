//
//  YYChooseDiseaseViewController.h
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"

@protocol YYChooseDiseaseDelegate <NSObject>

- (void)passDisease:(NSArray *)array;

@end

@interface YYChooseDiseaseViewController : EMIViewController

@property (nonatomic,strong) id<YYChooseDiseaseDelegate> delegate;
@property (nonatomic,assign) NSInteger flag;//0:既病史 1:现病史
@end
