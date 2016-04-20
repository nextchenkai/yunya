//
//  YYPackageTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPackageTableViewCell.h"
#import "Package.h"

@interface YYPackageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;

@end

@implementation YYPackageTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYPackageTableViewCell";
    YYPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPackageTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    
    Package *package = value;
    self.itemNameLabel.text = package.name;
    self.countLabel.text = [NSString stringWithFormat:@"%@%@",package.num,package.unit];
    if([package.isready isEqualToString:@"1"]){
        self.checkBox.on = YES;
    }else{
        self.checkBox.on = NO;
    }
}

@end
