//
//  YYDailyTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/23.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyTableViewCell.h"
#import "Daily.h"
#import "YYDailyImgContainerView.h"
#import "YYEmoticonLabel.h"

@interface YYDailyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet YYEmoticonLabel *contentLabel;

@property (weak, nonatomic) IBOutlet YYDailyImgContainerView *imgContainerView;

@end

@implementation YYDailyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYDailyTableViewCell";
    YYDailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYDailyTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Daily *daily = (Daily *)value;
    self.timeLabel.text = daily.ctime;
    self.contentLabel.text = daily.content;
    [self.contentLabel reloadAttributedText];
    CGSize size = [self.contentLabel boundingRectWithSize:CGSizeMake(self.contentLabel.frame.size.width, 0)];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, size.width, size.height);
    self.imgContainerView.hiddenDelButton = YES;
    [self.imgContainerView setup];
    
    //假数据
//    self.imgContainerView.picPathStringsArray = @[@"http://pic31.nipic.com/20130718/12834382_112335424179_2.jpg",@"http://pic31.nipic.com/20130718/12834382_112335424179_2.jpg"];
    NSString *picStr = daily.imgurl;
    if(picStr.length>0){
        NSArray *array = [picStr componentsSeparatedByString:@","];
        NSMutableArray *resultUrlArray = [[NSMutableArray alloc] init];
        for(NSString *str in array){
            NSString *newStr = [NSString stringWithFormat:@"%@%@",imgIP,str];
            [resultUrlArray addObject:newStr];
        }
        self.imgContainerView.picPathStringsArray = resultUrlArray;
        NSLog(@"图片地址:%@",self.imgContainerView.picPathStringsArray[0]);
    }else{
        self.imgContainerView.picPathStringsArray = nil;
    }
    
    self.imgContainerView.frame = CGRectMake(self.imgContainerView.frame.origin.x, self.contentLabel.frame.origin.y + size.height + 8, self.imgContainerView.frame.size.width, self.imgContainerView.frame.size.height);
    self.editBtn.frame = CGRectMake(self.editBtn.frame.origin.x, self.imgContainerView.frame.origin.y + self.imgContainerView.frame.size.height + 8 + 8, self.editBtn.frame.size.width, self.editBtn.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.editBtn.frame.size.height + self.editBtn.frame.origin.y + 8 + 8);
}

@end
