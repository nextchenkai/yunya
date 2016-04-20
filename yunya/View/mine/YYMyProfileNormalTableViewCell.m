//
//  YYMyProfileNormalTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyProfileNormalTableViewCell.h"
#import "SpecialModel.h"

@interface YYMyProfileNormalTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation YYMyProfileNormalTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMyProfileNormalTableViewCell";
    YYMyProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMyProfileNormalTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    SpecialModel *model = value;
    self.titleLabel.text = model.key;
    self.detailLabel.text = model.value;
}
@end
