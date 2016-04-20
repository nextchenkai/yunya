//
//  YYRightMenu.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^firstBlock)();
typedef void (^secondBlock)();

@interface YYRightMenu : UIView
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;//按钮1
@property (weak, nonatomic) IBOutlet UIButton *secondbtn;//按钮2
@property (nonatomic,strong) firstBlock firstBlock;//回调1
@property (nonatomic,strong) secondBlock secondBlock;//回调2
/**
 *  初始化
 *
 *  @param frame
 *  @param firstBlock
 *  @param secondBlock
 *
 *  @return 
 */
- (instancetype)initWithFrame:(CGRect)frame firstBlock:(firstBlock)firstBlock secondBlock:(secondBlock)secondBlock;

- (void)setButtonTitlesWithArray:(NSArray *)array;
@end
