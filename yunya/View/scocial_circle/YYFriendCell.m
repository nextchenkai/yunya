//
//  YYFriendCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYFriendCell.h"
#import "Friends.h"

@implementation YYFriendCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYFriendCell";
    YYFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYFriendView" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}

- (void)setValue:(id)values{
    
    Friends *friend = values;
    //设置头像
    //圆角
    self.headimg.clipsToBounds = YES;
    self.headimg.layer.cornerRadius = 10;
    if (friend.headimg != nil) {
        [self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,friend.headimg]]];
    }
    
    //设置手机号
    self.phonetxt.text = [NSString stringWithFormat:@"%@%@",@"手机号：",friend.dn];
    //手机号是否隐藏
    if ([friend.state isEqualToString:@"1"]) {
        self.phonetxt.text = @"暂且保密";
        //拨号按钮隐藏
        [self.telbtn setHidden:YES];
    }
    //怀孕标志是否显示
    if ([friend.membertype isEqualToString:@"2"]) {
        [self.yunfuimg setHidden:NO];
    }
    //设置昵称
    self.friendname.text = friend.nickname;
    //获取nickname长度，更改friendnamelabel的宽度
    CGSize size = [self.friendname boundingRectWithSize:CGSizeMake(100, 20)];
    [self.friendwidth setConstant:size.width];
}
@end
