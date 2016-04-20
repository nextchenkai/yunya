//
//  YYBabyInfoTableViewCell.h
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCTableViewCell.h"

@interface YYBabyInfoTableViewCell : SCTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题
@property (weak, nonatomic) IBOutlet UIButton *addptoBtn;//添加照片



//cellwithtableview
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
