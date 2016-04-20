//
//  YYDailyAddViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/25.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyAddViewController.h"
#import "YYDailyAddViewModel.h"
#import "UploadFile.h"
#import "DateTools.h"

@interface YYDailyAddViewController ()
@property (nonatomic,strong) YYDailyAddViewModel *viewModel;
@end

@implementation YYDailyAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.daily){
        self.title = @"修改记录";
    }else{
        self.title = @"写记录";
    }
    
    _viewModel = [[YYDailyAddViewModel alloc] initWithViewController:self];
    
    [_viewModel initViewsOn:self.view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(addDaily)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDaily {
    
    if(!_daily){
        _daily = [[Daily alloc] init];
        _daily.id = @"0";
        _daily.memberid = self.user.memberid;
        _daily.dn = self.user.dn;
        _daily.ctime = [DateTools dateTimeToString:[NSDate date]];
        _daily.content = [_viewModel.contentTextView emoticonText];;
        _daily.imgurl = [_viewModel.imageArray componentsJoinedByString:@","];
        
        __unsafe_unretained typeof(self) weakSelf = self;
        [_viewModel setBlockWithReturnBlock:^(id returnValue) {
            if(returnValue){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        [_viewModel addDaily:_daily];
    }else{
        _daily.memberid = self.user.memberid;
        _daily.dn = self.user.dn;
        _daily.ctime = [DateTools dateTimeToString:[NSDate date]];
        _daily.content = [_viewModel.contentTextView emoticonText];;
        _daily.imgurl = [_viewModel.imageArray componentsJoinedByString:@","];
        
        __unsafe_unretained typeof(self) weakSelf = self;
        [_viewModel setBlockWithReturnBlock:^(id returnValue) {
            if(returnValue){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        [_viewModel update:_daily];
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
