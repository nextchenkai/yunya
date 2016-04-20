//
//  YYWriteBaseInfoViewController.h
//  yunya
//
//  Created by 陈凯 on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "EMIViewController.h"

@interface YYWriteBaseInfoViewController : EMIViewController

/**
 *  判断当前视图来自哪个按钮
 0:怀孕了按钮
 1:备孕中
 2:宝宝出生
 */
@property(nonatomic,assign)int fromwho;

@property(strong,nonatomic) UITableView *basetableview;
//年份数组
@property(nonatomic,retain) NSMutableArray *year;
//月份数组
@property(nonatomic,retain) NSMutableArray *month;
//天数数组
@property(nonatomic,retain) NSMutableArray *day;
//选择器
@property(nonatomic,strong) YYPickerView *pkview;
//输入框
@property(nonatomic,strong) UITextField *ttview;
//单选框 (女)
@property(nonatomic,strong) BEMCheckBox *check0;
//单选框 (男)
@property(nonatomic,strong) BEMCheckBox *check1;
//预产期时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *EdcArray;
//初次月经时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *FirstMenstruation;
//末次月经时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *LastMenstruation;

//上次月经时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *PreMenstruation;
//经期天数
@property(nonatomic,assign) int PMSDay;//(1-20)
//经期周期
@property(nonatomic,assign) int PMSRound;//(1-100)

//排卵时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *OvulationArray;

//宝宝姓名
@property(nonatomic,copy) NSString *BabyName;

//宝宝性别
@property(nonatomic,assign) int BabySex;//(0为女，1为男)
//宝宝体重
@property(nonatomic,assign) double BabyWeight;

//宝宝出生日期数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *BabyDateBirth;
//脚印图片
@property(nonatomic,copy) NSString *babyfoot;
//宝宝图片
@property(nonatomic,copy) NSString *babyimg;
//时间标识，用于判断yypickerview弹出是响应了谁的点击事件
/**
 *  01:怀孕了，选择预产期
    02:怀孕了，初次月经
    03:怀孕了，末次月经
 
    11:备孕中，上次月经时间
        12:备孕中，经期天数(int)
        13:备孕中，经期周期(int)
    14:备孕中，排卵时间
 
        21:宝宝出生，宝宝姓名(string)
        22:宝宝出生，宝宝性别(string)
        23:宝宝出生，宝宝体重，decimal
    24：宝宝出生，宝宝出生日期
            25:宝宝出生，宝宝脚印
            26:宝宝出生，宝宝图片
 */

@property(nonatomic,copy)NSString *alertidentifier;
@end
