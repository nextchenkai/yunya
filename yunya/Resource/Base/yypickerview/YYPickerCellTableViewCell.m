//
//  YYPickerCellTableViewCell.m
//  yunya
//
//  Created by 陈凯 on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPickerCellTableViewCell.h"

@implementation YYPickerCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    

    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYPickerCell";
    YYPickerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPickerCell" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}


//设置label文字
- (void)setLabelText:(NSString *)title{
    _titleLabel.text = title;
}
- (void)setLineFrame:(CGSize)size{
    _linewidth.constant = size.width+4;
}
@end
