//
//  YYCircleViewController.h
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"
#import "LFLUISegmentedControl.h"

@interface YYCircleViewController : EMIViewController
//segument
@property(nonatomic,strong)LFLUISegmentedControl *segment;
//mainscrollview
@property(nonatomic,strong)UIScrollView *mainscroll;

@end
