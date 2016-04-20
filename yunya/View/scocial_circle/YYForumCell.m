//
//  YYForumCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYForumCell.h"
#import "Posting.h"

@implementation YYForumCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYForumCell";
    YYForumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYForumView" owner:nil options:nil] objectAtIndex:0];
    }
    else{
        //先把老cell内容清空移除
//        [cell removeCellContent:cell];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYForumView" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}

- (void)initView:(YYForumCell *)cell value:(id)value{
    Posting *post = value;
    //todo 通过会员是否是医生判断是否置顶
//    if ([post.isdoctor isEqualToString:@"2"]) {
        cell.topWidth.constant = 0;
    cell.titleToTopLeft.constant = 6;
//    }
//    else{
//        cell.topWidth.constant = 40;
//        cell.titleToTopLeft.constant = 8;
//    }
    //标题
    cell.titleLabel.text = post.title;
    //内容
    cell.contentLabel.text = post.content;
    cell.contentHeight.constant = [cell.contentLabel boundingRectWithSize:CGSizeMake(screenWidth-16, 35)].height;
    //展示表情
    if (post.content != nil) {
        [cell.contentLabel reloadAttributedText];
    }
    
    
    //头像
    //圆角
    cell.headImg.clipsToBounds = YES;
    cell.headImg.layer.cornerRadius = 15;
    if (post.headimg != nil && ![post.headimg isEqualToString:@""] && ![post.headimg isEqualToString:@"null"]) {
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,post.headimg]]];
    }
    
    //昵称
    cell.nicknameLabel.text = post.nickname;
    //时间
    cell.timeLabel.text = post.ctime;
    //回帖量
    cell.answerLabel.text = post.count;
    //内容图片
    if (post.imgurl == nil || [post.imgurl isEqualToString:@""] || [post.imgurl isEqualToString:@"null"]) {
        cell.contentImgHeight.constant  = 0;
    }else{
        cell.contentImgHeight.constant  = 63;
        NSArray *imgurlarray = [post.imgurl componentsSeparatedByString:@","];
        NSMutableArray *imgurlmutablearray = [NSMutableArray arrayWithArray:imgurlarray];
        
        //todo
        int count = (int)(imgurlarray.count);
        if (imgurlarray.count > 2) {
            count = 2;
            [imgurlmutablearray removeAllObjects];
            [imgurlmutablearray addObject:[imgurlarray objectAtIndex:0]];
            [imgurlmutablearray addObject:[imgurlarray objectAtIndex:1]];
        }
        //todo
        
        for (int i = 0; i<count; i++) {
            [imgurlmutablearray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@%@",imgIP,[imgurlarray objectAtIndex:i]]];
        }
        
        [cell.contentImg setup];
        [cell.contentImg setPicPathStringsArray:imgurlmutablearray];
    }
}

//防止内容被覆盖，先把原先的内容置空
//- (void)removeCellContent:(YYForumCell *)cell{
////    NSArray *views = cell.contentView.subviews;
////    for (UIView *view in views ) {
////        [view removeFromSuperview];
////    }
//    while ([cell.contentView.subviews lastObject] != nil) {
//        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//    }
//}

@end
