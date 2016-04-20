//
//  YYKitCollectionViewCell.h
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYKitCollectionViewCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath;
- (void)setValue:(id)value;
@end
