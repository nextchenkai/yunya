//
//  YYMusicTableViewCell.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMusicTableViewCell.h"
#import "MusicFile.h"
@interface YYMusicTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YYMusicTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YYMusicTableViewCell";
    YYMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYMusicTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setValue:(id)value {
    MusicFile *music = value;
    self.nameLabel.text = music.name;
}

@end
