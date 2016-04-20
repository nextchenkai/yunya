//
//  YYHomeTaskTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeTaskTableViewCell.h"

@interface YYHomeTaskTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskContentLabel;


@end

@implementation YYHomeTaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYHomeTaskTableViewCell";
    YYHomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeTaskTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Task *task = (Task *)value;
    if([task.state isEqualToString:@"1"]){
        self.checkBox.on = YES;
    }else
        self.checkBox.on = NO;
    
//    self.taskTitleLabel.text = @"今天你喝水了吗?";
    self.taskTitleLabel.text = task.title;
    CGSize titleSize = [self.taskTitleLabel boundingRectWithSize:CGSizeMake(self.taskTitleLabel.frame.size.width, 0)];
    self.taskTitleLabel.frame = CGRectMake(self.taskTitleLabel.frame.origin.x, self.taskTitleLabel.frame.origin.y, titleSize.width, titleSize.height);
    
    
//    self.taskContentLabel.text = @"每天8杯水,宝宝妈妈都很美!";
    self.taskContentLabel.text = task.content;
    CGSize contentSize = [self.taskContentLabel boundingRectWithSize:CGSizeMake(self.taskContentLabel.frame.size.width, 0)];
    self.taskContentLabel.frame = CGRectMake(self.taskContentLabel.frame.origin.x, self.taskContentLabel.frame.origin.y, contentSize.width, contentSize.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 24 + titleSize.height + contentSize.height);
}

@end
