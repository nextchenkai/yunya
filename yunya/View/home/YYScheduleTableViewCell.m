//
//  YYScheduleTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYScheduleTableViewCell.h"
#import "Schedule.h"

@interface YYScheduleTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;

@end

@implementation YYScheduleTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYScheduleTableViewCell";
    YYScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYScheduleTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (void)setValue:(id)value {
    Schedule *schedule = value;
    self.timeLabel.text = schedule.cdate;
    self.weekLabel.text = [NSString stringWithFormat:@"孕%@周",schedule.week];
}

@end
