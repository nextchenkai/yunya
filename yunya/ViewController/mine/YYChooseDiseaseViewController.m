//
//  YYChooseDiseaseViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseDiseaseViewController.h"
#import "YYChooseDiseaseViewModel.h"
#import "YYDiseaseTableViewCell.h"
#import "Disease.h"

@interface YYChooseDiseaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) YYChooseDiseaseViewModel *viewModel;
@end

@implementation YYChooseDiseaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.flag==0){
        self.title = @"选择既病史";
    }else{
        self.title = @"选择现病史";
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(getDisease)];
    
    self.viewModel = [[YYChooseDiseaseViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self fetchDisease];
}

- (void)getDisease {
    NSMutableArray *selArray = [[NSMutableArray alloc] init];
    for(Disease *disease in self.array){
        if(disease.isCheck){
            [selArray addObject:disease];
        }
    }
    if([self.delegate respondsToSelector:@selector(passDisease:)]){
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate performSelector:@selector(passDisease:) withObject:selArray];
    }
}

- (void)fetchDisease {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchDiseaseWithDN:self.user.dn withMemberId:self.user.memberid];
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
    YYDiseaseTableViewCell *cell = [YYDiseaseTableViewCell cellWithTableView:tableView];
    [cell setValue:self.array[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Disease *disease = self.array[indexPath.row];
    disease.isCheck = !disease.isCheck;
    [tableView reloadData];
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
