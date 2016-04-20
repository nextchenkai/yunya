//
//  YYMineViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMineViewController.h"
#import "YYMineViewModel.h"
#import "PersonalProfile.h"
#import "YYOptStatusViewController.h"
#import "YYMySettingsViewController.h"
#import "YYLoginViewController.h"

@interface YYMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
@property (weak, nonatomic) IBOutlet UILabel *currentCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *myHospitalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) PersonalProfile *profile;//个人资料
@property (nonatomic, strong) YYMineViewModel *viewModel;

@end

@implementation YYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = @[@[@"我的状态",@"我发布的帖子",@"设置"],@[@"退出登录"]];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"me_mail" highImageName:@"me_mail" target:self action:@selector(toMail)];
    
    self.viewModel = [[YYMineViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self fetchPersonalProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPersonalProfile {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf showPersonalProfile:returnValue];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [self.viewModel fetchPersonalProfileWithDN:self.user.dn withMemberId:self.user.memberid];
}

- (void)showPersonalProfile:(PersonalProfile *)personalProfile {
    self.profile = personalProfile;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,personalProfile.headimg]] placeholderImage:[UIImage imageNamed:@"me_head"]];
//    self.edcLabel.text = [NSString stringWithFormat:@"预产期:%@",personalProfile.]
    self.currentCityLabel.text = personalProfile.city;
    self.myHospitalLabel.text = self.user.hospital;
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0){
        return 0.f;
    }
    return 20.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"YYMineCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = ((NSArray *)self.array[indexPath.section])[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];
        if(indexPath.row==0){
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"FB9BA9"];
            NSString *state;
            if([self.user.type isEqualToString:@"-1"]){
                state = @"用户未选择状态";
            }else if([self.user.type isEqualToString:@"0"]){
                state = @"普通家属";
            }else if([self.user.type isEqualToString:@"1"]){
                state = @"备孕中";
            }else if([self.user.type isEqualToString:@"2"]){
                state = @"我怀孕了";
            }else if([self.user.type isEqualToString:@"3"]){
                state = @"宝宝出生了";
            }
            cell.detailTextLabel.text = state;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
        }
        return cell;
    }else if(indexPath.section==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYMineCell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = ((NSArray *)self.array[indexPath.section])[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FB9BA9"];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld\nrow:%ld",(long)indexPath.section, (long)indexPath.row);
    if(indexPath.section==0){
        NSInteger row = indexPath.row;
        if(row==0){
            //选择状态
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            YYOptStatusViewController *viewController = [story instantiateViewControllerWithIdentifier:@"optstatus"];
            viewController.flag = 1;
            [self.navigationController pushViewController:viewController animated:YES];
        }else if(row==1){
            //我发布的帖子
            [self performSegueWithIdentifier:@"tomyposting" sender:nil];
        }else{
            //设置
            [self performSegueWithIdentifier:@"tomysetting" sender:nil];
        }
    }else {
        //退出登录
        UINavigationController *loginnav = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"loginnav"];
        [self presentViewController:loginnav animated:YES completion:nil];
    }
}

- (void)toMail {
    [self performSegueWithIdentifier:@"tomymessage" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"tomysetting"]){
        YYMySettingsViewController *viewController = segue.destinationViewController;
        viewController.profile = self.profile;
    }
}


@end
