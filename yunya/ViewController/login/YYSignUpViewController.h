//
//  YYSignUpViewController.h
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

/**
 *  注册新用户
 */


#import "EMIViewController.h"

@interface YYSignUpViewController : EMIViewController

@property (weak, nonatomic) IBOutlet UITextField *unameTextfield;//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *telnumTextfield;//手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *yzmTextfield;//验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;//密码输入框
@property (weak, nonatomic) IBOutlet UIButton *regiBtn;//立即注册按钮
@property (weak, nonatomic) IBOutlet UIButton *yanzmBtn;//获取验证码

@end
