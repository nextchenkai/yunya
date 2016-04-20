//
//  YYDailyAddViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/25.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "YYEmotionTextView.h"
#import "YYDailyImgContainerView.h"
#import "Daily.h"

@interface YYDailyAddViewModel : SCViewModel
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) YYEmotionTextView *contentTextView;
@property (nonatomic,strong) YYDailyImgContainerView *containerView;
@property (nonatomic,strong) UIView *buttonView;
@property (nonatomic,strong) UIButton *emojiBtn;
@property (nonatomic,strong) UIButton *cameraBtn;

- (void)initViewsOn:(UIView *)view;

- (void)addDaily:(Daily *)daily;
- (void)update:(Daily *)daily;
@end
