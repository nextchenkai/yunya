//
//  YYHomeMomStateTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/21.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeMomStateTableViewCell.h"

@interface YYHomeMomStateTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation YYHomeMomStateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYHomeMomStateTableViewCell";
    YYHomeMomStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeMomStateTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    self.contentLabel.text = (NSString *)value;
    CGSize size = [self.contentLabel boundingRectWithSize:CGSizeMake(self.contentLabel.frame.size.width, 0)];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, size.width, size.height);
    self.frame = CGRectMake(0, 0, self.frame.size.width, size.height + 16);
}

//- (void)setValue:(id)value {
//    NSMutableArray *array = [NSMutableArray arrayWithArray:(NSArray *)value];
//    Tool *toolAdd = [[Tool alloc] init];
//    toolAdd.name = @" ";
//    [array addObject:toolAdd];
//    
//    for(int i = 0;i<array.count;i ++){
//        Tool *tool = array[i];
//        YYHomeButton *button = [[YYHomeButton alloc] initWithFrame:CGRectMake(8+i*80, 0, 80, 80)];
//        if([tool.name isEqualToString:@"每日记录"]){
//            [button setImage:[UIImage imageNamed:@"index_jilu"] forState:UIControlStateNormal];
//        }else if([tool.name isEqualToString:@"孕检报告"]){
//            [button setImage:[UIImage imageNamed:@"index_yunjian"] forState:UIControlStateNormal];
//        }else if([tool.name isEqualToString:@"产检时间表"]){
//            [button setImage:[UIImage imageNamed:@"index_shijianbiao"] forState:UIControlStateNormal];
//        }
//        if([tool.name isEqualToString:@" "]){
//            [button setImage:[UIImage imageNamed:@"index_more"] forState:UIControlStateNormal];
//        }
//        [button setTitle:tool.name forState:UIControlStateNormal];
//        
//        [self.scrollView addSubview:button];
//    }
//    self.scrollView.contentSize = CGSizeMake(88*array.count+8, 0);
//}
//
//- (void)setValue:(id)value {
//    Task *task = (Task *)value;
//    self.taskTitleLabel.text = task.title;
//    self.taskContentLabel.text = task.content;
//}
@end
