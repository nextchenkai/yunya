//
//  YYChooseCityViewController.m
//  yunya
//
//  Created by 陈凯 on 16/3/24.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYChooseCityViewController.h"
#import "CityList.h"
#import "YYPushValueInstance.h"

@interface YYChooseCityViewController ()

@property(strong,nonatomic) YYChooseCityViewModel *viewmodel;
@property(strong,nonatomic) CityList *citylist;//用于搜索及展现
@property(strong,nonatomic) id returnData;//网络请求返回值
//单例传值
@property(nonatomic,strong) YYPushValueInstance *shareInstance;
@end

@implementation YYChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //标题
    self.title =  @"选择城市";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    _viewmodel = [[YYChooseCityViewModel alloc] initWithViewController:self];
    _shareInstance = [YYPushValueInstance shareInstance];
    //当前城市todo
    NSLog(@"%@",self.user.city);
    _cityLabel.text = self.user.city;
    //获取所有城市列表
    [self fetchCityName];
}
//获取所有城市列表
- (void)fetchCityName{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //citylist结构
        
//        {
//            "success": "0-失败，1-成功",
//            "datalist":[
//                                {
//                                    "code":"E",
//                                    "data":[
//                                              {
//                                                  "charcode":"E",
//                                                  "name":"恩施州",
//                                                  "code":"4228"
//                                              }
//                                            ]
//                                 },
//                                 {
//                                    "code":"N",
//                                    "data":[
//                                              {
//                                                  "charcode":"N",
//                                                  "name":"南通",
//                                                  "code":"4228"
//                                              },
//                                              {
//                                                  "charcode":"N",
//                                                  "name":"南京",
//                                                  "code":"4228"
//                                              }
//                                           ]
//                                  }
//                         ]
//      }
        weakself.returnData = returnValue;
        //处理city数据
        [weakself getCityDataWith:weakself.returnData];
        //刷新表格数据
        [weakself.cityTable reloadData];

    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
    
    [_viewmodel fetchCityName];
}
//处理city数据
- (void)getCityDataWith:(id)returnValue{
    self.citylist = [CityList mj_objectWithKeyValues:returnValue];
    NSMutableArray *datalistarray = self.citylist.datalist;
    self.citylist.datalist = [Datalist mj_objectArrayWithKeyValuesArray:datalistarray];
    for (Datalist *datalist in self.citylist.datalist) {
        NSMutableArray *dataarray = datalist.data;
        datalist.data = [Data mj_objectArrayWithKeyValuesArray:dataarray];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//搜索事件
- (IBAction)searchCityWithText:(UITextField *)sender {
    //恢复city完整数据
    [self getCityDataWith:_returnData];
    NSString *aimcityname = _searchCityTextField.text;
    if (![aimcityname isEqualToString:@""]) {
        for (int i=0; i<_citylist.datalist.count; i++) {
            int datacount = 0;//用于计数，已经删掉了几个data
            NSMutableArray *dataarray = _citylist.datalist[i].data;
            for (int j=0; j<_citylist.datalist[i].data.count+datacount; j++) {
                if (![_citylist.datalist[i].data[j-datacount].name containsString:aimcityname]) {
                    [dataarray removeObjectAtIndex:j-datacount];
                    datacount++;
                }
            }
            _citylist.datalist[i].data = [Data mj_objectArrayWithKeyValuesArray:dataarray];
        }
        int datalistcount = 0;//用于计数，已经删掉了几个datalist
        NSMutableArray *datalistarray = _citylist.datalist;
        for (int i=0; i<_citylist.datalist.count+datalistcount; i++) {
            if (_citylist.datalist[i-datalistcount].data.count == 0) {
                [datalistarray removeObjectAtIndex:i-datalistcount];
                datalistcount++;
            }
        }
        _citylist.datalist = [Datalist mj_objectArrayWithKeyValuesArray:datalistarray];
        for (Datalist *datalist in self.citylist.datalist) {
            NSMutableArray *dataarray = datalist.data;
            datalist.data = [Data mj_objectArrayWithKeyValuesArray:dataarray];
        }
    }
    [self.cityTable reloadData];
}
//返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return _citylist.datalist.count;
}
//返回cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _citylist.datalist[section].data.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
    }
    if (_citylist.datalist.count > 1) {
        cell.textLabel.text = _citylist.datalist[indexPath.section].data[indexPath.row].name;
        cell.tag = (_citylist.datalist[indexPath.section].data[indexPath.row].code).intValue;
    }
    else{
        cell.textLabel.text = _citylist.datalist[0].data[0].name;
        cell.tag = (_citylist.datalist[0].data[0].code).intValue;
    }
    return cell;
        
}
//section之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //如果section中无内容
    if (_citylist.datalist[section].data.count == 0) {
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
    label.text = _citylist.datalist[section].code;
    [view addSubview:label];
    //如果section中无内容
    if (_citylist.datalist[section].data.count == 0) {
        view = nil;
    }
    return view;
}
//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //弹出框询问是否确定切换城市
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"城市切换" message:[NSString stringWithFormat:@"%@%@%@",@"确定更改城市为",cell.textLabel.text,@"?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //返回前一页面
        [self.navigationController popViewControllerAnimated:YES];
        //更改city
        _shareInstance.city = cell.textLabel.text;
        //更改citycode
        _shareInstance.citycode = [NSString stringWithFormat:@"%ld",(long)cell.tag];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
//字母索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<_citylist.datalist.count; i++) {
        
            [array addObject:[NSString stringWithFormat:@"%@",_citylist.datalist[i].code]];
        
    }
    return array;
}
// return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED{
    //跳转到对应的行
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
} // tell table which section corresponds to section title/index (e.g. "B",1))

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
