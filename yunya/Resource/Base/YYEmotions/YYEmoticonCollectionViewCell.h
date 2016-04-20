//
//  YYEmoticonCollectionViewCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEmoticonView.h"
/**
 *  cell
 */
@interface YYEmoticonCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) YYEmoticonView *emoticonView;
//初始化
+ (instancetype)cellWithCollectionView:(CGRect)frame collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
