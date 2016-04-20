//
//  YYMyPostsViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/5.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyPostsViewController.h"
#import "YYMyPostTableViewCell.h"
#import "YYRefreshHeaderView.h"
#import "YYAutoFooterView.h"
#import "YYMyPostViewModel.h"
#import "YYDetailPostViewController.h"
#import "Posting.h"
#import "YYHomeDailyButton.h"

@interface YYMyPostsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YYMyPostViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation YYMyPostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [[NSMutableArray alloc] init];
    
    self.title = @"我发布的帖子";
    self.viewModel = [[YYMyPostViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //TODO 二期 设置下拉刷新和上拉加载
    self.tableView.mj_header = [YYRefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [YYAutoFooterView footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

//- (void)fetchPosting {
//    __unsafe_unretained typeof(self) weakSelf = self;
//    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
//        if(returnValue){
//            weakSelf.array = [NSMutableArray arrayWithArray:returnValue];
//        }
//        [weakSelf.tableView reloadData];
//    } WithErrorBlock:^(id errorCode) {
//        
//    } WithFailureBlock:^{
//        
//    }];
//    [self.viewModel fetchPostingWithUserPhone:self.user.dn withMemberId:self.user.memberid];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNewData {
    self.currentPage = 0;
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if((NSDictionary*)returnValue){
            if(returnValue){
                weakSelf.array = [NSMutableArray arrayWithArray:returnValue];
            }
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.viewModel fetchPostingWithUserPhone:self.user.dn withMemberId:self.user.memberid withCurrentpage:self.currentPage];
}

- (void)loadMoreData {
    self.currentPage ++;
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf.array addObjectsFromArray:(NSArray *)returnValue];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.tableView reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        weakSelf.currentPage --;
        [weakSelf.tableView.mj_footer endRefreshing];
    } WithFailureBlock:^{
        weakSelf.currentPage --;
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    [self.viewModel fetchPostingWithUserPhone:self.user.dn withMemberId:self.user.memberid withCurrentpage:self.currentPage];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYMyPostTableViewCell *cell = [YYMyPostTableViewCell cellWithTableView:tableView];
    [cell setValue:self.array[indexPath.row]];
    cell.delPostButton.tag = indexPath.row;
    [cell.delPostButton addTarget:self action:@selector(delPost:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYMyPostTableViewCell *cell = (YYMyPostTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转帖子详情
    Posting *posting = self.array[indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Circle" bundle:nil];
    YYDetailPostViewController *viewController = [story instantiateViewControllerWithIdentifier:@"detailpost"];
    viewController.postid = posting.forumid;
    [self.navigationController pushViewController:viewController animated:YES];
}
//删除帖子
- (void)delPost:(YYHomeDailyButton *)sender {
    Posting *posting = self.array[sender.tag];
    [_viewModel fetchDeletePostWithUserPhone:self.user.dn withIsDoctor:self.user.isdoctor withMemberId:self.user.memberid withForumid:posting.forumid];
    __unsafe_unretained __typeof(self) weakSelf = self;
    [_viewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf loadNewData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
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
