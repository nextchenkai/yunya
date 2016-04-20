//
//  YYMyNoticeTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyNoticeTableViewCell.h"
#import "Notice.h"

@interface YYMyNoticeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YYMyNoticeTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMyNoticeTableViewCell";
    YYMyNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMyNoticeTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Notice *notice = value;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,notice.sheadimg]]];
    self.nameLabel.text = notice.snickname;
    self.contentLabel.text = notice.msgcontent;
    self.timeLabel.text = notice.ctime;
}
@end
