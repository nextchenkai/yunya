//
//  YYChooseHospitalViewController.m
//  yunya
//
//  Created by 陈凯 on 16/3/29.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseHospitalViewController.h"
#import "HospitalMde.h"
#import "YYHospitalDetailViewController.h"
#import "YYPushValueInstance.h"

@interface YYChooseHospitalViewController ()
@property(strong,nonatomic) YYChooseHospitalViewModel *viewmodel;
@property(strong,nonatomic) HospitalMde *hospitalmde;//用于搜索及展现
@property(strong,nonatomic) id returnData;//网络请求返回值

@property(assign,nonatomic) int hospitalid;//医院id

//单例传值
@property(nonatomic,strong) YYPushValueInstance *shareInstance;
@end

@implementation YYChooseHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    self.title =  @"产检医院";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    
    _viewmodel = [[YYChooseHospitalViewModel alloc] initWithViewController:self];
    
    _shareInstance = [YYPushValueInstance shareInstance];
    if (_shareInstance.citycode == nil || [_shareInstance.citycode isEqualToString:@""]) {
        _shareInstance.citycode = self.user.citycode;
    }
    //获取医院
    [self fetchHospitalNameWithStr:_shareInstance.citycode];
}
//搜索医院
- (IBAction)searchHospital:(id)sender {
    //恢复hospital完整数据
    [self getHospitalDataWith:_returnData];
    NSString *aimhospitalname = _hospitalSearchTextField.text;
    if (![aimhospitalname isEqualToString:@""]) {
        for (int i=0; i<_hospitalmde.datalist.count; i++) {
            int datacount = 0;//用于计数，已经删掉了几个data
            NSMutableArray *dataarray = _hospitalmde.datalist[i].data;
            for (int j=0; j<_hospitalmde.datalist[i].data.count+datacount; j++) {
                if (![_hospitalmde.datalist[i].data[j-datacount].name containsString:aimhospitalname]) {
                    [dataarray removeObjectAtIndex:j-datacount];
                    datacount++;
                }
            }
            _hospitalmde.datalist[i].data = [HospitalData mj_objectArrayWithKeyValuesArray:dataarray];
        }
        int datalistcount = 0;//用于计数，已经删掉了几个datalist
        NSMutableArray *datalistarray = _hospitalmde.datalist;
        for (int i=0; i<_hospitalmde.datalist.count+datalistcount; i++) {
            if (_hospitalmde.datalist[i-datalistcount].data.count == 0) {
                [datalistarray removeObjectAtIndex:i-datalistcount];
                datalistcount++;
            }
        }
        _hospitalmde.datalist = [HospitalDataList mj_objectArrayWithKeyValuesArray:datalistarray];
        for (HospitalDataList *datalist in self.hospitalmde.datalist) {
            NSMutableArray *dataarray = datalist.data;
            datalist.data = [HospitalData mj_objectArrayWithKeyValuesArray:dataarray];
        }
    }
    [self.hospitalTable reloadData];
}

//获取医院
- (void)fetchHospitalNameWithStr:(NSString *)citycode{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //hospitalmde结构
        
        //        {
        //            "success": "0-失败，1-成功",
        //            "datalist":[
        //                                {
        //                                    “county”:”地区”
        //                                    “countycode”:”code”
        //                                    "data":[
        //                                              {
        //                                                  “name ”:”医院名称”
        //                                                  “id”:”医院ID”
        //                                              }
        //                                            ]
        //                                 },
        //                                 {
            //                                    “county”:”地区”
            //                                    “countycode”:”code”
            //                                    "data":[
            //                                              {
            //                                                  “name ”:”医院名称”
            //                                                  “id”:”医院ID”
            //                                              }
            //                                            ]
            //                              },
            //                    ]
        //      }
        NSLog(@"%@",returnValue);
        weakself.returnData = returnValue;
        //处理city数据
        [weakself getHospitalDataWith:weakself.returnData];
        //刷新表格数据
        [weakself.hospitalTable reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
    
    [_viewmodel fetchHospitalNameWithString:citycode];

}
//处理hospital数据
- (void)getHospitalDataWith:(id)returnValue{
    self.hospitalmde = [HospitalMde mj_objectWithKeyValues:returnValue];
    NSMutableArray *datalistarray = self.hospitalmde.datalist;
    self.hospitalmde.datalist = [HospitalDataList mj_objectArrayWithKeyValuesArray:datalistarray];
    for (HospitalDataList *datalist in self.hospitalmde.datalist) {
        NSMutableArray *dataarray = datalist.data;
        datalist.data = [HospitalData mj_objectArrayWithKeyValuesArray:dataarray];
    }
}

//返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return _hospitalmde.datalist.count;
}
//返回cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hospitalmde.datalist[section].data.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hospitalCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
    }
    if (_hospitalmde.datalist[indexPath.section].data.count>0) {
        if (_hospitalmde.datalist.count > 1) {
            cell.textLabel.text = _hospitalmde.datalist[indexPath.section].data[indexPath.row].name;
            //医院id
            cell.tag = _hospitalmde.datalist[indexPath.section].data[indexPath.row].id;
        }
        else{
            cell.textLabel.text = _hospitalmde.datalist[0].data[0].name;
            cell.tag = _hospitalmde.datalist[0].data[0].id;
        }
    }
    
    return cell;
    
}
//section之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //如果section中无内容
    if (_hospitalmde.datalist[section].data.count == 0) {
        return 0;
    }
    else{
        return 20;
    }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/20, 0, 100, 20)];
    label.textColor = [UIColor blackColor];
    label.text = _hospitalmde.datalist[section].county;
    [view addSubview:label];
    //如果section中无内容
    if (_hospitalmde.datalist[section].data.count == 0) {
        view = nil;
    }
    return view;
}
//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _hospitalid = cell.tag;
    //跳转到医院详情
    [self performSegueWithIdentifier:@"hospitalToDetail" sender:self];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //医院详情界面
    YYHospitalDetailViewController *destview = [segue destinationViewController];
    destview.hospitalid = _hospitalid;
}


@end
