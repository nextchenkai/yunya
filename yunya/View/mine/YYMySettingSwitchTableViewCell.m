//
//  YYMySettingSwitchTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMySettingSwitchTableViewCell.h"

@interface YYMySettingSwitchTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//TODO 二期备用
@property (weak, nonatomic) IBOutlet UISwitch *dataSwitch;

@end

@implementation YYMySettingSwitchTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMySettingSwitchTableViewCell";
    YYMySettingSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMySettingSwitchTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    self.titleLabel.text = value;
}
@end
