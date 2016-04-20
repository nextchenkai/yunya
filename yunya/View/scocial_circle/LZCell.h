//
//  LZCell.h
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewCell.h"
#import "YYDetailPostImgView.h"
#import "Posting.h"
#import "YYEmoticonLabel.h"

@interface LZCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimg;//头像
@property (weak, nonatomic) IBOutlet UILabel *nicname;//昵称
@property (weak, nonatomic) IBOutlet UILabel *time;//时间
@property (weak, nonatomic) IBOutlet UILabel *discusscount;//评论量


@property (strong,nonatomic) UILabel *title;//标题

@property (strong,nonatomic) YYEmoticonLabel *content;//内容文字
@property (strong,nonatomic) YYDetailPostImgView *imgcontent;//内容图片


+ (instancetype)cellWithTableView:(UITableView *)tableView value:(id)value;
@end
