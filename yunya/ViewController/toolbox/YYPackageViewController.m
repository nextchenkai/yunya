//
//  YYPackageViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPackageViewController.h"
#import "YYPackageTableViewCell.h"
#import "Package.h"

@interface YYPackageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) YYPackageViewModel *viewModel;

@end

@implementation YYPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"待产包";
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarMetricsDefault target:self action:@selector(savePackage)];
    
    self.array = [[NSArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    _viewModel = [[YYPackageViewModel alloc] initWithViewController:self];
    
    [self getPackage];
    
    
}

/**
 *  获取待产包Array
 */
- (void)getPackage {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];

    [self.viewModel fetchPackageWithDN:self.user.dn withMemberId:self.user.memberid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYPackageTableViewCell *cell = [YYPackageTableViewCell cellWithTableView:tableView];
    [cell setValue:self.array[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    Package *package = self.array[indexPath.row];
    if([package.isready isEqualToString:@"1"]){
        package.isready = @"0";
    }else{
        package.isready = @"1";
    }
    
    [self savePackage:package];
    
    
}

- (void)savePackage:(Package *)package {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            if([returnValue isEqualToString:@"1"]){
                for (Package *mPackage in weakSelf.array) {
                    if([mPackage.id isEqualToString:package.id]){
                        mPackage.isready = package.isready;
                    }
                }
            }
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [self.viewModel savePackage:package withUser:self.user];
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
