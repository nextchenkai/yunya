//
//  YYMyMessage2TableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyMessage2TableViewCell.h"
#import "FriendApply.h"

@interface YYMyMessage2TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YYMyMessage2TableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMyMessage2TableViewCell";
    YYMyMessage2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMyMessage2TableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    FriendApply *apply = value;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,apply.headimg]]];
    self.nameLabel.text = apply.nickname;
}
@end
