//
//  YYKitCollectionViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYKitCollectionViewCell.h"
#import "YYHomeButton.h"

@interface YYKitCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation YYKitCollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"YYKitCollectionViewCell";
    YYKitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYKitCollectionViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {

    self.nameLabel.text = value;
    if([value isEqualToString:@"每日记录"]){
        [self.imageView setImage:[UIImage imageNamed:@"index_jilu"]];
    }else if([value isEqualToString:@"产检报告"]){
        [self.imageView setImage:[UIImage imageNamed:@"index_yunjian"]];
    }else if([value isEqualToString:@"产检时间表"]){
        [self.imageView setImage:[UIImage imageNamed:@"index_shijianbiao"]];
    }else if([value isEqualToString:@"胎教音乐"]){
        [self.imageView setImage:[UIImage imageNamed:@"kit_music"]];
    }else if([value isEqualToString:@"待产包"]){
        [self.imageView setImage:[UIImage imageNamed:@"kit_daichan"]];
    }else if([value isEqualToString:@"孕期百科"]){
        [self.imageView setImage:[UIImage imageNamed:@"kit_baike"]];
    }
}

@end
