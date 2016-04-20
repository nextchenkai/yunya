//
//  YYChooseHospitalViewController.h
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"

@interface YYChooseHospitalViewController : EMIViewController
@property (weak, nonatomic) IBOutlet UITableView *hospitalTable;//医院列表
@property (weak, nonatomic) IBOutlet UITextField *hospitalSearchTextField;//搜索医院框

@end
