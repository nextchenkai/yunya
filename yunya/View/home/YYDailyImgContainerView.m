//
//  DailyImgContainerView.m
//  yunya
//  每日记录的图片containerview
//  Created by WongSuechang on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyImgContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "SDPhotoBrowser.h"

@interface YYDailyImgContainerView()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation YYDailyImgContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)init
{
    self=[super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}
- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
        UIImage *image;
        if([_picPathStringsArray.firstObject isKindOfClass:[NSString class]]) {
            image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        }else{
            image = _picPathStringsArray.firstObject;
        }
        
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSObject *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        if([obj isKindOfClass:[NSString class]]){
            [imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)obj]];
        }else{
            imageView.image = (UIImage *)obj;
        }
        
        imageView.frame = CGRectMake(5+columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
//        imageView.frame = CGRectMake(columnIndex * (itemW + margin), 0, itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWith = @(w);
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    browser.hiddenDelButton = self.hiddenDelButton;
    [browser show];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 60;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 60 : 50;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    if([self.picPathStringsArray[index] isKindOfClass:[NSString class]]){
        NSString *imageName = self.picPathStringsArray[index];
        NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
        return url;
    }
    return nil;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
if([self.picPathStringsArray[index] isKindOfClass:[NSString class]]){
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.picPathStringsArray[index]]];
    return imageView.image;
}else{
    return self.picPathStringsArray[index];
}
}

- (void)deleteAtIndex:(NSInteger)index {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.picPathStringsArray];
    [array removeObjectAtIndex:index];
    self.picPathStringsArray = array;
    
    if([self.delegate respondsToSelector:@selector(deleteImageAtIndex:)]){
        [self.delegate deleteImageAtIndex:index];
    }
}

@end
