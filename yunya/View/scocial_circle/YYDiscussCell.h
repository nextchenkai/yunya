//
//  YYDiscussCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"
#import "YYEmoticonLabel.h"
#import "ForumDetail.h"
#import "Userinfo.h"

@interface YYDiscussCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head;//头像
@property (weak, nonatomic) IBOutlet UILabel *nickname;//昵称

@property (weak, nonatomic) IBOutlet UILabel *floor;//楼层

@property (weak, nonatomic) IBOutlet UILabel *time;//时间

@property (weak, nonatomic) IBOutlet UIButton *btn;//按钮


@property (strong,nonatomic) YYEmoticonLabel *content;//内容文字

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)initView:(YYDiscussCell *)cell value:(id)value floorcount:(int)floorcount lzmemberid:(NSString *)lzmemberid;
@end
