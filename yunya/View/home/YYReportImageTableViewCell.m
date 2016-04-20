//
//  YYReportImageTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportImageTableViewCell.h"

@interface YYReportImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation YYReportImageTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYReportImageTableViewCell";
    YYReportImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYReportImageTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (void)setValue:(id)value {
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,(NSString *)value]]];
}
@end
