//
//  YYHomeRecordViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyViewController.h"
#import "YYDailyViewModel.h"
#import "YYRefreshHeaderView.h"
#import "YYAutoFooterView.h"
#import "YYDailyTableViewCell.h"
#import "Daily.h"
#import "YYDailyAddViewController.h"

@interface YYDailyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) YYDailyViewModel *viewModel;

//待修改
@property (nonatomic ,strong) Daily *selDaily;
//待删除
@property (nonatomic ,strong) Daily *delDaily;
@end

@implementation YYDailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"每日记录";
    self.viewModel = [[YYDailyViewModel alloc] initWithViewController:self];
    self.array = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //设置下拉刷新和上拉加载
    self.tableView.mj_header = [YYRefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [YYAutoFooterView footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNewData {
    self.currentPage = 0;
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            
            weakSelf.array = [NSMutableArray arrayWithArray:returnValue];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.viewModel fetchRecordWithUserPhone:self.user.dn withMemberId:self.user.memberid withPage:self.currentPage];
    //假数据
//    Daily *daily = [[Daily alloc] init];
//    daily.ctime = @"2016-03-24 12:40:39";
//    daily.content = @"我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!我就是一条每日记录!";
//    [self.array addObject:daily];
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData {
    self.currentPage ++;
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf.array addObjectsFromArray:(NSArray *)returnValue];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        weakSelf.currentPage --;
        [weakSelf.tableView.mj_footer endRefreshing];
    } WithFailureBlock:^{
        weakSelf.currentPage --;
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    [self.viewModel fetchRecordWithUserPhone:self.user.dn withMemberId:self.user.memberid withPage:self.currentPage];
}
#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYDailyTableViewCell *cell = (YYDailyTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYDailyTableViewCell *cell = [YYDailyTableViewCell cellWithTableView:tableView];
    [cell setValue:self.array[indexPath.row]];
    cell.editBtn.tag = indexPath.row;
    cell.delBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(EditDaily:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delBtn addTarget:self action:@selector(DelDaily:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)EditDaily:(id)sender {
    YYHomeDailyButton *editBtn = sender;
    NSInteger tag = editBtn.tag;
    self.selDaily = self.array[tag];
    [self performSegueWithIdentifier:@"editdaily" sender:self];
}

- (void)DelDaily:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除每日记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    YYHomeDailyButton *editBtn = sender;
    NSInteger tag = editBtn.tag;
    
    _delDaily = self.array[tag];
    if(!_delDaily.dn){
        _delDaily.dn = self.user.dn;
    }
    if(!_delDaily.memberid){
        _delDaily.memberid = self.user.memberid;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==1){
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
            if(returnValue){
                NSMutableArray *result = [NSMutableArray arrayWithArray:weakSelf.array];
                [result removeObject:weakSelf.delDaily];
                weakSelf.array = [NSMutableArray arrayWithArray:result];
                [weakSelf.tableView reloadData];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        [self.viewModel deleteDaily:_delDaily];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editdaily"]){
        YYDailyAddViewController *viewController = [segue destinationViewController];
        viewController.daily = _selDaily;
    }else if([segue.identifier isEqualToString:@"adddaily"]){
        YYDailyAddViewController *viewController = [segue destinationViewController];
    }
}


@end
