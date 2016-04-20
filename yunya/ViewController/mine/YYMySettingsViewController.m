//
//  YYMySettingsViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMySettingsViewController.h"
#import "YYMySettingNormalTableViewCell.h"
#import "YYMySettingSwitchTableViewCell.h"
#import "YYUpdateProfileViewController.h"
#import "YYPickerCellTableViewCell.h"
#import "YYMySettingViewModel.h"
#import "YYChooseCityViewController.h"
#import "YYChooseHospitalViewController.h"

@interface YYMySettingsViewController ()<UITableViewDelegate,UITableViewDataSource,YYPickerViewDelegate,YYPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;


@property (nonatomic, strong) YYMySettingViewModel *viewModel;
//年份数组
@property(nonatomic,retain) NSMutableArray *year;
//月份数组
@property(nonatomic,retain) NSMutableArray *month;
//天数数组
@property(nonatomic,retain) NSMutableArray *day;
//选择器
@property(nonatomic,strong) YYPickerView *pkview;
//预产期时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *EdcArray;

@end

@implementation YYMySettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[YYMySettingViewModel alloc] initWithViewController:self];
    //年份数组
    _year = [DateTools tenyearsFromNow];
    //月份数组
    _month = [DateTools monthMax];
    //天数数组
    _day = [DateTools dayMax];
    self.title = @"设置";
    self.array = @[@"修改个人资料",@"修改密码",@"修改预产期",@"设置产检医院",@"是否允许查看数据"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    NSInteger row = indexPath.row;
    if(row<4){
        YYMySettingNormalTableViewCell *cell = [YYMySettingNormalTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValue:self.array[row]];
        return cell;
    }else{
        YYMySettingSwitchTableViewCell *cell = [YYMySettingSwitchTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValue:self.array[row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
            //修改个人资料
        case 0:
            [self performSegueWithIdentifier:@"toupdateprofile" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"resetpsd" sender:nil];
            break;
        case 2:
            [self createYYPickerView];
            break;
        case 3:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            YYChooseHospitalViewController *viewController = [story instantiateViewControllerWithIdentifier:@"choosehospital"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            
        default:
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"toupdateprofile"]){
        YYUpdateProfileViewController *viewController = segue.destinationViewController;
        viewController.profile = self.profile;
    }
}

- (void)updatePergnantday {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf.view makeToast:@"更新预产期成功!" duration:0.8 position:CSToastPositionCenter];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel updatePergnantdayWithArray:@[self.user.dn,self.user.memberid,[self timeStr:self.EdcArray],@""]];
}

//创建时间选择器
- (void)createYYPickerView
{
    //弹出框
    YYAlertView *alert;
    
    _pkview = [[YYPickerView alloc] initWithFrame:CGRectMake(28, 30, 270, 130)];
    //默认选中到某一行
    _pkview.datasource = self;
    
    _pkview.delegate = self;
    [_pkview selectData:-1 row:1];
    [_pkview selectData:0 row:10];
    
    alert = [[YYAlertView alloc] initWithUIView:_pkview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 200) WithButtonBlock:^{
        //确定按钮事件
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;
        //开始设置个人预产期
        [self updatePergnantday];
    }];
    [alert setLabelText:@"选择预产期"];
    _EdcArray = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
        
    
    
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}
//列数 column
- (NSInteger)numberOfColumnsInYYPickerView:(YYPickerView *)yypickerview{
    return 3;
    
}
//行数 row
- (NSInteger)yypickerview:(YYPickerView *)yypickerview numberOfRowsInColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return _year.count;
            break;
        case 1:
            return _month.count;
            break;
        case 2:
            return _day.count;
            break;
        default:
            return 0;
            break;
    }
    
}
//某列cell的类型（可自定义的cell） 及内容
- (UITableViewCell *)tableview:(UITableView *)tableview cellForColumn:(NSInteger)column atRow:(NSInteger)row{
    //设置一个最大size
    CGSize maxsize = CGSizeMake(screenWidth,screenHeight);
    
    YYPickerCellTableViewCell *pickcell = [YYPickerCellTableViewCell cellWithTableView:tableview];
    
    switch (column) {
        case 0:
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_year objectAtIndex:row],@"年"]];
            //文字大小
            CGSize size = [pickcell.titleLabel boundingRectWithSize:maxsize];
            //分割线位置
            [pickcell setLineFrame:size];
            return pickcell;
            break;
        case 1:
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_month objectAtIndex:row],@"月"]];
            //文字大小
            CGSize size1 = [pickcell.titleLabel boundingRectWithSize:maxsize];
            //分割线位置
            [pickcell setLineFrame:size1];
            return pickcell;
            break;
        case 2:
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_day objectAtIndex:row],@"日"]];
            //文字大小
            CGSize size2 = [pickcell.titleLabel boundingRectWithSize:maxsize];
            //分割线位置
            [pickcell setLineFrame:size2];
            return pickcell;
            break;
        default:
            return nil;
            break;
    }
    
    
}
//某列cell宽度
- (CGFloat)widthForCellInColumn:(NSInteger)column{
    switch (column) {
        case 0:
            return 100;
            break;
        case 1:
            return 82;
            break;
        case 2:
            return 81;
            break;
        default:
            return 0;
            break;
    }
}
//某行cell高度
- (CGFloat)heightForCellInRow:(YYPickerView *)yypickerview{
    return 40;
}
//可视区域的cell个数
- (NSInteger)numberOfVisibleCell:(YYPickerView *)yypickerview{
    return 3;
}

//选择了某一行的某一列触发
- (void)yypickerview:(YYPickerView *)yypickerview didselectColumn:(NSInteger)column atRow:(NSInteger)row{
    switch (column) {
        case 0:
            
                [_EdcArray replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                [self judgeIsNeedRefreshDay:_EdcArray];
            break;
        case 1:
                [_EdcArray replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                [self refreshday:[_EdcArray objectAtIndex:1] year:[_EdcArray objectAtIndex:0]];
                        //更新day的数据
            break;
        case 2:
                [_EdcArray replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_EdcArray);
            break;
            
        default:
            break;
    }
}

//判断是否需要更新day
- (void)judgeIsNeedRefreshDay:(NSMutableArray *)array{
    //假如是二月，就要刷新天
    if ([[array objectAtIndex:1] isEqualToString:@"02"]) {
        [self refreshday:[array objectAtIndex:1] year:[array objectAtIndex:0]];
    }
}

//更新day的数据

- (void)refreshday:(NSString *)month year:(NSString *)year{
    _day =  [DateTools dayInMonth:month year:year];
    [_pkview reloadData:2];
    [_pkview selectData:2 row:1];
}
//把时间数组转为“2015-09-01”类型字符串
- (NSString *)timeStr:(NSMutableArray *)array{
    if (array!=nil) {
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",[array objectAtIndex:0],@"-",[array objectAtIndex:1],@"-",[array objectAtIndex:2]];
        return str;
    }else{
        return @"";
    }
    
}


@end
