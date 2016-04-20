//
//  YYMyPostTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyPostTableViewCell.h"


@interface YYMyPostTableViewCell()


@end

@implementation YYMyPostTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMyPostTableViewCell";
    YYMyPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMyPostTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    Posting *posting = value;
    self.timeLabel.text = posting.ctime;
    //设置标题
    self.titleLabel.text = posting.title;
    CGSize size = [self.titleLabel boundingRectWithSize:CGSizeMake(self.titleLabel.frame.size.width, 0)];
    self.contentLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, size.width, size.height);
    //设置内容
    self.contentLabel.text = posting.content;
    CGSize consize = [self.contentLabel boundingRectWithSize:CGSizeMake(self.contentLabel.frame.size.width, 0)];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, consize.width, consize.height);
    //图片
    self.imageViews.hiddenDelButton = YES;
    NSString *picStr = posting.imgurl;
    if(picStr.length>0){
        NSArray *array = [picStr componentsSeparatedByString:@","];
        NSMutableArray *resultUrlArray = [[NSMutableArray alloc] init];
        for(NSString *str in array){
            NSString *newStr = [NSString stringWithFormat:@"%@%@",imgIP,str];
            [resultUrlArray addObject:newStr];
        }
        self.imageViews.picPathStringsArray = resultUrlArray;
    }else{
        self.imageViews.picPathStringsArray = nil;
    }
    
    //评论数量
    [self.commentCountButton setTitle:posting.count forState:UIControlStateNormal];
    
    self.imageViews.frame = CGRectMake(self.imageViews.frame.origin.x, self.contentLabel.frame.origin.y + size.height + 16 + consize.height, self.imageViews.frame.size.width, self.imageViews.frame.size.height);
    
    self.commentCountButton.frame = CGRectMake(self.commentCountButton.frame.origin.x, self.imageViews.frame.origin.y + self.imageViews.frame.size.height + 8 + 8, self.commentCountButton.frame.size.width, self.commentCountButton.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.commentCountButton.frame.size.height + self.commentCountButton.frame.origin.y + 8 + 8);
}
@end
