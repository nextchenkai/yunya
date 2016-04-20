//
//  YYBaseInfoTableViewCell.h
//  yunya
//
//  Created by 陈凯 on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"

@interface YYBaseInfoTableViewCell : SCTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelable;//标题
@property (weak, nonatomic) IBOutlet UILabel *citylabel;//城市，只有第一个cell有
@property (weak, nonatomic) IBOutlet UIButton *morebtn;//更多按钮

//cellwithtableview
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
