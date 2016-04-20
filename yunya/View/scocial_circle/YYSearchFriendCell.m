//
//  YYSearchFriendCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYSearchFriendCell.h"
#import "SearchFriend.h"

@implementation YYSearchFriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYSearchFriendCell";
    YYSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYSearchFriendView" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}
- (void)setValue:(id)values{
    
    SearchFriend *searchfriend = values;
    //设置头像
    //圆角
    self.headimg.clipsToBounds = YES;
    self.headimg.layer.cornerRadius = 10;
    if (searchfriend.headimg != nil) {
        [self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,searchfriend.headimg]]];
    }
    
    //设置手机号
    self.phonetxt.text = [NSString stringWithFormat:@"%@%@",@"手机号：",searchfriend.dn];
    //手机号是否隐藏
    if ([searchfriend.state isEqualToString:@"1"]) {
        self.phonetxt.text = @"暂且保密";
    }
    //设置昵称
    self.friendname.text = searchfriend.nickname;
    //是否已经是好友
    if ([searchfriend.isfriend isEqualToString:@"0"]) {
        [self.ishaoyou setHidden:NO];
    }
    
}

@end
