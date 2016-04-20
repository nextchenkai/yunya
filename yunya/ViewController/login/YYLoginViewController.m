//
//  YYLoginViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
///

#import "YYLoginViewController.h"
#import "YYTabBarController.h"
#import "YYChangePsdViewController.h"

@interface YYLoginViewController ()

//viewmodel
@property(nonatomic,strong) YYLoginViewModel *viewmodel;

@end

@implementation YYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //标题
    self.title =  @"登陆";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    //viewmodel
    _viewmodel = [[YYLoginViewModel alloc] initWithViewController:self];
    //初始化视图
    [_viewmodel initview];
    
}
//页面即将消失
- (void)viewWillDisappear:(BOOL)animated{
    [self.view makeToast:@"正在加载" duration:5.0 position:CSToastPositionCenter];
}
//定义回调
- (void)setBlock{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        NSString *type = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"type"]];
        NSLog(@"%@",returnValue);
        NSLog(@"手机号码:%@",weakself.userTextfield.text);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        @try {
            
            //默认登陆此账号以后
            NSNumber *islogin = [NSNumber numberWithBool:YES];
            [dic setObject:islogin forKey:@"islogin"];
            //todo 默认会员
            [dic setObject:@"2" forKey:@"isdoctor"];
            
            [dic setObject:weakself.userTextfield.text forKey:@"dn"];
            [dic setObject:[returnValue objectForKey:@"nickname"] forKey:@"nickname"];
            [dic setObject:[returnValue objectForKey:@"type"] forKey:@"type"];
            [dic setObject:[returnValue objectForKey:@"memberid"] forKey:@"memberid"];
            
            
            [dic setObject:[returnValue objectForKey:@"city"] forKey:@"city"];
            [dic setObject:[returnValue objectForKey:@"citycode"] forKey:@"citycode"];
            
            [dic setObject:[returnValue objectForKey:@"hospital"] forKey:@"hospital"];
            [dic setObject:[returnValue objectForKey:@"hospitalid"] forKey:@"hospitalid"];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        [OperateNSUserDefault saveUserDefault:dic];
        if ([type isEqualToString:@"-1"]) {
            //如果没有选择过状态,跳至选择状态界面
            [weakself performSegueWithIdentifier:@"loginToOption" sender:weakself];
        }else{
            //直接跳转到首页
            YYTabBarController *tabController = [[YYTabBarController alloc] init];
            [weakself presentViewController:tabController animated:YES completion:nil];
        }
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
}

//验证手机号
- (IBAction)telCheck:(UITextField *)sender {
    if ([ValidateMobile ValidateMobile:_userTextfield.text]) {
        //验证成功，登陆按钮可点击
        [_loginBtn setEnabled:YES];
        //自动跳转到输入密码框
        [_pwdTextfield becomeFirstResponder];
    }else{
        //验证失败，登陆按钮不可点击
        [_loginBtn setEnabled:NO];
    }
}


//登录按钮的点击事件
- (IBAction)loginToHome:(UIButton *)sender {
    //手机号，密码
    NSDictionary *params = @{@"dn":_userTextfield.text,@"password":_pwdTextfield.text};
    [self setBlock];
    [_viewmodel fetchLoginWithDic:params];
    
    //[self performSegueWithIdentifier:@"loginToOption" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//立即注册按钮的点击事件
- (IBAction)regiToSignUp:(UIButton *)sender {
     //使用界面上预留的segue跳转到
    [self performSegueWithIdentifier:@"signup" sender:self];
}
//忘记密码点击事件
- (IBAction)forgetPwd:(UIButton *)sender {
    //忘记密码
    YYChangePsdViewController *ChangePwdView = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"signup"];
    [self.navigationController pushViewController:ChangePwdView animated:YES];
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
