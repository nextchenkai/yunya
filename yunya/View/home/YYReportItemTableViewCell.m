//
//  YYReportItemTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportItemTableViewCell.h"
#import "InspectDetail.h"

@interface YYReportItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation YYReportItemTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYReportItemTableViewCell";
    YYReportItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYReportItemTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    
    InspectDetail *detail = value;
    self.itemLabel.text = detail.title;
    if(!detail.svalue){
        detail.svalue = @"";
    }
    if(!detail.unit){
        detail.unit = @"";
    }
    self.valueLabel.text = [NSString stringWithFormat:@"%@ %@",detail.svalue,detail.unit];
}
@end
