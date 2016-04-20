//
//  YYEmoticonCollectionViewCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonCollectionViewCell.h"

@implementation YYEmoticonCollectionViewCell
//初始化
+ (instancetype)cellWithCollectionView:(CGRect)frame collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    YYEmoticonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emoticonsCell" forIndexPath:indexPath];
    cell.frame = frame;
    cell.emoticonView = [[YYEmoticonView alloc] init:frame];
    [cell.contentView addSubview:cell.emoticonView];
    cell.emoticonView.translatesAutoresizingMaskIntoConstraints = NO;
    return cell;
}
@end
