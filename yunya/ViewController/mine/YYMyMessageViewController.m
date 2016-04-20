//
//  YYMyMessageViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/13.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMyMessageViewController.h"
#import "YYMyMessageViewModel.h"
#import "YYMyMessage1TableViewCell.h"
#import "YYMyMessage2TableViewCell.h"
#import "FriendApply.h"

@interface YYMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) YYMyMessageViewModel *viewModel;

@end

@implementation YYMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的消息";
    self.viewModel = [[YYMyMessageViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self fetchApply];
}

- (void)fetchApply {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSMutableArray arrayWithArray:returnValue];
            [weakSelf.array insertObject:@"1" atIndex:0];
            [weakSelf.tableView reloadData];
        }else
        {
            weakSelf.array = [[NSMutableArray alloc] init];
            [weakSelf.array insertObject:@"1" atIndex:0];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        weakSelf.array = [[NSMutableArray alloc] init];
        [weakSelf.array insertObject:@"1" atIndex:0];
        [weakSelf.tableView reloadData];
    } WithFailureBlock:^{
        weakSelf.array = [[NSMutableArray alloc] init];
        [weakSelf.array insertObject:@"1" atIndex:0];
        [weakSelf.tableView reloadData];
    }];
    [self.viewModel fetchApplyWithDN:self.user.dn withMemberId:self.user.memberid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        YYMyMessage1TableViewCell *cell = [YYMyMessage1TableViewCell cellWithTableView:tableView];
        return cell;
    }else{
        YYMyMessage2TableViewCell *cell = [YYMyMessage2TableViewCell cellWithTableView:tableView];
        [cell setValue:self.array[indexPath.row]];
        cell.passButton.tag = indexPath.row;
        [cell.passButton addTarget:self action:@selector(pass:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        //查看提醒消息
        [self performSegueWithIdentifier:@"mestonotice" sender:nil];
    }
}

- (void)pass:(id)sender {
    UIButton *btn = sender;
    NSInteger tag = btn.tag;
    FriendApply *apply = self.array[tag];
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf.array removeObjectAtIndex:tag];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel passFriendWithid:apply.friendsid];
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
