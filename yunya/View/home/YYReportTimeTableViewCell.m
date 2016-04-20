//
//  YYReportTimeTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportTimeTableViewCell.h"

@interface YYReportTimeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YYReportTimeTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYReportTimeTableViewCell";
    YYReportTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYReportTimeTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (void)setValue:(id)value {
    self.timeLabel.text = value;
}

@end
