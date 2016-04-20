//
//  YYForumCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"
#import "YYDailyImgContainerView.h"
#import "YYEmoticonLabel.h"

@interface YYForumCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWidth;//置顶label的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToTopLeft;//标题左侧距离置顶的距离
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题label
@property (weak, nonatomic) IBOutlet YYEmoticonLabel *contentLabel;//内容label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;//内容高度
@property (weak, nonatomic) IBOutlet YYDailyImgContainerView *contentImg;//图片内容
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgHeight;//图片内容高度
@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;//昵称
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间label
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;//回复量 label


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)initView:(YYForumCell *)cell value:(id)value;
@end
