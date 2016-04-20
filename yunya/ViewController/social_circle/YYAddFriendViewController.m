//
//  YYAddFriendViewController.m
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYAddFriendViewController.h"
#import "SearchFriend.h"
#import "YYSearchFriendCell.h"

@interface YYAddFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
//viewmodel
@property (strong,nonatomic)YYAddFriendViewModel *viewmodel;
//搜索好友列表
@property (nonatomic,strong) NSMutableArray *searchfriendarray;
//查询到的用户table
@property (nonatomic,strong) UITableView *table;

//确定按钮
@property (nonatomic,strong) UIButton *surebtn;

@property (nonatomic,strong) SearchFriend *searchfriend;

//选择了第几位好友
@property (nonatomic,assign) NSUInteger count;
@end

@implementation YYAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加好友";
    //viewmodel
    _viewmodel = [[YYAddFriendViewModel alloc] initWithViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchFriends:(UIButton *)sender {
    if ([_searchTxtField isFirstResponder]) {
        [_searchTxtField resignFirstResponder];
        
    }
    if (![_searchTxtField.text isEqualToString:@""]) {
        NSDictionary *dic = @{@"nickname":_searchTxtField.text,
                              @"memberid":self.user.memberid};
        [_viewmodel fetchSearchFriendWithDic:dic];
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
            if((NSDictionary*)returnValue){
                weakSelf.searchfriendarray = [NSMutableArray arrayWithArray:[returnValue objectForKey:@"data"]];
            }
            //查询到好友
            if (weakSelf.searchfriendarray.count > 0) {
                //先置空之前的table
                if (weakSelf.table != nil) {
                    [weakSelf.table removeFromSuperview];
                    [weakSelf.surebtn removeFromSuperview];
                }
                [weakSelf createtableview];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];

    }
    

}

/**
 *  初始化tableview
 */
- (void)createtableview{
    if (_searchfriendarray.count*60>=screenHeight-164) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, screenWidth, screenHeight-164) style:UITableViewStylePlain];
    }
    else{
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, screenWidth, _searchfriendarray.count*60) style:UITableViewStylePlain];
    }
    _table.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    //确定按钮
    [self createBtn];
}

- (void)createBtn{
    //默认－1，未选中好友
    _count = -1;
    
    _surebtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _table.frame.size.height+124, screenWidth-20, 40)];
    [_surebtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_surebtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
    _surebtn.titleLabel.textColor = [UIColor whiteColor];
    [_surebtn setEnabled:NO];
    [self.view addSubview:_surebtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchfriendarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     YYSearchFriendCell *searchcell = [YYSearchFriendCell cellWithTableView:tableView];
    _searchfriend = [SearchFriend mj_objectWithKeyValues:[_searchfriendarray objectAtIndex:indexPath.row]];
    [searchcell setValue:_searchfriend];
    
    return searchcell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[NSString stringWithFormat:@"%@",[[_searchfriendarray objectAtIndex:indexPath.row] objectForKey:@"isfriend"] ] isEqualToString:@"1"]) {
        _count = indexPath.row;
        //surebutton可选
        [_surebtn setEnabled:YES];
    }
    else{
        _count = -1;
        //surebutton不可选
        [_surebtn setEnabled:NO];
    }
    
}
/**
 *  确定加好友
 */
- (void)sure{
    if (_count != -1) {
        NSDictionary *dic = @{@"dn":self.user.dn,
                              @"memberid":self.user.memberid,
                              @"isdoctor":self.user.isdoctor,
                              @"fpeopleid":[[_searchfriendarray objectAtIndex:_count] objectForKey:@"fpeopleid"],
                              @"fpeopleisdoctor":[[_searchfriendarray objectAtIndex:_count] objectForKey:@"isdoctor"]
                              };
        [_viewmodel fetchSearchFriendWithDic:dic];
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
            if((NSDictionary*)returnValue){
                [weakSelf.view makeToast:@"申请发送成功！" duration:3.0 position:CSToastPositionCenter];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];

    }
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
