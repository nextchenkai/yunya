//
//  HospitalDetailViewController.m
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYHospitalDetailViewController.h"
#import "HospitalDetail.h"
#import "YYPushValueInstance.h"

@interface YYHospitalDetailViewController ()
@property(strong,nonatomic) YYHospitalDetailViewModel *viewmodel;
@property(strong,nonatomic) HospitalDetail *hos;
//单例传值
@property(nonatomic,strong) YYPushValueInstance *shareInstance;
@end

@implementation YYHospitalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    self.title =  @"医院详情";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];

    _viewmodel = [[YYHospitalDetailViewModel alloc] initWithViewController:self];
    
    _shareInstance = [YYPushValueInstance shareInstance];
    //保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认选择" style:UIBarButtonItemStyleDone target:self action:@selector(save)];

    //获取网络数据
    [self fetchHospitalDetail];
}
//确认选择
- (void)save{
    //存hospitalid
    _shareInstance.hospitalid = [NSString stringWithFormat:@"%d",_hospitalid];
    //存hospital
    _shareInstance.hospital = _hos.name;
    //返回基本信息页面
    if(self.flag==0){
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count-3)] animated:YES];
    }else{
        [self saveHospital];
    }
}

- (void)saveHospital {
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakself.navigationController popToViewController:[weakself.navigationController.viewControllers objectAtIndex:(weakself.navigationController.viewControllers.count-3)] animated:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [self.viewmodel saveHospitalWithDN:self.user.dn withMemberid:self.user.memberid withHospitalid:[NSString stringWithFormat:@"%d",_hospitalid]];
}
//获取网络数据
- (void)fetchHospitalDetail{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        id data = [returnValue objectForKey:@"data"];
        weakself.hos = [HospitalDetail mj_objectWithKeyValues:data];
        weakself.hospitalname.text = [NSString stringWithFormat:@"%@%@",@"  ",weakself.hos.name];
        weakself.hospitaladdress.text = [NSString stringWithFormat:@"%@%@",@"  ",weakself.hos.address];
        if (weakself.hos.imgurl != nil) {
            [weakself.hospitalimgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgIP,weakself.hos.imgurl]]];
        }
        
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
    
    [_viewmodel fetchHospitalInfoWithInt:weakself.hospitalid];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
