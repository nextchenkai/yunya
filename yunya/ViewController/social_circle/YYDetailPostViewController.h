//
//  YYDetailThreadsViewController.h
//  yunya
//
//  Created by 陈凯 on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"
#import "ForumDetail.h"
#import "Posting.h"
#import "YYDiscussCell.h"
#import "LZCell.h"

@interface YYDetailPostViewController : EMIViewController

//帖子id
@property(nonatomic,copy) NSString *postid;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;//底部约束，用于键盘出现与消失时改变其位置
@property (weak, nonatomic) IBOutlet UITextField *discussTF;//评论输入框

@property (weak, nonatomic) IBOutlet UIButton *discussBtn;//评论发表按钮
@property (weak, nonatomic) IBOutlet UITableView *detailTable;//详情table

//楼主信息
@property (strong,nonatomic) Posting *lzpost;
//楼层列表
@property (strong,nonatomic) NSMutableArray *floorlist;

//回复某人的序号
@property (assign,nonatomic) int tomemberindex;
//是否是回复给楼主
@property (assign,nonatomic) BOOL istolz;//默认为true;
@end
