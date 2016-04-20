//
//  YYWriteBaseInfoViewModel.m
//  yunya
//
//  Created by 陈凯 on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYWriteBaseInfoViewModel.h"
#import "YYWriteBaseInfoViewController.h"
#import "YYPushValueInstance.h"

@interface YYWriteBaseInfoViewModel()

{
    /**
     *  判断当前视图来自哪个按钮
     0:怀孕了按钮
     1:备孕中
     2:宝宝出生
     */
    int fromwho;
}
@property(strong,nonatomic) YYPushValueInstance *shareInstance;//单例传值
@end

@implementation YYWriteBaseInfoViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super initWithViewController:viewController];
    if (self) {
        self.viewController = (YYWriteBaseInfoViewController *) viewController;
        fromwho = ((YYWriteBaseInfoViewController *) self.viewController).fromwho;
        //tableview初始化
        self.basetableview = ((YYWriteBaseInfoViewController *) self.viewController).basetableview;
    }
    return self;
}

//美化视图
- (void)initview{
    
    self.viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back" highImageName:@"back" target:self action:@selector(back)];
    
    //tableview
    [self inittableview];
}

//初始化tableview
- (void)inittableview{
    __unsafe_unretained typeof(self) weakself = self;
    switch (fromwho) {
        case 0:
            weakself.basetableview.frame = CGRectMake(0, 64, screenWidth, 5*50+30);
            break;
        case 1:
            weakself.basetableview.frame = CGRectMake(0, 64, screenWidth, 5*50+30);
            break;
        case 2:
            weakself.basetableview.frame = CGRectMake(0, 64, screenWidth, 5*50+2*70+30);
            break;
        default:
            break;
    }
    //tableview分割线
    weakself.basetableview.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
}
//返回上层视图
- (void)back{
    __unsafe_unretained typeof(self) weakself = self;

    //没点保存，单例里的值恢复默认空值或空字符串
    _shareInstance = [YYPushValueInstance shareInstance];
    _shareInstance.city = @"";
    _shareInstance.citycode = @"";
    _shareInstance.hospital = @"";
    _shareInstance.hospitalid = @"";

    [weakself.viewController.navigationController popViewControllerAnimated:YES];
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
@end
