//
//  YYPickerCellTableViewCell.h
//  yunya
//
//  Created by 陈凯 on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPickerCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题label
@property (weak, nonatomic) IBOutlet UILabel *line;//分割线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linewidth;
//cellwithtableview
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//设置label文字
- (void)setLabelText:(NSString *)title;
//设置line位置
- (void)setLineFrame:(CGSize)size;
@end
