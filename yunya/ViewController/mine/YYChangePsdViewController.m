//
//  YYChangePsdViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChangePsdViewController.h"
#import "YYChangePsdViewModel.h"

@interface YYChangePsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *dnText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *psd1Text;
@property (weak, nonatomic) IBOutlet UITextField *psd2Text;
- (IBAction)changePsd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getYZMButton;
- (IBAction)getYZM:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;

@property(nonatomic,strong) YYChangePsdViewModel *viewModel;
@property(nonatomic,assign) int counttime;//到计时
@property(nonatomic,strong) NSTimer *time;//计时器

@end

@implementation YYChangePsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[YYChangePsdViewModel alloc] initWithViewController:self];
    //标题
    self.title =  @"修改密码";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    
    [self initTextfield:_dnText];
    [self initTextfield:_codeText];
    [self initTextfield:_psd1Text];
    [self initTextfield:_psd2Text];
    
    [self initButton:_getYZMButton imagename:@"login_click_btn"];
    
    //给视图添加手势，去除uitextfield的第一响应
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyB)];
    [self.view addGestureRecognizer:gesture];
}

//手势点击
- (void)hideKeyB{
    if ([_dnText isFirstResponder])
    {
        [_dnText resignFirstResponder];
    }
    if ([_codeText isFirstResponder])
    {
        [_codeText resignFirstResponder];
    }
    if ([_psd1Text isFirstResponder])
    {
        [_psd1Text resignFirstResponder];
    }
    if([_psd2Text isFirstResponder])
    {
        [_psd2Text resignFirstResponder];
    }
}

//设置button点击高亮样式
- (void)initButton:(UIButton *)button imagename:(NSString *)imagename{
    //去掉系统默认高亮置灰效果
    [button setAdjustsImageWhenHighlighted:NO];
    //高亮背景
    [button setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateHighlighted];
}

- (void)initTextfield:(UITextField *)textfield {
    textfield.layer.borderWidth = 0.5;
    textfield.layer.borderColor = [UIColor cgcolorWithHexString:@"7a7a7a"];
    //左侧缩进
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    textfield.leftView = view;
    textfield.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取验证码的计时器(60s后再获取)
- (void)fetchYanzmAfterSomeTime{
    _counttime = 60;
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
//计时方法
- (void)timeFireMethod{
    //设置修改密码可选
    [self.changePwdBtn setEnabled:YES];
    //设置获取验证码不可点击，及标题文字
    [self.getYZMButton setEnabled:NO];
    [self.getYZMButton setTitle:[NSString stringWithFormat:@"%d%@",_counttime,@"秒后再获取"] forState:UIControlStateNormal];
    _counttime--;
    if (_counttime == 0) {
        //停止计时器
        [_time invalidate];
        //设置获取验证码可点击，及标题文字
        [self.getYZMButton setEnabled:YES];
        [self.getYZMButton setTitle:@"获取验证码" forState:UIControlStateNormal];
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

- (IBAction)changePsd:(id)sender {
    if([_psd2Text.text isEqualToString:_psd1Text.text] && _psd1Text.text.length>0){
        __unsafe_unretained typeof(self) weakself = self;
        [_viewModel setBlockWithReturnBlock:^(id returnValue) {
            if(returnValue){
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
            [weakself.view makeToast:@"修改密码失败!" duration:3.0 position:CSToastPositionCenter];}
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        [self.viewModel updatePsdWithDN:self.dnText.text withPsd:_psd1Text.text withCode:_codeText.text];
    }else{
        [self.view makeToast:@"两次输入的密码不一致" duration:3.0 position:CSToastPositionCenter];
    }
}
- (IBAction)getYZM:(id)sender {
    
    if([ValidateMobile ValidateMobile:_dnText.text]){
        [self.viewModel fetchYanzmWithTel:_dnText.text];
        //计时器
        [self fetchYanzmAfterSomeTime];
    }else
    {
        [self.view makeToast:@"请输入正确的手机号码" duration:3.0 position:CSToastPositionCenter];
    }
    
}
@end
