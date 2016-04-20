//
//  YYLoginViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/19.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYLoginViewModel.h"
#import "YYLoginViewController.h"

@interface YYLoginViewModel()
//用户名框
@property (strong, nonatomic)  UITextField *userTextfield;
//密码框
@property (strong, nonatomic)  UITextField *pwdTextfield;
//登录按钮
@property (strong, nonatomic)  UIButton *loginBtn;
//忘记密码按钮
@property (strong, nonatomic)  UIButton *fogetBtn;
//立即注册按钮
@property (strong, nonatomic)  UIButton *regiBtn;
//手势
@property(strong,nonatomic) UITapGestureRecognizer *gesture;
@end

@implementation YYLoginViewModel


- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYLoginViewController *) viewController;
        self.userTextfield = ((YYLoginViewController *) self.viewController).userTextfield;
        self.pwdTextfield = ((YYLoginViewController *) self.viewController).pwdTextfield;
        self.loginBtn = ((YYLoginViewController *) self.viewController).loginBtn;
        self.fogetBtn = ((YYLoginViewController *) self.viewController).fogetBtn;
        self.regiBtn = ((YYLoginViewController *) self.viewController).regiBtn;
    }
    return self;
}


//美化视图
- (void)initview{
    [self initTextfield:_userTextfield];
    [self initTextfield:_pwdTextfield];
    [self initButton:_loginBtn imagename:@"login_click_btn"];
    [self initButton:_regiBtn imagename:@"regi_click_btn"];
    //给视图添加手势，去除uitextfield的第一响应
    self.gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyB)];
    [self.viewController.view addGestureRecognizer:self.gesture];
}
//手势点击
- (void)hideKeyB{
    if ([self.userTextfield isFirstResponder])
    {
        [self.userTextfield resignFirstResponder];
    }
    if([self.pwdTextfield isFirstResponder])
    {
        [self.pwdTextfield resignFirstResponder];
    }
}
//设置uitextfield的样式
- (void)initTextfield:(UITextField *)textfield{
    textfield.layer.borderWidth = 0.5;
    textfield.layer.borderColor = [UIColor cgcolorWithHexString:@"7a7a7a"];
    //左侧缩进
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    textfield.leftView = view;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
}
//设置button点击高亮样式
- (void)initButton:(UIButton *)button imagename:(NSString *)imagename{
    //去掉系统默认高亮置灰效果
    [button setAdjustsImageWhenHighlighted:NO];
    //高亮背景
    [button setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateHighlighted];
}
//登陆
- (void)fetchLoginWithDic:(NSDictionary *)params{
    //网络请求
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/momberlogin.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchLoginSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
//请求成功
- (void)fetchLoginSuccessWithDic:(NSDictionary *)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        NSString *msg = [returnValue objectForKey:@"msg"];
        [self.viewController.view makeToast:msg duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"登录成功");
        self.returnBlock(returnValue);
    }

}
@end
