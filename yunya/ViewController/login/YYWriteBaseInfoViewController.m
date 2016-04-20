//
//  YYWriteBaseInfoViewController.m
//  yunya
//
//  Created by 陈凯 on 16/3/22.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYWriteBaseInfoViewController.h"
#import "YYBaseInfoTableViewCell.h"
#import "YYBabyInfoTableViewCell.h"
#import "YYPickerCellTableViewCell.h"
#import "YYTabBarController.h"
#import "YYPushValueInstance.h"

@interface YYWriteBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource,YYPickerViewDelegate,YYPickerViewDataSource,BEMCheckBoxDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UploadFileDelegate>
{

    NSString *city;//城市
    }

//viewmodel
@property(nonatomic,strong) YYWriteBaseInfoViewModel *viewmodel;
//pickerview
@property (strong, nonatomic) UIPickerView *ppView;
//单例传值
@property(nonatomic,strong) YYPushValueInstance *shareInstance;
@end

@implementation YYWriteBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //年份数组
    _year = [DateTools tenyearsFromNow];
    //月份数组
    _month = [DateTools monthMax];
    //天数数组
    _day = [DateTools dayMax];
    //脚印图片
    _babyfoot = @"";
    //宝宝图片
    _babyimg = @"";
    // Do any additional setup after loading the view.
    //标题
    self.title =  @"填写基本信息";
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    //tableview
    _basetableview = [[UITableView alloc] init];
    _basetableview.dataSource = self;
    _basetableview.delegate = self;

    [self.view addSubview:_basetableview];
    

    //viewmodel
    _viewmodel = [[YYWriteBaseInfoViewModel alloc] initWithViewController:self];
    
    //shareInstance
    _shareInstance = [YYPushValueInstance shareInstance];
    if (_shareInstance.city == nil || [_shareInstance.city isEqualToString:@""]) {
        _shareInstance.city = self.user.city;
        _shareInstance.citycode = self.user.citycode;
    }
    //从shareInstance中读取城市
    city = _shareInstance.city;
    //美化视图
    [_viewmodel initview];
    
    //保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
}



//保存
- (void)save{
    switch (_fromwho) {
        case 0:
            //怀孕状态
            //预产期和末次月经最少填一个
            if (_EdcArray == nil && _LastMenstruation == nil) {
                [self.view makeToast:@"预产期与末次月经请至少填写一项！" duration:3.0 position:CSToastPositionCenter];
            }else{
                if (_FirstMenstruation == nil) {
                    [self.view makeToast:@"请选择初次月经！" duration:3.0 position:CSToastPositionCenter];
                }
                else{
                   
                    if ([OperateNSUserDefault readUserDefaultWithKey:@"hospitalid"] == nil) {
                        [self.view makeToast:@"请选择体检医院！" duration:3.0 position:CSToastPositionCenter];
                    }
                    else{
                        //网络请求
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        @try {
                            
                            [dic setObject:self.user.dn forKey:@"dn"];
                            [dic setObject:[NSString stringWithFormat:@"%d",2] forKey:@"type"];
                            [dic setObject:_shareInstance.citycode forKey:@"citycode"];
                            [dic setObject:_shareInstance.city forKey:@"city"];
                            [dic setObject:[self timeStr:_EdcArray] forKey:@"datebirth"];
                            [dic setObject:_shareInstance.hospitalid forKey:@"hospitalid"];
                            [dic setObject:_shareInstance.hospital forKey:@"hospital"];
                            [dic setObject:[self timeStr:_FirstMenstruation] forKey:@"firstmenstruation"];
                            [dic setObject:[self timeStr:_LastMenstruation] forKey:@"lastmenstruation"];
                            
                        } @catch (NSException *exception) {
                            
                        } @finally {
                            
                        }
                        [_viewmodel fetchChooseStatusWithDic:dic];
                    }
                }
            }
            break;
        case 1:
            //备孕状态
            if (_PreMenstruation == nil) {
                [self.view makeToast:@"请填写上次月经时间！" duration:3.0 position:CSToastPositionCenter];

            }else{
                if (_PMSDay == 0) {
                    [self.view makeToast:@"请填写经期天数！" duration:3.0 position:CSToastPositionCenter];

                }else{
                    if (_PMSRound == 0) {
                        [self.view makeToast:@"请填写经期周期！" duration:3.0 position:CSToastPositionCenter];
                    }else{
                        if (_OvulationArray == nil) {
                            [self.view makeToast:@"请填写排卵时间！" duration:3.0 position:CSToastPositionCenter];
                        }
                        else{
                            //网络请求
                            //网络请求
                            NSDictionary *dic = @{
                                                  @"dn":self.user.dn,
                                                  @"type":[NSString stringWithFormat:@"%d",1],
                                                  @"citycode":_shareInstance.citycode,
                                                  @"city":_shareInstance.city,
                                                  @"preparelasttmenstruation":[self timeStr:_PreMenstruation],
                                                  @"prepareperioddays":[NSString stringWithFormat:@"%d",_PMSDay],
                                                  @"preparecycle":[NSString stringWithFormat:@"%d",_PMSRound],
                                                  @"preapreovulationtime":[self timeStr:_OvulationArray]                                                 };
                            [_viewmodel fetchChooseStatusWithDic:dic];

                        }
                    }
                }
            }
            break;
        case 2:
            //宝宝出生状态
            if (_BabyName == nil) {
                [self.view makeToast:@"请填写宝宝姓名！" duration:3.0 position:CSToastPositionCenter];
            }else{
                if (_BabySex == 0) {
                    [self.view makeToast:@"请选择宝宝性别！" duration:3.0 position:CSToastPositionCenter];
                }else{
                    if (_BabyWeight == 0) {
                        [self.view makeToast:@"请填写宝宝体重！" duration:3.0 position:CSToastPositionCenter];
                    }
                    else{
                        if (_BabyDateBirth == nil) {
                            [self.view makeToast:@"请选择宝宝出生日期！" duration:3.0 position:CSToastPositionCenter];
                        }
                        else{
                            //网络请求
                            //去除最后一个逗号
                            if (![_babyfoot isEqualToString:@""]) {
                                _babyfoot = [_babyfoot substringWithRange:NSMakeRange(0, _babyfoot.length-1)];
                            }
                            if (![_babyimg isEqualToString:@""]) {
                                _babyimg = [_babyimg substringWithRange:NSMakeRange(0, _babyimg.length-1)];
                            }
                            //网络请求
                            NSDictionary *dic = @{
                                                  @"dn":self.user.dn,
                                                  @"type":[NSString stringWithFormat:@"%d",3],
                                                  @"citycode":_shareInstance.citycode,
                                                  @"city":_shareInstance.city,
                                                  @"babyname":_BabyName,
                                                  @"babysex":[NSString stringWithFormat:@"%d",_BabySex],
                                                  @"babyweight":[NSString stringWithFormat:@"%f",_BabyWeight],
                                                  @"babybrith":[self timeStr:_BabyDateBirth],
                                                  @"babyfoot":_babyfoot,
                                                  @"babyimg":_babyimg
                                                  };
                            [_viewmodel fetchChooseStatusWithDic:dic];

                        }
                    }
                }
            }
            break;
    
        default:
            break;
    }
    
    //设置网路请求成功时的代理
    [self fetchSuccess];
}


//设置网路请求成功时的代理
- (void)fetchSuccess{
    //防止出现循环引用
    __unsafe_unretained typeof(self) weakself = self;
    [_viewmodel setBlockWithReturnBlock:^(id returnValue) {
        //直接跳转到首页
        YYTabBarController *tabController = [[YYTabBarController alloc] init];
        [weakself presentViewController:tabController animated:YES completion:nil];
        //更新type
        if (_fromwho == 0) {
            //怀孕，type = 2
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"type" value:@"2"];
            //更改city
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"city" value:weakself.shareInstance.city];
            //更改citycode
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"citycode" value:weakself.shareInstance.citycode];
            if (![weakself.shareInstance.hospitalid isEqualToString:@""]&&![weakself.shareInstance.hospital isEqualToString:@""]) {
                //存hospitalid
                [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"hospitalid" value:weakself.shareInstance.hospitalid];
                //存hospital
                [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"hospital" value:weakself.shareInstance.hospital];
            }
            
            


        }
        if (_fromwho == 1) {
            //备孕 type = 1
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"type" value:@"1"];
            //更改city
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"city" value:weakself.shareInstance.city];
            //更改citycode
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"citycode" value:weakself.shareInstance.citycode];
         }
        if (_fromwho == 2) {
            //宝宝出生 type = 3
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"type" value:@"3"];
            //更改city
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"city" value:weakself.shareInstance.city];
            //更改citycode
            [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"citycode" value:weakself.shareInstance.citycode];
        }
    } WithErrorBlock:^(id errorCode) {
        [weakself.view makeToast:@"请求出错" duration:3.0 position:CSToastPositionCenter];
    } WithFailureBlock:^{
        [weakself.view makeToast:@"网络异常" duration:3.0 position:CSToastPositionCenter];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//返回cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else{
        switch (_fromwho) {
            case 0:
                return 4;
                break;
            case 1:
                return 4;
                break;
            case 2:
                return 6;
                break;
            default:
                return 0;
                break;
        }
        
    }
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_fromwho == 2) {
        YYBaseInfoTableViewCell *cell = [YYBaseInfoTableViewCell cellWithTableView:tableView];
        //section1
        if (indexPath.section == 0) {
            [cell setValue:@{@"title":@"当前城市：",@"city":city}];
            return cell;
        }else{
            NSMutableArray *chushengtitle = [[NSMutableArray alloc] initWithObjects:@"宝宝姓名",@"宝宝性别",@"宝宝体重",@"宝宝出生日期",@"宝宝脚印",@"宝宝图片", nil];
            if (indexPath.row<=3) {
                [cell setValue:@{@"title":[chushengtitle objectAtIndex:indexPath.row],@"city":@""}];
                return cell;
            }else{
                YYBabyInfoTableViewCell *cell1 = [YYBabyInfoTableViewCell cellWithTableView:tableView];
                [cell1 setValue:@{@"title":[chushengtitle objectAtIndex:indexPath.row]}];
                //按钮事件
                cell1.addptoBtn.tag = 20+indexPath.row+1;
                [cell1.addptoBtn addTarget:self action:@selector(pictureBtnDone:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell1;
                
            }
            
        }
    }else{
        YYBaseInfoTableViewCell *cell = [YYBaseInfoTableViewCell cellWithTableView:tableView];
        if (_fromwho == 0) {
            //section1
            if (indexPath.section == 0) {
                [cell setValue:@{@"title":@"当前城市：",@"city":city}];
            }else{
                NSMutableArray *huaiyuntitle = [[NSMutableArray alloc] initWithObjects:@"预产期",@"体检医院",@"初次月经",@"末次月经", nil];
                [cell setValue:@{@"title":[huaiyuntitle objectAtIndex:indexPath.row],@"city":@""}];
            }
        }
        if (_fromwho == 1) {
            //section1
            if (indexPath.section == 0) {
                [cell setValue:@{@"title":@"当前城市：",@"city":city}];
            }else{
                NSMutableArray *beiyunyuntitle = [[NSMutableArray alloc] initWithObjects:@"上次月经时间",@"经期天数",@"经期周期",@"排卵时间", nil];
                
                [cell setValue:@{@"title":[beiyunyuntitle objectAtIndex:indexPath.row],@"city":@""}];
            }
        }
        return cell;
        
    }
    
}
//section之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 15)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f0f1"];
    return view;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50;
    if (_fromwho == 2) {
        if (indexPath.row >= 4) {
            height = 70;
        }
    }
    else{
        height = 50;
    }
    return height;
}
//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //跳转到选择城市界面
        [self performSegueWithIdentifier:@"baseInfoToCity" sender:self];
    }else{
        //怀孕界面
        if (_fromwho == 0) {
            switch (indexPath.row) {
                case 0:
                    //预产期
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"01"];
                    [self createYYPickerView];                    
                    break;
                case 1:
                    //医院
                    //跳转到选择医院界面
                    [self performSegueWithIdentifier:@"baseInfoToHospital" sender:self];
                    break;
                case 2:
                    //初次月经
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"02"];
                    [self createYYPickerView];
                    break;
                case 3:
                    //末次月经
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"03"];
                    [self createYYPickerView];

                    break;
                    
                default:
                    break;
            }
        }
        //备孕界面
        if (_fromwho == 1) {
            switch (indexPath.row) {
                case 0:
                    //上次月经时间
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"11"];
                    [self createYYPickerView];
                    break;
                case 1:
                    //经期天数
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"12"];
                    [self createTextView];
                    break;
                case 2:
                    //经期周期
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"13"];
                    [self createTextView];
                    break;
                case 3:
                    //排卵时间
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"14"];
                    [self createYYPickerView];
                    
                    break;
                    
                default:
                    break;
            }

        }
        //宝宝出生界面
        if (_fromwho == 2) {
            switch (indexPath.row) {
                case 0:
                    //宝宝姓名
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"21"];
                    [self createTextView];
                    break;
                case 1:
                    //宝宝性别
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"22"];
                    [self createSexCheckBox];
                    break;
                case 2:
                    //宝宝体重
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"23"];
                    [self createTextView];
                    break;
                case 3:
                    //宝宝出生日期
                    _alertidentifier = [NSString stringWithFormat:@"%@",@"24"];
                    [self createYYPickerView];
                    
                    break;
                case 4:
                    //宝宝脚印
                    //_alertidentifier = [NSString stringWithFormat:@"%@",@"25"];
                    
                    
                    break;
                case 5:
                    //宝宝图片
                    //_alertidentifier = [NSString stringWithFormat:@"%@",@"26"];
                    
                    
                    break;

                default:
                    break;
            }
            
        }
    }
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//cell中的添加图片按妞
- (void)pictureBtnDone:(UIButton *)button{
    _alertidentifier = [NSString stringWithFormat:@"%ld",(long)button.tag];
    [self createPhoto];
}
//拍照
- (void)createPhoto{
    UIAlertController *alertphoto = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *takephoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //sourcetype为相机，判断设备是否支持相机(ipod不支持)，不支持就该为本地相册
        UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            type = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;//允许编辑
        imagepicker.sourceType = type;
        [self presentViewController:imagepicker animated:YES completion:nil];//进入照相界面
    }];
    UIAlertAction *choosephoto = [UIAlertAction actionWithTitle:@"从手机中选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;//允许编辑
        imagepicker.sourceType = type;
        [self presentViewController:imagepicker animated:YES completion:nil];//进入相蒲界面
    }];
    [alertphoto addAction:takephoto];
    [alertphoto addAction:choosephoto];
    [self presentViewController:alertphoto animated:YES completion:nil];

}
//相机点击使用照片或是相蒲选中图片后，将触发该事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //返回上一视图
    [self dismissViewControllerAnimated:YES completion:nil];
    //获取图片
    UIImage *currentimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //相机需要把图片存进相蒲
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (currentimage != nil) {
            //存进相蒲
            UIImageWriteToSavedPhotosAlbum(currentimage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    
    NSData *dataImg = UIImagePNGRepresentation(currentimage);
    UploadFile *upload = [[UploadFile alloc] init];
    upload.delegate = self;
    NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
    [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
    
}
//上传成功
- (void)returnImagePath:(NSString *)imagepath{
    if ([_alertidentifier isEqualToString:@"25"]) {
        _babyfoot = [NSString stringWithFormat:@"%@%@%@",_babyfoot,imagepath,@","];
    }
    if ([_alertidentifier isEqualToString:@"26"]) {
        _babyimg = [NSString stringWithFormat:@"%@%@%@",_babyimg,imagepath,@","];
    }
}
//指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        NSLog(@"savesuccess");
    }else{
        NSLog(@"savefailed");
    }
}
//创建性别选择器
- (void)createSexCheckBox{
    //弹出框
    YYAlertView *alert;
    UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 25, 25)];
    label1.text = @"女:";
    _check0 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(70, 6, 18, 18)];
    _check0.delegate = self;
    _check0.tag = 0;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(145, 3, 25, 25)];
    label2.text = @"男:";
    _check1 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(175, 6, 18, 18)];
    _check1.delegate = self;
    _check1.tag = 1;
    [contentview addSubview:label1];
    [contentview addSubview:_check0];
    [contentview addSubview:label2];
    [contentview addSubview:_check1];
    
    alert = [[YYAlertView alloc] initWithUIView:contentview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 120) WithButtonBlock:^{
        //确定按钮事件
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;

    }];
    
    [alert setLabelText:@"请选择宝宝性别"];
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];

}
//点击checkbox的代理
- (void)didTapCheckBox:(BEMCheckBox*)checkBox{
    if (checkBox.tag == 0&& checkBox.on == YES) {
        [_check1 setOn:NO];
        _BabySex = 1;//到时候向后台传值时－1（这里是为了和_BabySex的初始值0区分开来）
    }
    if (checkBox.tag == 1&& checkBox.on == YES) {
        [_check0 setOn:NO];
        _BabySex = 2;
    }
}
//创建弹出框文字填写器
- (void)createTextView{
    //弹出框
    YYAlertView *alert;

    _ttview = [[UITextField alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
    _ttview.backgroundColor = [UIColor whiteColor];
    _ttview.layer.borderWidth = 0.5;
    _ttview.layer.borderColor = [UIColor cgcolorWithHexString:@"7a7a7a"];
    //左侧缩进
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    _ttview.leftView = view;
    _ttview.leftViewMode = UITextFieldViewModeAlways;

    
    alert = [[YYAlertView alloc] initWithUIView:_ttview frame:CGRectMake((screenWidth-300)/2, (screenHeight-280)/2, 300, 120) WithButtonBlock:^{
        
        if ([_alertidentifier isEqualToString:@"12"]) {
            NSLog(@"%@",_ttview.text);
            _PMSDay = [(_ttview.text) intValue];
            if (_PMSDay<3||_PMSDay>20) {
                 
                [self.view makeToast:@"经期天数范围不合法！" duration:3.0 position:CSToastPositionCenter];
            }else{
                //确定按钮事件
                [self dismissViewControllerAnimated:YES completion:nil];
                self.view.alpha = 1;

            }
        }
        if ([_alertidentifier isEqualToString:@"13"]) {
            NSLog(@"%@",_ttview.text);
            _PMSRound = [(_ttview.text) intValue];
            if (_PMSRound<10||_PMSRound>60) {
                [self.view makeToast:@"经期周期范围不合法！" duration:3.0 position:CSToastPositionCenter];
            }else{
                //确定按钮事件
                [self dismissViewControllerAnimated:YES completion:nil];
                self.view.alpha = 1;
                
            }

        }
        if ([_alertidentifier isEqualToString:@"21"]) {
            NSLog(@"%@",_ttview.text);
            _BabyName = _ttview.text;
            
            //确定按钮事件
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.alpha = 1;

        }
        if ([_alertidentifier isEqualToString:@"23"]) {
            NSLog(@"%@",_ttview.text);
            _BabyWeight = [(_ttview.text) doubleValue];
            
            //确定按钮事件
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.alpha = 1;

        }
        
    }];
    
    
        
        if ([_alertidentifier isEqualToString:@"12"]) {
            _ttview.keyboardType = UIKeyboardTypeNumberPad;
            [alert setLabelText:@"请输入经期天数"];
            _ttview.placeholder = @"请输入经期天数";
        }
        if ([_alertidentifier isEqualToString:@"13"]) {
            _ttview.keyboardType = UIKeyboardTypeNumberPad;
            [alert setLabelText:@"请输入经期周期"];
            _ttview.placeholder = @"请输入经期周期";

        }
        if ([_alertidentifier isEqualToString:@"21"]) {
            _ttview.keyboardType = UIKeyboardTypeDefault;
            [alert setLabelText:@"请输入宝宝姓名"];
            _ttview.placeholder = @"请输入宝宝姓名";

        }
        if ([_alertidentifier isEqualToString:@"23"]) {
            _ttview.keyboardType = UIKeyboardTypeDecimalPad;
            [alert setLabelText:@"请输入宝宝体重"];
            _ttview.placeholder = @"请输入宝宝体重(kg)";
        }

    
    
    
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];

}
//创建时间选择器
- (void)createYYPickerView
{
    //弹出框
    YYAlertView *alert;
    
    _pkview = [[YYPickerView alloc] initWithFrame:CGRectMake(28, 30, 270, 130)];
    //默认选中到某一行
    _pkview.datasource = self;
    
    _pkview.delegate = self;
    [_pkview selectData:-1 row:1];
    [_pkview selectData:0 row:10];
    
    alert = [[YYAlertView alloc] initWithUIView:_pkview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 200) WithButtonBlock:^{
        //确定按钮事件
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;
    }];

    
    if ([_alertidentifier isEqualToString:@"01"]) {
        
        [alert setLabelText:@"选择预产期"];
        _EdcArray = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
    }
    if ([_alertidentifier isEqualToString:@"02"]) {
        [alert setLabelText:@"选择经期日期"];
        _FirstMenstruation = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
    }
    if ([_alertidentifier isEqualToString:@"03"]) {
        [alert setLabelText:@"选择经期日期"];
        _LastMenstruation = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
    }
    if ([_alertidentifier isEqualToString:@"11"]) {
        [alert setLabelText:@"选择上次经期"];
        _PreMenstruation = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];

    }
    if ([_alertidentifier isEqualToString:@"14"]) {
        [alert setLabelText:@"选择排卵时间"];
        _OvulationArray = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
    }
    if ([_alertidentifier isEqualToString:@"24"]) {
        [alert setLabelText:@"选择出生日期"];
        _BabyDateBirth = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];

    }
    
    
    
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}
//列数 column
- (NSInteger)numberOfColumnsInYYPickerView:(YYPickerView *)yypickerview{
        return 3;
    
}
//行数 row
- (NSInteger)yypickerview:(YYPickerView *)yypickerview numberOfRowsInColumn:(NSInteger)column{
    
        switch (column) {
            case 0:
                return _year.count;
                break;
            case 1:
                return _month.count;
                break;
            case 2:
                return _day.count;
                break;
            default:
                return 0;
                break;
        }
    
}
//某列cell的类型（可自定义的cell） 及内容
- (UITableViewCell *)tableview:(UITableView *)tableview cellForColumn:(NSInteger)column atRow:(NSInteger)row{
    //设置一个最大size
    CGSize maxsize = CGSizeMake(screenWidth,screenHeight);
    
    YYPickerCellTableViewCell *pickcell = [YYPickerCellTableViewCell cellWithTableView:tableview];
    
        switch (column) {
            case 0:
                [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_year objectAtIndex:row],@"年"]];
                //文字大小
                CGSize size = [pickcell.titleLabel boundingRectWithSize:maxsize];
                //分割线位置
                [pickcell setLineFrame:size];
                return pickcell;
                break;
            case 1:
                [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_month objectAtIndex:row],@"月"]];
                //文字大小
                CGSize size1 = [pickcell.titleLabel boundingRectWithSize:maxsize];
                //分割线位置
                [pickcell setLineFrame:size1];
                return pickcell;
                break;
            case 2:
                [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[_day objectAtIndex:row],@"日"]];
                //文字大小
                CGSize size2 = [pickcell.titleLabel boundingRectWithSize:maxsize];
                //分割线位置
                [pickcell setLineFrame:size2];
                return pickcell;
                break;
            default:
                return nil;
                break;
        }
    
    
}
//某列cell宽度
- (CGFloat)widthForCellInColumn:(NSInteger)column{
    switch (column) {
        case 0:
            return 100;
            break;
        case 1:
            return 82;
            break;
        case 2:
            return 81;
            break;
        default:
            return 0;
            break;
    }
}
//某行cell高度
- (CGFloat)heightForCellInRow:(YYPickerView *)yypickerview{
    return 40;
}
//可视区域的cell个数
- (NSInteger)numberOfVisibleCell:(YYPickerView *)yypickerview{
    return 3;
}

//选择了某一行的某一列触发
- (void)yypickerview:(YYPickerView *)yypickerview didselectColumn:(NSInteger)column atRow:(NSInteger)row{
    switch (column) {
        case 0:
            if ([_alertidentifier isEqualToString:@"01"]) {
                [_EdcArray replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_EdcArray];
            }
            if ([_alertidentifier isEqualToString:@"02"]) {
                [_FirstMenstruation replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_FirstMenstruation];
            }
            if ([_alertidentifier isEqualToString:@"03"]) {
                [_LastMenstruation replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_LastMenstruation];

            }
            if ([_alertidentifier isEqualToString:@"11"]) {
                [_PreMenstruation replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_PreMenstruation];
            }
            if ([_alertidentifier isEqualToString:@"14"]) {
                [_OvulationArray replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_OvulationArray];

            }
            if ([_alertidentifier isEqualToString:@"24"]) {
                [_BabyDateBirth replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
                
                [self judgeIsNeedRefreshDay:_BabyDateBirth];
            }
            
            break;
        case 1:
            if ([_alertidentifier isEqualToString:@"01"]) {
                [_EdcArray replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];

                [self refreshday:[_EdcArray objectAtIndex:1] year:[_EdcArray objectAtIndex:0]];
            }
            if ([_alertidentifier isEqualToString:@"02"]) {
                [_FirstMenstruation replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                
                [self refreshday:[_FirstMenstruation objectAtIndex:1] year:[_FirstMenstruation objectAtIndex:0]];

            }
            if ([_alertidentifier isEqualToString:@"03"]) {
                [_LastMenstruation replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                
                [self refreshday:[_LastMenstruation objectAtIndex:1] year:[_LastMenstruation objectAtIndex:0]];
            }
            if ([_alertidentifier isEqualToString:@"11"]) {
                [_PreMenstruation replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                
                [self refreshday:[_PreMenstruation objectAtIndex:1] year:[_PreMenstruation objectAtIndex:0]];
            }
            if ([_alertidentifier isEqualToString:@"14"]) {
                [_OvulationArray replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                
                [self refreshday:[_OvulationArray objectAtIndex:1] year:[_OvulationArray objectAtIndex:0]];
            }
            if ([_alertidentifier isEqualToString:@"24"]) {
                [_BabyDateBirth replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
                
                [self refreshday:[_BabyDateBirth objectAtIndex:1] year:[_BabyDateBirth objectAtIndex:0]];
            }
            //更新day的数据
            
            break;
        case 2:
            if ([_alertidentifier isEqualToString:@"01"]) {
                [_EdcArray replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_EdcArray);
            }
            if ([_alertidentifier isEqualToString:@"02"]) {
                [_FirstMenstruation replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_FirstMenstruation);
            }
            if ([_alertidentifier isEqualToString:@"03"]) {
                [_LastMenstruation replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_LastMenstruation);
            }
            if ([_alertidentifier isEqualToString:@"11"]) {
                [_PreMenstruation replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_PreMenstruation);

            }
            if ([_alertidentifier isEqualToString:@"14"]) {
                [_OvulationArray replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_OvulationArray);
            }
            if ([_alertidentifier isEqualToString:@"24"]) {
                [_BabyDateBirth replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
                NSLog(@"%@",_BabyDateBirth);
            }
            break;
    
        default:
            break;
    }
}

//判断是否需要更新day
- (void)judgeIsNeedRefreshDay:(NSMutableArray *)array{
    //假如是二月，就要刷新天
    if ([[array objectAtIndex:1] isEqualToString:@"02"]) {
        [self refreshday:[array objectAtIndex:1] year:[array objectAtIndex:0]];
    }
}

//更新day的数据

- (void)refreshday:(NSString *)month year:(NSString *)year{
    _day =  [DateTools dayInMonth:month year:year];
    [_pkview reloadData:2];
    [_pkview selectData:2 row:1];
}
//把时间数组转为“2015-09-01”类型字符串
- (NSString *)timeStr:(NSMutableArray *)array{
    if (array!=nil) {
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",[array objectAtIndex:0],@"-",[array objectAtIndex:1],@"-",[array objectAtIndex:2]];
        return str;
    }else{
        return @"";
    }
    
}
#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
////     Get the new view controller using [segue destinationViewController].
////     Pass the selected object to the new view controller.
//    
//}


@end
