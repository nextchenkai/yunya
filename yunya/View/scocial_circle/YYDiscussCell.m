//
//  YYDiscussCell.m
//  yunya
//
//  Created by 陈凯 on 16/4/11.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDiscussCell.h"

@implementation YYDiscussCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = @"YYDiscussCell";
    YYDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYDiscussCell" owner:nil options:nil] objectAtIndex:0];
        
    }
    else{
        //先把老cell内容清空移除
        [cell removeCellContent:cell];
        
    }
    return cell;
}
- (void)initView:(YYDiscussCell *)cell value:(id)value floorcount:(int)floorcount lzmemberid:(NSString *)lzmemberid{
    ForumDetail *fdatial = value;
    //头像
    //圆角
    cell.head.clipsToBounds = YES;
    cell.head.layer.cornerRadius = 15;
    if (fdatial.headimg != nil && ![fdatial.headimg isEqualToString:@""] && ![fdatial.headimg isEqualToString:@"null"]) {
        [cell.head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,fdatial.headimg]]];
    }
    
    //昵称
    cell.nickname.text = fdatial.nickname;
    
    //楼层
    cell.floor.text = [NSString stringWithFormat:@"%d楼",floorcount];
    //时间
    cell.time.text = fdatial.ctime;
    //按钮标题
    Userinfo *user = [OperateNSUserDefault readUserDefault];
    if ([user.memberid isEqualToString:[NSString stringWithFormat:@"%@",fdatial.memberid]]) {
        [cell.btn setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        [cell.btn setTitle:@"回复" forState:UIControlStateNormal];
    }
    
    //文字内容
    cell.content = [[YYEmoticonLabel alloc] init];
    [cell.contentView addSubview:cell.content];
    cell.content.sd_layout.leftSpaceToView(cell.contentView,8);
    cell.content.sd_layout.rightSpaceToView(cell.contentView,8);
    cell.content.sd_layout.topSpaceToView(cell.head,8);
    if (fdatial.tomemberid != nil && ![fdatial.tomemberid isEqualToString:[NSString stringWithFormat:@"%@",lzmemberid]]) {
        cell.content.text = [NSString stringWithFormat:@"回复 %@：%@",fdatial.tomembernickname,fdatial.content];
    }else{
        cell.content.text = fdatial.content;
    }
    
    
    if (fdatial.content != nil) {
        [cell.content reloadAttributedText];
    }
    cell.content.numberOfLines = 0;
     cell.content.sd_layout.heightIs([cell.content boundingRectWithSize:CGSizeMake(screenWidth-16, 10000)].height+8);
    
}

//防止内容被覆盖，先把原先的内容置空
- (void)removeCellContent:(YYDiscussCell *)cell{
    cell.nickname.text = @"";
    cell.floor.text = @"";
    cell.content.text = @"";
    cell.time.text = @"";
    
}
@end
