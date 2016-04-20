//
//  YYEmoticonKeyboard.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonKeyboard.h"
#import "YYEmoticonCollectionViewCell.h"


static YYEmoticonKeyboard *instance = nil;//不能让外部访问，同时放在静态块中的
@implementation YYEmoticonKeyboard


+ (YYEmoticonKeyboard *)shareInstance:(CGRect)frame rows:(int)rows columns:(int)columns{
    if(instance == nil){
        instance = [[YYEmoticonKeyboard alloc] initWithFrame:frame rows:rows columns:columns];
    }
    return instance;
}

//限制方法，类只能初始化一次
//alloc的时候调用
+ (id) allocWithZone:(struct _NSZone *)zone{
    if(instance == nil){
        instance = [super allocWithZone:zone];
    }
    return instance;
}

//拷贝方法
- (id)copyWithZone:(NSZone *)zone{
    return instance;
}


//初始化
- (instancetype)initWithFrame:(CGRect)frame rows:(int)rows columns:(int)columns{
    self = [super initWithFrame:frame];
    if (self) {
        self.reuseIdentifier = @"emoticonsCell";
        self.dataSource = [YYEmoticonManegaer shareInstance].emoticonPackages;
        self.rows = rows;
        self.columns = columns;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        //加载表情
        for (YYEmoticonPackage *emoticonPackage  in self.dataSource) {
            [emoticonPackage loadEmoticonGroups:rows columns:columns];
        }
        //表情键盘
        self.collectionView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        self.collectionView.clipsToBounds = false;
        self.collectionView.showsHorizontalScrollIndicator = false;
        self.collectionView.pagingEnabled = false;
        [self.collectionView registerClass:[YYEmoticonCollectionViewCell class] forCellWithReuseIdentifier:self.reuseIdentifier];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)settextView:(YYEmotionTextView *)textView{
    self.textView = textView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    // 默认只有一行
    return self.dataSource[section].emoticonGroups.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYEmoticonCollectionViewCell *cell = [YYEmoticonCollectionViewCell cellWithCollectionView:CGRectMake(0, 0, screenWidth, 216) collectionView:collectionView indexPath:indexPath];
    cell.emoticonView.delegate = self;
    YYEmoticonPackage *package = self.dataSource[indexPath.section];
    YYEmoticonGroup *emoticonGroup = package.emoticonGroups[indexPath.row];
    [cell.emoticonView setemoticon:emoticonGroup.emoticons];
    [cell.emoticonView setrows:self.rows columns:self.columns];
    return cell;
}


/**
*  选择了某个表情
*
*  @param emoticonView
*  @param emoticon
*/
-(void)didSelectEmoticon:(YYEmoticonView *)emoticonView emoticon:(YYEmoticonModel *)emoticon{
    YYEmotionTextView *txtview = self.textView;
    if (txtview != nil) {
        [txtview insertEmoticon:emoticon];
    }
}

/**
 *  选择了删除
 *
 *  @param emoticonView
 */
-(void)emoticonViewDidSelectDelete:(YYEmoticonView *)emoticonView{
    [self.textView deleteBackward];
}

@end


