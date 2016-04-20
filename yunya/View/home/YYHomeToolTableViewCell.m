//
//  YYHomeToolTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeToolTableViewCell.h"
#import "YYHomeButton.h"

@interface YYHomeToolTableViewCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YYHomeToolTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYHomeToolTableViewCell";
    YYHomeToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeToolTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
//    NSMutableArray *array = [[NSMutableArray alloc] init];
    Tool *daily = [[Tool alloc] init];
    daily.name = @"每日记录";
    Tool *test = [[Tool alloc] init];
    test.name = @"孕检报告";
    Tool *time = [[Tool alloc] init];
    time.name = @"产检时间表";
    
    Tool *toolAdd = [[Tool alloc] init];
    toolAdd.name = @" ";
    NSArray *array = @[daily,test,time,toolAdd];
    
    for(int i = 0;i<array.count;i ++){
        Tool *tool = array[i];
        YYHomeButton *button = [[YYHomeButton alloc] initWithFrame:CGRectMake(8+i*80, 0, 80, 80)];
        if([tool.name isEqualToString:@"每日记录"]){
            [button setImage:[UIImage imageNamed:@"index_jilu"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toDaily) forControlEvents:UIControlEventTouchUpInside];
        }else if([tool.name isEqualToString:@"孕检报告"]){
            [button setImage:[UIImage imageNamed:@"index_yunjian"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toReport) forControlEvents:UIControlEventTouchUpInside];
        }else if([tool.name isEqualToString:@"产检时间表"]){
            [button setImage:[UIImage imageNamed:@"index_shijianbiao"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toSchedule) forControlEvents:UIControlEventTouchUpInside];
        }
        if([tool.name isEqualToString:@" "]){
            [button setImage:[UIImage imageNamed:@"index_more"] forState:UIControlStateNormal];
        }
        [button setTitle:tool.name forState:UIControlStateNormal];
        
        [self.scrollView addSubview:button];
    }
    self.scrollView.contentSize = CGSizeMake(88*array.count+8, 0);
}

- (void)toDaily {
    [self.viewController performSegueWithIdentifier:@"hometodaily" sender:nil];
}
- (void)toReport {
    [self.viewController performSegueWithIdentifier:@"toreport" sender:nil];
}
- (void)toSchedule {
    [self.viewController performSegueWithIdentifier:@"toschedule" sender:nil];
}
@end
