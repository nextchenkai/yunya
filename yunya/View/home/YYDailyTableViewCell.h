//
//  YYDailyTableViewCell.h
//  yunya
//
//  Created by WongSuechang on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"
#import "YYHomeDailyButton.h"

@interface YYDailyTableViewCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet YYHomeDailyButton *editBtn;
@property (weak, nonatomic) IBOutlet YYHomeDailyButton *delBtn;
@end
