//
//  YYDetailPostImgView.h
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDetailPostImgView : UIView

@property (strong,nonatomic)NSMutableArray *imgviewArray;

- (instancetype)initWithImgArray:(NSMutableArray *)imgArray frame:(CGRect)frame;

@end
