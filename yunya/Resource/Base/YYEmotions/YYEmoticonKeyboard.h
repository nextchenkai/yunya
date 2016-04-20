//
//  YYEmoticonKeyboard.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEmoticonPackage.h"
#import "YYEmotionTextView.h"
#import "YYEmoticonView.h"

@interface YYEmoticonKeyboard : UIView<UICollectionViewDataSource,UICollectionViewDelegate,YYEmoticonViewDelegate>

//重用标识
@property(nonatomic,copy)NSString *reuseIdentifier;
@property(assign,nonatomic) int rows;//行数
@property(assign,nonatomic) int columns;//列数
//表情键盘
@property(nonatomic,strong)UICollectionView *collectionView;

//表情包
@property(nonatomic,strong) NSMutableArray<YYEmoticonPackage *> *dataSource;

//键盘对应的输入框
@property(nonatomic,strong) YYEmotionTextView *textView;

//初始化
- (instancetype)initWithFrame:(CGRect)frame rows:(int)rows columns:(int)columns;

+ (YYEmoticonKeyboard *)shareInstance:(CGRect)frame rows:(int)rows columns:(int)columns;

- (void)settextView:(YYEmotionTextView *)textView;
@end
