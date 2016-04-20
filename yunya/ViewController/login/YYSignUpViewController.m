//
//  YYSignUpViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
///

#import "YYSignUpViewController.h"

@interface YYSignUpViewController ()
//viewmodel
@property(nonatomic,strong) YYSignUpViewModel *viewmodel;
//用户信息
@property(nonatomic,strong)Userinfo *user;
@end

@implementation YYSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //todo
    //禁用返回按钮
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
   
    //标题
    self.title =  @"注册";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    //viewmodel
    _viewmodel = [[YYSignUpViewModel alloc] initWithViewController:self];
    //初始化视图
    [_viewmodel initview];
    //设置viewmodel中回调的执行
    [self setBlock];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定义回调
- (void)setBlock{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //将用户信息存入NSUserDefault
        NSLog(@"%@",returnValue);
        //默认登陆此账号以后
        NSNumber *islogin = [NSNumber numberWithBool:YES];
        NSDictionary *dic = @{@"dn":[returnValue objectForKey:@"dn"],
                              @"nickname":weakself.unameTextfield.text,
                              @"type":@"-1",
                              @"memberid":[returnValue objectForKey:@"memberid"],
                              @"city":[returnValue objectForKey:@"city"],
                              @"citycode":[returnValue objectForKey:@"citycode"],
                              @"islogin":islogin,
                              @"isdoctor":@"2"};//todo 默认会员，非医生
        [OperateNSUserDefault saveUserDefault:dic];
        //跳转至选择状态界面
        [weakself performSegueWithIdentifier:@"signupToOption" sender:weakself];
        
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
}
//验证手机号格式，决定获取验证码是否可以点击
- (IBAction)telCheck:(id)sender {
    if ([ValidateMobile ValidateMobile:_telnumTextfield.text]) {
        //验证成功，获取验证码按钮可点击
        [_yanzmBtn setEnabled:YES];
        //立即注册按钮可点击
        [_regiBtn setEnabled:YES];
    }else{
        //验证失败，获取验证码按钮不可点击
        [_yanzmBtn setEnabled:NO];
        //立即注册按钮不可点击
        [_regiBtn setEnabled:NO];
    }

}

//获取验证码
- (IBAction)getYanZM:(UIButton *)sender {
    [_viewmodel fetchYanzmWithTel:_telnumTextfield.text];
    //计时器
    [_viewmodel fetchYanzmAfterSomeTime];
}
//立即注册
- (IBAction)registerImediately:(UIButton *)sender {
    NSDictionary *params = @{@"nickname":_unameTextfield.text,@"dn":_telnumTextfield.text,@"code":_yzmTextfield.text,@"password":_pwdTextfield.text};
    [_viewmodel fetchRegiResultWithDic:params];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//}


@end
