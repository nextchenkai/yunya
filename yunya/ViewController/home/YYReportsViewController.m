//
//  YYReportsViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportsViewController.h"
#import "YYReportsViewModel.h"
#import "Schedule.h"
#import "YYReportsDetailViewController.h"

@interface YYReportsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) YYReportsViewModel *viewModel;
@property (nonatomic, copy) NSString *selDate;
@end

@implementation YYReportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"schedule_add" highImageName:@"schedule_add" target:self action:@selector(addReports:)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"产检报告列表";
    self.array = [[NSArray alloc] init];
    _viewModel = [[YYReportsViewModel alloc] initWithViewController:self];
    [self initData];
}

- (void)initData {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchReportsWithDN:self.user.dn withMemberId:self.user.memberid];
}

- (void)addReports:(id)sender {
    //todo
    [self performSegueWithIdentifier:@"toaddreport" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYReportsTableViewCell"];
    cell.textLabel.text = ((Schedule *)self.array[indexPath.row]).cdate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    单击查看详情
    self.selDate = ((Schedule *)self.array[indexPath.row]).cdate;
    [self performSegueWithIdentifier:@"toreportdetail" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"toreportdetail"]){
        YYReportsDetailViewController *viewController = segue.destinationViewController;
        viewController.date = self.selDate;
    }
}


@end
