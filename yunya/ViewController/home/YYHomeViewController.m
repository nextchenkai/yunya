//
//  YYHomeViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHomeViewController.h"
#import "HomeInfo.h"
#import "SCMTextButton.h"
#import "CircleMenu.h"
#import "YYHomeMomStateTableViewCell.h"
#import "YYHomeToolTableViewCell.h"
#import "YYHomeTaskTableViewCell.h"
#import "YYHomeRecTableViewCell.h"
#import "YYHomeMoreTaskViewController.h"
#import "YYRefreshHeaderView.h"

@interface YYHomeViewController ()<UITableViewDelegate,UITableViewDataSource,BEMCheckBoxDelegate>

@property (nonatomic, strong) YYHomeViewModel *viewModel;
@property (nonatomic, strong) HomeInfo *info;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *pregnantStateImageView;//怀孕状态
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;//怀孕天数
@property (weak, nonatomic) IBOutlet UILabel *leftExamLabel;
@property (weak, nonatomic) IBOutlet UILabel *babyStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepregLabel;//备孕状态显示"备孕天数",怀孕状态显示"怀孕天数"
@property (weak, nonatomic) IBOutlet UILabel *pregTestLabel;

@property (nonatomic ,strong) NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [[NSMutableArray alloc] init];
    self.viewModel = [[YYHomeViewModel alloc] initWithViewController:self];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //添加tableView头部刷新
    self.tableView.mj_header = [YYRefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(fetchHomeInfo)];
    [self.tableView.mj_header beginRefreshing];
    
    [self fetchHomeInfo];
}

- (void)fetchHomeInfo {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        weakSelf.info = (HomeInfo *)returnValue;
        [weakSelf initViews];
        
    } WithErrorBlock:^(id errorCode) {
        [weakSelf initViews];
    } WithFailureBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.viewModel fetchHomeInfoWithUserPhone:self.user.dn withType:self.user.type];
}

- (void)initViews {
    //
    //用户状态：会员类型-1还未选择用户类型 0普通家属 1备孕中 2怀孕呢 3生完宝宝”,
    self.daysLabel.text = self.info.day;
    self.leftExamLabel.text = self.info.leftexamday;
    if([self.info.type isEqualToString:@"2"]){
        self.prepregLabel.text = @"怀孕天数";
        self.pregTestLabel.text = @"孕检剩余天数";
    }else if([self.info.type isEqualToString:@"1"]){
        self.prepregLabel.text = @"备孕天数";
        self.pregTestLabel.text = @"";
        self.leftExamLabel.text = @"0";
    }else if([self.info.type isEqualToString:@"1"]){
        self.prepregLabel.text = @"宝宝出生天数";
        self.pregTestLabel.text = @"";
        self.leftExamLabel.text = @"0";
    }
    
    [self.pregnantStateImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,self.info.babyimg]] placeholderImage:[UIImage imageNamed:@"pre_preg"]];

    //添加圆形
    NSMutableArray *braceletArray = [NSMutableArray arrayWithArray:self.info.bracelet];
//    NSMutableArray *braceletArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i <8; i ++) {
//        Bracelet *bracelet = [[Bracelet alloc] init];
//        bracelet.name = [NSString stringWithFormat:@"测试%i",i];
//        bracelet.dvalue = [NSString stringWithFormat:@"%i",i];
//        [braceletArray addObject:bracelet];
//    }
    
    CircleMenu *circleMenu = [self.viewModel newCircleMenuWithArray:braceletArray];
//    circleMenu.delegate = self;
    [self.contentView addSubview:circleMenu];
    [circleMenu loadView];
    
    
    self.babyStateLabel.text = self.info.babystate;
    
    //把homeinfo的属性转为数组在tableview里展示
    self.array = [self.viewModel translateToArrayWithHomeInfo:self.info];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArray = self.array[section];
    if(section==1){
        return 1;
    }
    return rowArray.count;
}

//header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0){
        return 30.f;
    }else if(section==1){
        return 0.f;
    }
    return 20.f;
}

//cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.info.type isEqualToString:@"1"] && indexPath.section==0){
        return 0.f;
    }else{
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.bounds.size.height + 1;
    }
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rowArray = self.array[indexPath.section];
    if(indexPath.section==0){
        YYHomeMomStateTableViewCell *cell = [YYHomeMomStateTableViewCell cellWithTableView:tableView];
        [cell setValue:rowArray[indexPath.row]];
        return cell;
    }else if(indexPath.section==1){
        YYHomeToolTableViewCell *cell = [YYHomeToolTableViewCell cellWithTableView:tableView];
        cell.viewController = self;
        [cell setValue:self.info.tool];
        return cell;
    }else if(indexPath.section==2){
        YYHomeTaskTableViewCell *cell = [YYHomeTaskTableViewCell cellWithTableView:tableView];
        [cell setValue:rowArray[indexPath.row]];
        cell.checkBox.tag = indexPath.row;
        cell.checkBox.delegate = self;
        return cell;
    }else if(indexPath.section==3){
        YYHomeRecTableViewCell *cell = [YYHomeRecTableViewCell cellWithTableView:tableView];
        [cell setValue:rowArray[indexPath.row]];
        return cell;
    }
    return nil;
}

//headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0){
    //妈妈变化
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, screenWidth-16, 30)];
        label.textColor = [UIColor colorWithHexString:@"FB9BA9"];
        label.font = [UIFont systemFontOfSize:15.f];
        label.text = @"妈妈变化";
        [view addSubview:label];
        return view;
    }else if(section==1){
        return nil;
    }else if(section==2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 60, 30)];
        label.textColor = [UIColor colorWithHexString:@"FB9BA9"];
        label.font = [UIFont systemFontOfSize:15.f];
        label.text = @"今日任务";
        [view addSubview:label];
        
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-8-60, 0, 60, 30)];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor colorWithHexString:@"aeaeae"] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [moreBtn addTarget:self action:@selector(moreTask:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)moreTask:(id)sender {
    [self performSegueWithIdentifier:@"moretask" sender:nil];
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
    NSArray *rowArray = self.array[2];
    Task *task = rowArray[checkBox.tag];
    if([task.state isEqualToString:@"1"]){
        checkBox.on = YES;
    }else{
        
        if(checkBox.on){
            
            //完成任务
            __unsafe_unretained typeof(self) weakSelf = self;
            [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
                if(returnValue){
                    task.state = @"1";
                    [weakSelf.tableView reloadData];
                }
            } WithErrorBlock:^(id errorCode) {
                [weakSelf.tableView reloadData];
            } WithFailureBlock:^{
                [weakSelf.tableView reloadData];
            }];
            [self.viewModel finishTask:task WithDN:self.user.dn withMemberId:self.user.memberid];
        }else{
            checkBox.on = YES;
        }
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"moretask"]){
        YYHomeMoreTaskViewController *viewController = [segue destinationViewController];
        viewController.tasks = self.info.task;
    }else if([identifier isEqualToString:@"hometodaily"]){
    }
}


@end
