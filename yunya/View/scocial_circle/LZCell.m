//
//  LZCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "LZCell.h"

@implementation LZCell



+ (instancetype)cellWithTableView:(UITableView *)tableView value:(id)value{
    NSString *identifier = @"LZCell";
    LZCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LZCell" owner:nil options:nil] objectAtIndex:0];
        [cell initView:cell value:value];
    }
    else{
        [cell initView:cell value:value];
    }
    return cell;
}

- (void)initView:(LZCell *)cell value:(id)value{
    Posting *post = value;
    
    
    //头像
    //圆角
    cell.headimg.clipsToBounds = YES;
    cell.headimg.layer.cornerRadius = 15;
    if (post.headimg != nil && ![post.headimg isEqualToString:@""] && ![post.headimg isEqualToString:@"null"]) {
        [cell.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,post.headimg]]];
    }
    
    //昵称
    cell.nicname.text = post.nickname;

    
    //标题
    cell.title = [[UILabel alloc] init];
    [cell.contentView addSubview:cell.title];
    cell.title.sd_layout.leftSpaceToView(cell.contentView,8);
    cell.title.sd_layout.rightSpaceToView(cell.contentView,8);
    cell.title.sd_layout.topSpaceToView(cell.headimg,8);
    cell.title.font = [UIFont systemFontOfSize:17 weight:100];
    cell.title.text = post.title;
    cell.title.numberOfLines = 0;
    cell.title.sd_layout.heightIs([cell.title boundingRectWithSize:CGSizeMake(screenWidth-16, 10000)].height+8);
    //文字内容
    cell.content = [[YYEmoticonLabel alloc] init];
    [cell.contentView addSubview:cell.content];
    cell.content.sd_layout.leftSpaceToView(cell.contentView,8);
    cell.content.sd_layout.rightSpaceToView(cell.contentView,8);
    cell.content.sd_layout.topSpaceToView(cell.title,8);
    cell.content.font = [UIFont systemFontOfSize:16];
    cell.content.textColor = [UIColor colorWithHexString:@"898989"];
    cell.content.text = post.content;
    cell.content.numberOfLines = 0;
    if (post.content != nil) {
        [cell.content reloadAttributedText];
    }
    cell.content.sd_layout.heightIs([cell.content boundingRectWithSize:CGSizeMake(screenWidth-16, 10000)].height+8);
    //图片内容
    if (post.imgurl != nil && ![post.imgurl isEqualToString:@""] && ![post.imgurl isEqualToString:@"null"]) {
        NSArray *imgarray = [post.imgurl componentsSeparatedByString:@","];
        NSMutableArray *imgmutablearray = [NSMutableArray arrayWithArray:imgarray];
        cell.imgcontent = [[YYDetailPostImgView alloc] initWithImgArray:imgmutablearray frame:CGRectMake(8, 0, screenWidth-16, (400+4)*imgarray.count)];
        [cell.contentView addSubview:cell.imgcontent];
        cell.imgcontent.sd_layout.leftSpaceToView(cell.contentView,8);
        cell.imgcontent.sd_layout.rightSpaceToView(cell.contentView,8);
        cell.imgcontent.sd_layout.topSpaceToView(cell.content,8);
        cell.imgcontent.sd_layout.heightIs((400+8)*imgarray.count);
    }
    //时间
    cell.time.text = post.ctime;
    //回复量
    cell.discusscount.text = post.count;
    
}
@end
