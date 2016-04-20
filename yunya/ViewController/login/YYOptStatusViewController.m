//
//  YYOptStatusViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYOptStatusViewController.h"
#import "YYTabBarController.h"


@interface YYOptStatusViewController ()
//viewmodel
@property(nonatomic,strong) YYOptStatusViewModel *viewmodel;

@end

@implementation YYOptStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //todo
    if(self.flag==0){
        //禁用返回按钮
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    //标题
    self.title =  @"选择当前状态";
    //viewmodel
    _viewmodel = [[YYOptStatusViewModel alloc] initWithViewController:self];

    //美化视图
    [_viewmodel initview];
    
}
//我是家属按钮
- (IBAction)jumpToShouYe:(UIButton *)sender {
    //网络请求
    NSDictionary *dic = @{
                          @"dn":self.user.dn,
                          @"type":[NSString stringWithFormat:@"%d",0],
                          @"citycode":self.user.citycode,
                          @"city":self.user.city
                          };
    [_viewmodel fetchChooseStatusWithDic:dic];
    
    //设置网路请求成功时的代理
    [self fetchSuccess];
}
//设置网路请求成功时的代理
- (void)fetchSuccess{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //直接跳转到首页
        YYTabBarController *tabController = [[YYTabBarController alloc] init];
        [weakself presentViewController:tabController animated:YES completion:nil];
        //更新type
        [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"type" value:@"0"];
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self.viewmodel prepareForSegue:segue sender:sender];
}


@end
