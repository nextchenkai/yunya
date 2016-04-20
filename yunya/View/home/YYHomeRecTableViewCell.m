//
//  YYHomeRecTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeRecTableViewCell.h"

@interface YYHomeRecTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation YYHomeRecTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYHomeRecTableViewCell";
    YYHomeRecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeRecTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Recommend *rec = (Recommend *)value;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,rec.imgrul]] placeholderImage:[UIImage imageNamed:@"pre_preg"]];
    self.contentLabel.text = rec.content;
    CGSize size = [self.contentLabel boundingRectWithSize:CGSizeMake(self.contentLabel.frame.size.width, 0)];
    if(size.height>44){
        self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, size.width, size.height);
        self.frame = CGRectMake(0, 0, self.frame.size.width, size.height + 16);
    }
    NSLog(@"\n图片宽度:%f",self.imgView.frame.size.width);
    NSLog(@"\n内容的X:%f",self.contentLabel.origin.x);
}

@end
