//
//  YYWritePostViewController.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"
#import "YYEmotionTextView.h"
#import "YYEmoticonKeyboard.h"
#import "YYDailyImgContainerView.h"

@interface YYWritePostViewController : EMIViewController
@property (weak, nonatomic) IBOutlet UITextField *atrTF;//文章标题

@property (weak, nonatomic) IBOutlet YYEmotionTextView *atrTV;//文章内容
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;//底部背景
@property (weak, nonatomic) IBOutlet UIButton *emojBtn;//表情按钮
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;//图片按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImgToBottom;//底部背景距底部约束，原来为2
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emojToBottom;// 表情按钮据底部约束，原来为8
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoToBottom;// 拍照按钮据底部约束，原来为8
@property (weak, nonatomic) IBOutlet YYDailyImgContainerView *detailImg;
//图片数组
@property (nonatomic, strong) NSMutableArray *imageArray;
//表情键盘
@property (strong,nonatomic) YYEmoticonKeyboard *keyboard;
//是否是表情
@property (assign,nonatomic) BOOL isEmoticon;
//上传图片
@property(nonatomic,copy) NSString *imagePath;
//判断是否有图片
@property(nonatomic,assign) int isimgexiting;//默认为0，不存在，否则为1
@end
