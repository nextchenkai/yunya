//
//  YYMyMessage1TableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyMessage1TableViewCell.h"

@implementation YYMyMessage1TableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMyMessage1TableViewCell";
    YYMyMessage1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMyMessage1TableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
@end
