//
//  YYSignUpViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
///

#import "YYSignUpViewModel.h"
#import "YYSignUpViewController.h"


@interface YYSignUpViewModel()
@property (strong, nonatomic)  UITextField *unameTextfield;//用户名输入框
@property (strong, nonatomic)  UITextField *telnumTextfield;//手机号输入框
@property (strong, nonatomic)  UITextField *yzmTextfield;//验证码输入框
@property (strong, nonatomic)  UITextField *pwdTextfield;//密码输入框
@property (strong, nonatomic)  UIButton *regiBtn;//立即注册按钮
@property (strong, nonatomic)  UIButton *yanzmBtn;//立即注册按钮
@property(nonatomic,assign) int counttime;//到计时
@property(nonatomic,strong) NSTimer *time;//计时器
//手势
@property(strong,nonatomic) UITapGestureRecognizer *gesture;
@end

@implementation YYSignUpViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYSignUpViewController *) viewController;
        self.unameTextfield = ((YYSignUpViewController *) self.viewController).unameTextfield;
        self.telnumTextfield = ((YYSignUpViewController *) self.viewController).telnumTextfield;
        self.yzmTextfield = ((YYSignUpViewController *) self.viewController).yzmTextfield;
        self.pwdTextfield = ((YYSignUpViewController *) self.viewController).pwdTextfield;
        self.regiBtn = ((YYSignUpViewController *) self.viewController).regiBtn;
        self.yanzmBtn = ((YYSignUpViewController *) self.viewController).yanzmBtn;
    }
    return self;
}

//美化视图
- (void)initview{
    [self initTextfield:_unameTextfield];
    [self initTextfield:_telnumTextfield];
    [self initTextfield:_yzmTextfield];
    //分割线
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(self.viewController.view.frame.size.width-130, _yzmTextfield.frame.origin.y+7, 1, 26)];
    [lineview setBackgroundColor:[UIColor colorWithHexString:@"fb9ba9"]];
    [self.viewController.view addSubview:lineview];
    
    [self initTextfield:_pwdTextfield];
    [self initButton:_regiBtn imagename:@"login_click_btn"];
    
    //给视图添加手势，去除uitextfield的第一响应
    self.gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyB)];
    [self.viewController.view addGestureRecognizer:self.gesture];

    
}
//手势点击
- (void)hideKeyB{
    if ([self.unameTextfield isFirstResponder])
    {
        [self.unameTextfield resignFirstResponder];
    }
    if ([self.telnumTextfield isFirstResponder])
    {
        [self.telnumTextfield resignFirstResponder];
    }
    if ([self.yzmTextfield isFirstResponder])
    {
        [self.yzmTextfield resignFirstResponder];
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
//请求验证码
- (void)fetchYanzmWithTel:(NSString *)telStr{
    //网络请求
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/getPhonevalidatecode.do"] withparameter:@{@"dn":telStr} WithReturnValeuBlock:^(id returnValue) {
        [self fetchYanzmSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
//请求成功
- (void)fetchYanzmSuccessWithDic:(NSDictionary *)returnValue{
    //是否成功的标志
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        //验证码发送失败了
        NSString *msg = [returnValue objectForKey:@"msg"];
        //弹框提示错误信息
        [self.viewController.view makeToast:msg duration:3.0 position:CSToastPositionCenter];
        NSLog(@"%@",msg);
    }else{
        NSLog(@"验证码发送成功");
    }
}
//获取验证码的计时器(60s后再获取)
- (void)fetchYanzmAfterSomeTime{
    _counttime = 60;
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
//计时方法
- (void)timeFireMethod{
    //设置获取验证码不可点击，及标题文字
    [self.yanzmBtn setEnabled:NO];
    [self.yanzmBtn setTitle:[NSString stringWithFormat:@"%d%@",_counttime,@"秒后再获取"] forState:UIControlStateNormal];
    _counttime--;
    if (_counttime == 0) {
        //停止计时器
        [_time invalidate];
        //设置获取验证码可点击，及标题文字
        [self.yanzmBtn setEnabled:YES];
        [self.yanzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

    }
}
//立即注册
- (void)fetchRegiResultWithDic:(NSDictionary *)params{
    //网络请求
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/userregister.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchRegiResultSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}
//请求成功
- (void)fetchRegiResultSuccessWithDic:(NSDictionary *)returnValue{
    //是否成功的标志
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        //注册失败了
        NSString *msg = [returnValue objectForKey:@"msg"];
        //弹框提示错误信息
        [self.viewController.view makeToast:msg duration:3.0 position:CSToastPositionCenter];
        NSLog(@"%@",msg);
    }else{
        NSLog(@"注册成功");
        self.returnBlock(returnValue);
    }

}

@end
