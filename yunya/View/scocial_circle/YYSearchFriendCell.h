//
//  YYSearchFriendCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"

@interface YYSearchFriendCell : SCTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimg;//头像
@property (weak, nonatomic) IBOutlet UILabel *phonetxt;//手机号
@property (weak, nonatomic) IBOutlet UILabel *friendname;//好友姓名
@property (weak, nonatomic) IBOutlet UILabel *ishaoyou;//是否是好友

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
