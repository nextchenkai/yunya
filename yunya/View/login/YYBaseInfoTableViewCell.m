//
//  YYBaseInfoTableViewCell.m
//  yunya
//
//  Created by 陈凯 on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaseInfoTableViewCell.h"

@implementation YYBaseInfoTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYBaseInfoTableViewCell";
    YYBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYBaseInfoTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}

- (void)setValue:(id)values{
    NSString *title = [values objectForKey:@"title"];
    NSString *city = [values objectForKey:@"city"];
    [self.titlelable setText:title];
    [self.citylabel setText:city];
}
@end
