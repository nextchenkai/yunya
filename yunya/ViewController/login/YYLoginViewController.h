//
//  YYLoginViewController.h
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

/**
 *  登录
 */

#import "EMIViewController.h"

@interface YYLoginViewController : EMIViewController

//用户名框
@property (weak, nonatomic) IBOutlet UITextField *userTextfield;
//密码框
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//忘记密码按钮
@property (weak, nonatomic) IBOutlet UIButton *fogetBtn;
//立即注册按钮
@property (weak, nonatomic) IBOutlet UIButton *regiBtn;

@end
