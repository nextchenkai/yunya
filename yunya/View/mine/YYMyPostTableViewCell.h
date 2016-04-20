//
//  YYMyPostTableViewCell.h
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"
#import "YYDailyImgContainerView.h"
#import "YYHomeDailyButton.h"
#import "Posting.h"

@interface YYMyPostTableViewCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet YYDailyImgContainerView *imageViews;
@property (weak, nonatomic) IBOutlet YYHomeDailyButton *commentCountButton;
@property (weak, nonatomic) IBOutlet YYHomeDailyButton *delPostButton;
@end
