//
//  YYBabyInfoTableViewCell.m
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBabyInfoTableViewCell.h"

@implementation YYBabyInfoTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYBabyInfoTableViewCell";
    YYBabyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYBaseInfoTableViewCell" owner:nil options:nil] objectAtIndex:1];
    }
    return cell;
}
- (void)setValue:(id)values{
    NSString *title = [values objectForKey:@"title"];
    [self.titleLabel setText:title];
}
@end
