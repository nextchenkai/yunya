//
//  YYOptStatusViewController.h
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"
#import "Userinfo.h"

@interface YYOptStatusViewController : EMIViewController

//用户信息
@property(nonatomic,strong)Userinfo *user;
@property (weak, nonatomic) IBOutlet UIButton *jiashuBtn;//我是家属

@property (nonatomic, assign) int flag;//0,默认不显示返回按钮 1,显示返回按钮

@end
