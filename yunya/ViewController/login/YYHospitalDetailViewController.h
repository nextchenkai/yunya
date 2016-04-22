//
//  HospitalDetailViewController.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"

@interface YYHospitalDetailViewController : EMIViewController
@property(assign,nonatomic) int hospitalid;//医院id
@property (weak, nonatomic) IBOutlet UIImageView *hospitalimgview;//医院图片
@property (weak, nonatomic) IBOutlet UILabel *hospitalname;//医院名字
@property (weak, nonatomic) IBOutlet UILabel *hospitaladdress;//医院地址

@property (nonatomic, assign) int flag;//0:确认选择,不更新医院 1:确认选择,不更新医院

@end
