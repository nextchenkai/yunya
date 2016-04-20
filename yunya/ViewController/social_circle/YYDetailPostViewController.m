//
//  YYDetailThreadsViewController.m
//  yunya
//
//  Created by 陈凯 on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDetailPostViewController.h"

@interface YYDetailPostViewController ()

//viewmodel
@property (strong,nonatomic)YYDetailPostViewModel *viewmodel;

@end

@implementation YYDetailPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帖子详情";
    
    _istolz = YES;
    
    [self beautifyView];
    
    //viewmodel
    _viewmodel = [[YYDetailPostViewModel alloc] initWithViewController:self];

    [self fetchDetailPost];
}


//美化视图
- (void)beautifyView{
    
    //需要设置一个通知，获取系统的键盘显示和隐藏消息，然后做出位置改变的操作
    //这里的UIKeyboardWillShowNotification时系统自带的
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];

    //添加一个手势用于隐藏键盘
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapgesture];
    
    //发表按钮
    _discussBtn.layer.masksToBounds = YES;
    _discussBtn.layer.cornerRadius = 10;
    _discussBtn.layer.borderWidth = 1;
    _discussBtn.layer.borderColor = [UIColor cgcolorWithHexString:@"AEAEAE"];
    
    //table
    _floorlist = [NSMutableArray arrayWithCapacity:0];
    _detailTable.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
}


//请求帖子详情数据
- (void)fetchDetailPost{
    
    __unsafe_unretained typeof(self) weakself = self;
    
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        if (returnValue) {
            NSLog(@"%@",returnValue);
            //楼主信息
            _lzpost = [Posting mj_objectWithKeyValues:returnValue];
            //楼下
            _floorlist = [NSMutableArray arrayWithArray:[returnValue objectForKey:@"forumdetail"]];
            
            [weakself.detailTable reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    NSDictionary *dic = @{@"dn":self.user.dn,@"forumid":_postid};
    
    [_viewmodel fetchDetailPostWithDic:dic];
    
    
}
/**
 *  发布帖子
 *
 *  @param sender
 */
- (IBAction)sendDiscuss:(UIButton *)sender {
    if ([_discussTF.text isEqualToString:@""]) {
        [self.view makeToast:@"内容不能为空" duration:1.0 position:CSToastPositionCenter];
    }
    else{
        NSDictionary *dic;
        //回复给楼主
        if (_istolz) {
            dic = @{@"dn":self.user.dn,@"isdoctor":self.user.isdoctor,@"content":_discussTF.text,@"memberid":self.user.memberid,@"forumid":_lzpost.forumid,@"tomemberid":_lzpost.memberid,@"tomemberisdoctor":_lzpost.isdoctor};
            
        }else{
            dic = @{@"dn":self.user.dn,@"isdoctor":self.user.isdoctor,@"content":_discussTF.text,@"memberid":self.user.memberid,@"forumid":_lzpost.forumid,@"forumdetailid":[[_floorlist objectAtIndex:_tomemberindex] objectForKey:@"forumdetailid"],@"tomemberid":[[_floorlist objectAtIndex:_tomemberindex] objectForKey:@"memberid"],@"tomemberisdoctor":[[_floorlist objectAtIndex:_tomemberindex] objectForKey:@"isdoctor"]};
            //默认回复楼主，除非通过点击回复按钮
            _istolz = YES;
        }
        
        //回调
        [_viewmodel fetchReplyPostWithDic:dic];
        __unsafe_unretained typeof(self) weakself = self;
        [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
            
            
            //取消第一响应
            [weakself.discussTF resignFirstResponder];
            weakself.discussTF.text = @"";
            //刷新数据
            [weakself fetchDetailPost];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];

    }
    
    
    
}

//键盘显示的时候，按钮向上跑，不会被遮盖
-(void)keyboardShow:(NSNotification *)notification{
    //  键盘退出的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _bottom.constant = 2+frame.size.height;
    
    
    
}
//键盘隐藏是，按钮向下回到原先的位置
//这里面尝试一个动画，和没有动画，直接确定位置是一个效果，差不多
-(void)keyboardHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        _bottom.constant = 2;
        
    }completion:^(BOOL finished){
        _istolz = YES;
    }];
}

- (void)hideKeyboard{
    if ([_discussTF isFirstResponder]) {
        [_discussTF resignFirstResponder];
    }
}


//tableview数据源及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if (_lzpost != nil) {
                
                return 1;
            }else{
                return 0;

            }
            
            break;
        case 1:
            return _floorlist.count;
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LZCell *cell = [LZCell cellWithTableView:tableView value:_lzpost];
        return cell;
    }
    if (indexPath.section == 1) {
        ForumDetail *fdatial = [ForumDetail mj_objectWithKeyValues:[_floorlist objectAtIndex:indexPath.row]];
        YYDiscussCell *cell = [YYDiscussCell cellWithTableView:tableView];
        [cell initView:cell value:fdatial floorcount:(int)(indexPath.row+1) lzmemberid:_lzpost.memberid];
        //回复删除按钮
        cell.btn.tag = indexPath.row;
        [cell.btn addTarget:self action:@selector(replyORdelete:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

//section之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    if (section == 0) {
        return 20;
    }
   
    if (section == 1) {
        return 0;
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
        view.backgroundColor = [UIColor colorWithHexString:@"F5F0F1"];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LZCell *lzcell = (LZCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return (CGRectGetMaxY(lzcell.headimg.frame)+CGRectGetMaxY(lzcell.title.frame)+CGRectGetMaxY(lzcell.content.frame)+CGRectGetMaxY(lzcell.imgcontent.frame)+45);
    }
    if (indexPath.section == 1) {
        YYDiscussCell *ydcell = (YYDiscussCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];;
        return (CGRectGetMaxY(ydcell.head.frame)+CGRectGetMaxY(ydcell.content.frame)+45);
    }
    return 0;
}

//若此贴为会员自己所发，可以有滑动删除功能
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.user.memberid isEqualToString:[NSString stringWithFormat:@"%@",_lzpost.memberid]]) {
        return YES;
    }
    else{
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = @{@"dn":self.user.dn,@"isdoctor":self.user.isdoctor,@"memberid":self.user.memberid,@"forumdetailid":[[_floorlist objectAtIndex:indexPath.row] objectForKey:@"forumdetailid"]};
    [_viewmodel fetchDeletePostWithDic:dic];
    //回调
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //刷新数据
        [weakself fetchDetailPost];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    return @"删除";
}

//回复或删除
- (void)replyORdelete:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"回复"]) {
        _istolz = NO;
        _tomemberindex = (int)sender.tag;
        if ([_discussTF isFirstResponder]) {
            [_discussTF resignFirstResponder];
            [_discussTF becomeFirstResponder];
        }
        else{
            [_discussTF becomeFirstResponder];
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        NSDictionary *dic = @{@"dn":self.user.dn,@"isdoctor":self.user.isdoctor,@"memberid":self.user.memberid,@"forumdetailid":[[_floorlist objectAtIndex:sender.tag] objectForKey:@"forumdetailid"]};
        [_viewmodel fetchDeletePostWithDic:dic];
        //回调
        __unsafe_unretained typeof(self) weakself = self;
        [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
            //刷新数据
            [weakself fetchDetailPost];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
