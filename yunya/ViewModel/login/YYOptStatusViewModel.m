//
//  YYOptStatusViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYOptStatusViewModel.h"
#import "YYOptStatusViewController.h"
#import "YYWriteBaseInfoViewController.h"

@interface YYOptStatusViewModel ()

//怀孕了按钮
@property (strong, nonatomic)  UIButton *huaiyunBtn;
//备孕中按钮
@property (strong, nonatomic)  UIButton *beiyunBtn;
//宝宝出生按钮
@property (strong, nonatomic)  UIButton *chushengBtn;


/**
 *  判断当前视图来自哪个按钮
 0:怀孕了按钮
 1:备孕中
 2:宝宝出生
 */
@property(nonatomic,assign)int fromwho;

@end

@implementation YYOptStatusViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYOptStatusViewController *) viewController;
    }
    return self;
}


//美化视图
- (void)initview{
//    //设置背景图片
//    UIImage *background = [UIImage imageNamed:@"choice_bj"];
//    [self.viewController.view setBackgroundColor:[[UIColor alloc] initWithPatternImage:background]];
    //设置怀孕了按钮
    [self sethuaiyunBtn];
}
//设置怀孕了按钮
- (void)sethuaiyunBtn{
    UIImage *huaiyunbg = [UIImage imageNamed:@"choice_huaiyun"];
    _huaiyunBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _huaiyunBtn.frame = CGRectMake(screenWidth/4, 84, screenWidth/2, screenWidth/2);
    [_huaiyunBtn setBackgroundImage:huaiyunbg forState:UIControlStateNormal];
    [_huaiyunBtn setTitle:@"怀孕了" forState:UIControlStateNormal];
    [_huaiyunBtn setFont:[UIFont systemFontOfSize:25 weight:60]];
    [_huaiyunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //点击事件
    [_huaiyunBtn addTarget:self action:@selector(jumptoHuaiyunView) forControlEvents:UIControlEventTouchUpInside];
    //去除高亮效果
    [_huaiyunBtn setAdjustsImageWhenHighlighted:NO];
    [self.viewController.view addSubview:_huaiyunBtn];
    //备孕中按钮
    [self setbeiyunBtn];

}
//备孕中按钮
- (void)setbeiyunBtn{
    UIImage *beiyunbg = [UIImage imageNamed:@"choice_beiyun"];
    _beiyunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _beiyunBtn.frame = CGRectMake(screenWidth/14, CGRectGetMaxY(_huaiyunBtn.frame)+20, (screenWidth*5)/14, (screenWidth*5)/14);
    [_beiyunBtn setBackgroundImage:beiyunbg forState:UIControlStateNormal];
    [_beiyunBtn setTitle:@"备孕中" forState:UIControlStateNormal];
    [_beiyunBtn setFont:[UIFont systemFontOfSize:18 weight:40]];
    [_beiyunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewController.view addSubview:_beiyunBtn];
    //点击事件
    [_beiyunBtn addTarget:self action:@selector(jumptoBeiyunView) forControlEvents:UIControlEventTouchUpInside];
    //去除高亮效果
    [_beiyunBtn setAdjustsImageWhenHighlighted:NO];
    //出生按钮
    [self setchushnegBtn];
}
//出生
- (void)setchushnegBtn{
    UIImage *chushengbg = [UIImage imageNamed:@"choice-chusheng"];
    _chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _chushengBtn.frame = CGRectMake(screenWidth/2, CGRectGetMaxY(_huaiyunBtn.frame)+10, (screenWidth*3)/7, (screenWidth*3)/7);
    [_chushengBtn setBackgroundImage:chushengbg forState:UIControlStateNormal];
    [_chushengBtn setTitle:@"宝宝出生" forState:UIControlStateNormal];
    [_chushengBtn setFont:[UIFont systemFontOfSize:18 weight:40]];
    [_chushengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //点击事件
    [_chushengBtn addTarget:self action:@selector(jumptoChushengView) forControlEvents:UIControlEventTouchUpInside];

    //去除高亮效果
    [_chushengBtn setAdjustsImageWhenHighlighted:NO];
    [self.viewController.view addSubview:_chushengBtn];

}
//怀孕跳转
- (void)jumptoHuaiyunView{
    _fromwho = 0;
    [self.viewController performSegueWithIdentifier:@"optionToBaseInfo" sender:self];
    
}
//备孕跳转
- (void)jumptoBeiyunView{
    _fromwho = 1;
    [self.viewController performSegueWithIdentifier:@"optionToBaseInfo" sender:self];
    
}
//出生跳转
- (void)jumptoChushengView{
    _fromwho = 2;
    [self.viewController performSegueWithIdentifier:@"optionToBaseInfo" sender:self];
    
}

//选择完状态的网络请求
- (void)fetchChooseStatusWithDic:(NSDictionary *)params{
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/statesetupInformation.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchChooseStatusSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

//请求成功
- (void)fetchChooseStatusSuccessWithDic:(NSDictionary *)returnValue{
    NSString *success = [NSString stringWithFormat:@"%@",[returnValue objectForKey:@"success"]];
    if ([success isEqualToString:@"2"]) {
        [self.viewController.view makeToast:@"设置状态失败！" duration:3.0 position:CSToastPositionCenter];
    }else{
        //成功
        NSLog(@"设置成功");
        self.returnBlock(returnValue);
    }
    
}


//segue传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    YYWriteBaseInfoViewController *dest = [segue destinationViewController];
    dest.fromwho = _fromwho;
}
@end
