//
//  YYBaikeCollectionViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaikeCollectionViewCell.h"
#import "BaikeSubject.h"

@interface YYBaikeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YYBaikeCollectionViewCell
+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"YYBaikeCollectionViewCell";
    YYBaikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYBaikeCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    BaikeSubject *subject = value;
    self.nameLabel.text = subject.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",serverIP,subject.img]]];
    
}
@end
