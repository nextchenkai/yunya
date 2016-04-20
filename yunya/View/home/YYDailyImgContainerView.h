//
//  DailyImgContainerView.h
//  yunya
//
//  Created by WongSuechang on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageContainerViewDelegate <NSObject>

@optional
- (void)deleteImageAtIndex:(NSInteger)index;

@end

@interface YYDailyImgContainerView : UIView

@property (nonatomic, strong) NSArray *picPathStringsArray;
@property (nonatomic, strong) id<ImageContainerViewDelegate> delegate;
@property (nonatomic, assign) BOOL hiddenDelButton;
- (void)setup;

@end
