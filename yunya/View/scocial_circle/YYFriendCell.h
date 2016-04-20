//
//  YYFriendCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"

@interface YYFriendCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimg;//头像
@property (weak, nonatomic) IBOutlet UIButton *telbtn;//电话按钮
@property (weak, nonatomic) IBOutlet UILabel *phonetxt;//手机号
@property (weak, nonatomic) IBOutlet UILabel *friendname;//好友姓名
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendwidth;//好友label宽度约束
@property (weak, nonatomic) IBOutlet UIImageView *yunfuimg;//孕妇图标




+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
