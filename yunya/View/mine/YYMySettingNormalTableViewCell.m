//
//  YYMySettingNormalTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMySettingNormalTableViewCell.h"

@interface YYMySettingNormalTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YYMySettingNormalTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMySettingNormalTableViewCell";
    YYMySettingNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMySettingNormalTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    self.titleLabel.text = value;
}

@end
