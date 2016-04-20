//
//  YYChooseCityViewController.h
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"

@interface YYChooseCityViewController : EMIViewController
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;//我的位置
@property (weak, nonatomic) IBOutlet UITableView *cityTable;//城市列表
@property (weak, nonatomic) IBOutlet UITextField *searchCityTextField;//搜寻城市

@end
