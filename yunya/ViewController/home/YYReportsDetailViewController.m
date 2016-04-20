//
//  YYReportsDetailViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportsDetailViewController.h"
#import "YYReportDetailViewModel.h"
#import "YYReportTimeTableViewCell.h"
#import "YYReportImageTableViewCell.h"
#import "YYReportItemTableViewCell.h"
#import "Inspect.h"

@interface YYReportsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) YYReportDetailViewModel *viewModel;
@end

@implementation YYReportsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[YYReportDetailViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"产检报告详情";
    self.array = [[NSArray alloc] init];
    [self initData];
}

- (void)initData {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:returnValue];
            weakSelf.array = [dict objectForKey:@"data"];
            weakSelf.imgurl = [dict objectForKey:@"imgurl"];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchReportWithDN:self.user.dn withMemberId:self.user.memberid withDate:self.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.imgurl){
        return self.array.count + 2;
    }else{
        return self.array.count + 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return 1;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 1;
        }
    }
    return ((NSArray *)(((Inspect *)(self.array[section-1])).detail)).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==0){
        YYReportTimeTableViewCell *cell = [YYReportTimeTableViewCell cellWithTableView:tableView];
        [cell setValue:self.date];
        return cell;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            YYReportImageTableViewCell *cell = [YYReportImageTableViewCell cellWithTableView:tableView];
            NSArray *a = [self.imgurl componentsSeparatedByString:@","];
            [cell setValue:a[0]];
            return cell;
        }
    }
    YYReportItemTableViewCell *cell = [YYReportItemTableViewCell cellWithTableView:tableView];
    [cell setValue:((NSArray *)(((Inspect *)(self.array[section-1])).detail))[row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return 0.f;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 5.f;
        }
    }
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    NSInteger section = indexPath.section;
    if(section==0){
        return 44.f;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 96.f;
        }
    }
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return nil;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return nil;
        }
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"FB9BA9" alpha:0.3f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-20, 30)];
    label.text = ((Inspect *)(self.array[section-1])).title;
    label.font = [UIFont systemFontOfSize:14.f];
    [view addSubview:label];
    return view;
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
