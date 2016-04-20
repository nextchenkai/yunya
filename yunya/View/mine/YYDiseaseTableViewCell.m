//
//  YYDiseaseTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDiseaseTableViewCell.h"
#import "Disease.h"

@interface YYDiseaseTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;

@end

@implementation YYDiseaseTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYDiseaseTableViewCell";
    YYDiseaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYDiseaseTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Disease *disease = value;
    self.nameLabel.text = disease.name;
    self.checkBox.on = disease.isCheck;
}

@end
