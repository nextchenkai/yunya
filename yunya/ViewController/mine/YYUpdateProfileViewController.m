//
//  YYUpdateProfileViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/6.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYUpdateProfileViewController.h"
#import "YYUpdateProfileViewModel.h"
#import "YYMyProfileHeadTableViewCell.h"
#import "YYMyProfileNormalTableViewCell.h"
#import "SCCameraNavigationController.h"
#import "DoImagePickerController.h"
#import "UploadFile.h"
#import "YYChooseCityViewController.h"
#import "OperateNSUserDefault.h"
#import "YYAlertViewController.h"
#import "YYPickerCellTableViewCell.h"
#import "BEMCheckBox.h"
#import "BloodType.h"
#import "YYChooseDiseaseViewController.h"
#import "YYPushValueInstance.h"

@interface YYUpdateProfileViewController ()<YYPickerViewDelegate,YYPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,LCActionSheetDelegate,SCCameraNavigationControllerDelegate,UploadFileDelegate,BEMCheckBoxDelegate,YYChooseDiseaseDelegate> {
    //年份数组
    NSMutableArray *years;
    //月份数组
    NSMutableArray *months;
    //天数数组
    NSMutableArray *days;
    //流产日期数组
    NSMutableArray *EdcArray;
    
    YYPickerView *pkview;
    //性别数组
    NSMutableArray *sexArray;
    //生产方式数组
    NSMutableArray *birthTypeArray;

    NSMutableArray *bloodCheckBoxArray;
    
    NSInteger flag;//0:既病史 1:现病史
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YYUpdateProfileViewModel *viewModel;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *bloodArray;
@property (nonatomic, strong) UIImage *headImage;
//单例
@property (nonatomic,strong) YYPushValueInstance *shareInstance;
@end

@implementation YYUpdateProfileViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.user = [OperateNSUserDefault readUserDefault];
    if(self.user){
        _shareInstance = [YYPushValueInstance shareInstance];
        if (_shareInstance.city == nil||[_shareInstance.city isEqualToString:@""]) {
            _shareInstance.city = self.user.city;

        }
        self.profile.city = _shareInstance.city;
        self.array = [self.viewModel turnWithProfile:self.profile];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[YYUpdateProfileViewModel alloc] initWithViewController:self];
    
    [self fetchBlood];
    
    sexArray = [NSMutableArray arrayWithArray:[self.profile.sex componentsSeparatedByString:@","]];
    birthTypeArray = [NSMutableArray arrayWithArray:[self.profile.birthtype componentsSeparatedByString:@","]];;
    
    self.title = @"修改个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveProfile:)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.array = [self.viewModel turnWithProfile:self.profile];
    [self.tableView reloadData];
}

/**
 *  页面即将消失，shareInstance恢复初始化值
 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _shareInstance.city = @"";
    _shareInstance.citycode = @"";
    _shareInstance.hospital = @"";
    _shareInstance.hospitalid = @"";
}
- (void)fetchBlood {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.bloodArray = [NSArray arrayWithArray:returnValue];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchBloodType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0){
        return 0.f;
    }
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==0 && row==0){
        YYMyProfileHeadTableViewCell *cell = [YYMyProfileHeadTableViewCell cellWithTableView:tableView];
        [cell setValue:((NSArray *)(self.array[section]))[row]];
        return cell;
    }else{
        YYMyProfileNormalTableViewCell *cell = [YYMyProfileNormalTableViewCell cellWithTableView:tableView];
        NSArray *arr = self.array[section];
        [cell setValue:arr[row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==0){
        switch (row) {
            case 0:
                //头像
                {
                    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照",@"从相册选择"] redButtonIndex:-1 delegate:self];
                    [sheet show];
                }
                break;
            case 1:
                //用户昵称
                [self createAlertTextFieldWithTag:1];
                break;
            case 2:
                //地区
            {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                YYChooseCityViewController *viewController = [story instantiateViewControllerWithIdentifier:@"choosecity"];
                [self.navigationController pushViewController:viewController animated:YES];
                }
                break;
            case 3:
                //年龄
                [self createAlertTextFieldWithTag:2];
                break;
            case 4:
                //职业
                [self createAlertTextFieldWithTag:3];
                break;
            case 5:
                //婚龄
                [self createAlertTextFieldWithTag:4];
                break;
            case 6:
                //身高
                [self createAlertTextFieldWithTag:5];
                break;
            case 7:
                //体重
                [self createAlertTextFieldWithTag:6];
                break;
            case 8:
                //既病史
                // 跳转下一页
                flag = 0;
                [self performSegueWithIdentifier:@"tochoosedisease" sender:nil];
                break;
            case 9:
                //现病史
                // 跳转下一页
                flag = 1;
                [self performSegueWithIdentifier:@"tochoosedisease" sender:nil];
                break;
            case 10:
                //血型
                // 单选
                [self createCheckBoxWithTag:1 withIsMulti:NO];
                break;
            default:
                break;
        }
    }else if(section==1){
        switch (row) {
            case 0:
                //已生育数
                [self createAlertTextFieldWithTag:7];
                break;
            case 1:
                //已生儿童年龄
                [self createAlertTextFieldWithTag:8];
                break;
            case 2:
                //儿童性别
                [self createCheckBoxWithTag:2 withIsMulti:YES];
                break;
            case 3:
                //生育方式
                [self createCheckBoxWithTag:3 withIsMulti:YES];
                break;
            case 4:
                //生育前流产次数
                [self createAlertTextFieldWithTag:9];
                break;
            case 5:
                //生育后流产次数
                [self createAlertTextFieldWithTag:10];
                break;
            case 6:
                [self createYYPickerView];
                break;
            default:
                break;
        }
    }else{
        switch (row) {
            case 0:
                //配偶年龄
                [self createAlertTextFieldWithTag:11];
                break;
            case 1:
                //配偶职业
                [self createAlertTextFieldWithTag:12];
                break;
            default:
                break;
        }
    }
}

- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            //拍照
            SCCameraNavigationController *cameraController = [[SCCameraNavigationController alloc] init];
            cameraController.cameraDelegate = self;
            [cameraController showCameraWithParentController:self];
            break;
        }
        case 1:{
            //从相册选择
            DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
            cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
            cont.delegate = self;
            cont.nMaxCount = 1;
            cont.nColumnCount = 3;
            [self presentViewController:cont animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark - SCCameraNavigationController delegate
//拍照委托
- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    
    self.headImage = image;
    NSData *dataImg = UIImagePNGRepresentation(self.headImage);
    UploadFile *upload = [[UploadFile alloc] init];
    upload.delegate = self;
    NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
    [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
    [navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - DoImagePickerControllerDelegate
//选择照片的委托
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        if(aSelected && aSelected.count >0){
            self.headImage = aSelected[0];
            //上传头像
            NSData *dataImg = UIImagePNGRepresentation(self.headImage);
            UploadFile *upload = [[UploadFile alloc] init];
            upload.delegate = self;
            NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
            [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
        }
        
    }
}

- (void)returnImagePath:(NSString *)imagepath {
    self.profile.headimg = imagepath;
    self.array = [self.viewModel turnWithProfile:self.profile];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"tochoosedisease"]){
        YYChooseDiseaseViewController *viewController = segue.destinationViewController;
        viewController.flag = flag;
        viewController.delegate = self;
    }
}

/**
 *  创建输入框选择器
 *
 *  @param tag
 */
- (void)createAlertTextFieldWithTag:(NSInteger)tag {
    //弹出框
    YYAlertView *alert;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [UIColor cgcolorWithHexString:@"7a7a7a"];
    //左侧缩进
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    alert = [[YYAlertView alloc] initWithUIView:textField frame:CGRectMake((screenWidth -300)/2, (screenHeight-280)/2, 300, 120) WithButtonBlock:^{
        NSString *str = textField.text;
        if(tag==1){
            self.profile.nickname = str;
        }else if(tag==2){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.age = str;
        }else if(tag==3){
            self.profile.profession = str;
        }else if(tag==4){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.marryage = str;
        }else if(tag==5){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.height = str;
        }else if(tag==6){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.weight = str;
        }else if(tag==7){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.birthhistory = str;
        }else if(tag==8){
            if(str.length>0){
                str = [str stringByReplacingOccurrencesOfString:@"，" withString:@","];
            }
            self.profile.childrenage = str;
        }else if(tag==9){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.beforebirthabortion = str;
        }else if(tag==10){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.afterbirthabortion = str;
        }else if(tag==11){
            if ([str isEqualToString:@""]||str == nil) {
                str = @"0";
            }
            self.profile.mrage = str;
        }else if(tag==12){
            self.profile.mroccupation = str;
        }
        
        
        self.array = [self.viewModel turnWithProfile:self.profile];
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;
    }];
    if(tag==1){
        [alert setLabelText:@"用户昵称"];
        textField.placeholder = @"请输入昵称";
    }else if(tag==2){
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [alert setLabelText:@"年龄"];
        textField.placeholder = @"请输入年龄";
    }else if(tag==3){
        [alert setLabelText:@"职业"];
        textField.placeholder = @"请输入职业";
    }else if(tag==4){
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [alert setLabelText:@"婚龄"];
        textField.placeholder = @"请输入婚龄";
    }else if(tag==5){
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [alert setLabelText:@"身高"];
        textField.placeholder = @"请输入身高,单位:cm";
    }else if(tag==6){
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [alert setLabelText:@"体重"];
        textField.placeholder = @"请输入体重,单位:kg";
    }else if(tag==7){
        [alert setLabelText:@"已生育数"];
        textField.placeholder = @"请输入已生育数";
    }else if(tag==8){
        textField.keyboardType = UIKeyboardTypeDefault;
        [alert setLabelText:@"已育儿童年龄"];
        textField.placeholder = @"如果有多个儿童,请以','隔开";
    }else if(tag==9){
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [alert setLabelText:@"生育前流产次数"];
        textField.placeholder = @"请输入生育前流产次数";
    }else if(tag==10){
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [alert setLabelText:@"生育后流产次数"];
        textField.placeholder = @"请输入生育后流产次数";
    }else if(tag==11){
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [alert setLabelText:@"配偶年龄"];
        textField.placeholder = @"请输入配偶年龄";
    }else if(tag==12){
        textField.keyboardType = UIKeyboardTypeDefault;
        [alert setLabelText:@"配偶职业"];
        textField.placeholder = @"请输入配偶职业";
    }
    
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];
}

//创建时间选择器
- (void)createYYPickerView
{
    
    //年份数组
    years = [DateTools tenyearsFromNow];
    //月份数组
    months = [DateTools monthMax];
    //天数数组
    days = [DateTools dayMax];
    
    //弹出框
    YYAlertView *alert;
    
    pkview = [[YYPickerView alloc] initWithFrame:CGRectMake(28, 30, 270, 130)];
    //默认选中到某一行
    pkview.datasource = self;
    
    pkview.delegate = self;
    [pkview selectData:-1 row:1];
    [pkview selectData:0 row:10];
    
    alert = [[YYAlertView alloc] initWithUIView:pkview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 200) WithButtonBlock:^{
        //确定按钮事件
        self.profile.lastabortiondate = [self timeStr:EdcArray];
        
        self.array = [self.viewModel turnWithProfile:self.profile];
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;
    }];
    
    

        [alert setLabelText:@"选择最后一次流产日期"];
        EdcArray = [NSMutableArray arrayWithObjects:[years objectAtIndex:10],[months objectAtIndex:1],[days objectAtIndex:1], nil];
    YYAlertViewController *Controller = [[YYAlertViewController alloc] init];
    [Controller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:Controller animated:YES completion:nil];
    
}
#pragma mark - YYPickView

//列数 column
- (NSInteger)numberOfColumnsInYYPickerView:(YYPickerView *)yypickerview{
    return 3;
    
}

//行数 row
- (NSInteger)yypickerview:(YYPickerView *)yypickerview numberOfRowsInColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return years.count;
            break;
        case 1:
            return months.count;
            break;
        case 2:
            return days.count;
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
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[years objectAtIndex:row],@"年"]];
            //文字大小
            CGSize size = [pickcell.titleLabel boundingRectWithSize:maxsize];
            //分割线位置
            [pickcell setLineFrame:size];
            return pickcell;
            break;
        case 1:
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[months objectAtIndex:row],@"月"]];
            //文字大小
            CGSize size1 = [pickcell.titleLabel boundingRectWithSize:maxsize];
            //分割线位置
            [pickcell setLineFrame:size1];
            return pickcell;
            break;
        case 2:
            [pickcell setLabelText:[NSString stringWithFormat:@"%@%@",[days objectAtIndex:row],@"日"]];
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

- (void)yypickerview:(YYPickerView *)yypickerview didselectColumn:(NSInteger)column atRow:(NSInteger)row {
    switch (column) {
        case 0:
            [EdcArray replaceObjectAtIndex:column withObject:[years objectAtIndex:row]];
            
            [self judgeIsNeedRefreshDay:EdcArray];
            break;
        case 1:
            [EdcArray replaceObjectAtIndex:column withObject:[months objectAtIndex:row]];
            [self refreshday:[EdcArray objectAtIndex:1] year:[EdcArray objectAtIndex:0]];
            break;
        case 2:
            [EdcArray replaceObjectAtIndex:column withObject:[days objectAtIndex:row]];
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
    days =  [DateTools dayInMonth:month year:year];
    [pkview reloadData:2];
    [pkview selectData:2 row:1];
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

- (void)createCheckBoxWithTag:(NSInteger)tag withIsMulti:(BOOL)isMulti {
    //弹出框
    YYAlertView *alert;
    
    if(tag==2){
        UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
        NSString *sexStr = self.profile.sex;
        sexArray = [NSMutableArray arrayWithArray:[sexStr componentsSeparatedByString:@","]];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 3, 35, 25)];
        label1.font = [UIFont systemFontOfSize:14.f];
        label1.text = @"女";
        BEMCheckBox *check0 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(70, 6, 18, 18)];
        check0.onTintColor = [UIColor colorWithHexString:@"FB9BA9"];
        check0.onCheckColor = [UIColor colorWithHexString:@"FB9BA9"];
        if([sexArray containsObject:@"0"]){
            check0.on = YES;
        }else{
            check0.on = NO;
        }
        check0.delegate = self;
        check0.tag = 2000;
        
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(155, 3, 35, 25)];
        label2.font = [UIFont systemFontOfSize:14.f];
        label2.text = @"男";
        BEMCheckBox *check1 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(175, 6, 18, 18)];
        check1.onTintColor = [UIColor colorWithHexString:@"FB9BA9"];
        check1.onCheckColor = [UIColor colorWithHexString:@"FB9BA9"];
        if([sexArray containsObject:@"1"]){
            check1.on = YES;
        }else{
            check1.on = NO;
        }
        check1.delegate = self;
        check1.tag = 2001;
        [contentview addSubview:label1];
        [contentview addSubview:check0];
        [contentview addSubview:label2];
        [contentview addSubview:check1];
        
        alert = [[YYAlertView alloc] initWithUIView:contentview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 120) WithButtonBlock:^{
            //确定按钮事件
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.alpha = 1;
            
        }];
        
        [alert setLabelText:@"请选择已育儿童性别"];
        
    }
    if(tag==3){
        UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
        NSString *birthStr = self.profile.birthtype;
        birthTypeArray = [NSMutableArray arrayWithArray:[birthStr componentsSeparatedByString:@","]];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 3, 45, 25)];
        label1.font = [UIFont systemFontOfSize:14.f];
        label1.text = @"顺产";
        BEMCheckBox *check0 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(70, 6, 18, 18)];
        check0.onTintColor = [UIColor colorWithHexString:@"FB9BA9"];
        check0.onCheckColor = [UIColor colorWithHexString:@"FB9BA9"];
        if([birthTypeArray containsObject:@"0"]){
            check0.on = YES;
        }else{
            check0.on = NO;
        }
        check0.delegate = self;
        check0.tag = 3000;
        
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(135, 3, 45, 25)];
        label2.text = @"剖腹产";
        label2.font = [UIFont systemFontOfSize:14.f];
        BEMCheckBox *check1 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(180, 6, 18, 18)];
        check1.onTintColor = [UIColor colorWithHexString:@"FB9BA9"];
        check1.onCheckColor = [UIColor colorWithHexString:@"FB9BA9"];
        if([birthTypeArray containsObject:@"1"]){
            check1.on = YES;
        }else{
            check1.on = NO;
        }
        check1.delegate = self;
        check1.tag = 3001;
        [contentview addSubview:label1];
        [contentview addSubview:check0];
        [contentview addSubview:label2];
        [contentview addSubview:check1];
        
        alert = [[YYAlertView alloc] initWithUIView:contentview frame:CGRectMake((screenWidth-300)/2, (screenHeight-200)/2, 300, 120) WithButtonBlock:^{
            //确定按钮事件
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.alpha = 1;
            
        }];
        
        [alert setLabelText:@"请选择胎儿形式"];
        
    }
    
    if(tag==1){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 35, 240, 30*self.bloodArray.count)];
        bloodCheckBoxArray = [[NSMutableArray alloc] init];
        for(int i = 0;i<self.bloodArray.count;i ++){
            BloodType *type = self.bloodArray[i];
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 3+30*i, 120, 25)];
            label1.font = [UIFont systemFontOfSize:14.f];
            label1.text = type.evalue;
            
            BEMCheckBox *check1 = [[BEMCheckBox alloc] initWithFrame:CGRectMake(150, 6+30*i, 18, 18)];
            if([type.id isEqualToString:self.profile.bloodtypeid]){
                check1.on = YES;
            }
            check1.onTintColor = [UIColor colorWithHexString:@"FB9BA9"];
            check1.onCheckColor = [UIColor colorWithHexString:@"FB9BA9"];
            check1.delegate = self;
            check1.tag = 1000 + i;
            [contentView addSubview:label1];
            [contentView addSubview:check1];
            [bloodCheckBoxArray addObject:check1];
        }
        alert = [[YYAlertView alloc] initWithUIView:contentView frame:CGRectMake((screenWidth-300)/2, (screenHeight-(90+contentView.frame.size.height))/2, 300, 90+contentView.frame.size.height) WithButtonBlock:^{
            //确定按钮事件
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.alpha = 1;
            
        }];
        
        [alert setLabelText:@"请选择血型"];
    }
    
    YYAlertViewController *alertcontroller = [[YYAlertViewController alloc] init];
    [alertcontroller.view addSubview:alert];
    
    self.view.alpha = 0.3;
    [self presentViewController:alertcontroller animated:YES completion:nil];
}

- (void)didTapCheckBox:(BEMCheckBox*)checkBox{
    if (checkBox.tag == 2000) {
        if(checkBox.on == YES){
            [sexArray addObject:@"0"];
        }else{
            if([sexArray containsObject:@"0"]){
                [sexArray removeObject:@"0"];
            }
        }
    }
    if (checkBox.tag == 2001) {
        if(checkBox.on == YES){
            [sexArray addObject:@"1"];
        }else{
            if([sexArray containsObject:@"1"]){
                [sexArray removeObject:@"1"];
            }
        }

    }
    
    if (checkBox.tag == 3000) {
        if(checkBox.on == YES){
            [birthTypeArray addObject:@"0"];
        }else{
            if([birthTypeArray containsObject:@"0"]){
                [birthTypeArray removeObject:@"0"];
            }
        }
    }
    if (checkBox.tag == 3001) {
        if(checkBox.on == YES){
            [birthTypeArray addObject:@"1"];
        }else{
            if([birthTypeArray containsObject:@"1"]){
                [birthTypeArray removeObject:@"1"];
            }
        }
        
    }
    
    if(checkBox.tag<2000){
        if(checkBox.on == YES){
            self.profile.bloodtype = ((BloodType *)(self.bloodArray[checkBox.tag-1000])).evalue;
            self.profile.bloodtypeid = ((BloodType *)(self.bloodArray[checkBox.tag-1000])).id;
            for (BEMCheckBox *check in bloodCheckBoxArray) {
                if(checkBox.tag != check.tag){
                    check.on = NO;
                }
            }
        }
    }
    if (checkBox.tag == 2000 || checkBox.tag == 2001) {
        self.profile.sex = [sexArray componentsJoinedByString:@","];
    }
    if (checkBox.tag == 3000 || checkBox.tag == 3001) {
        self.profile.birthtype = [birthTypeArray componentsJoinedByString:@","];
    }
    
    
    self.array = [self.viewModel turnWithProfile:self.profile];
    [self.tableView reloadData];
}

- (void)passDisease:(NSArray *)array {
    if(flag==0){
        self.profile.diseasehistory = array;
    }else{
        self.profile.diseasenow = array;
    }
    self.array = [self.viewModel turnWithProfile:self.profile];
    [self.tableView reloadData];
}

- (void)saveProfile:(id)sender {
    self.profile.memberid = self.user.memberid;
    self.profile.dn = self.user.dn;
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            NSNumber *success = returnValue;
            if([success longValue]==1){
//            保存成功
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                //更新userdefault里city和citycode
                //更改city
                [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"city" value:weakSelf.shareInstance.city];
                //更改citycode
                [OperateNSUserDefault addUserDefaultWithKeyAndValue:@"citycode" value:weakSelf.shareInstance.citycode];

            }else{
                [weakSelf.view makeToast:@"修改个人资料失败"];
            }
        }
    } WithErrorBlock:^(id errorCode) {
        [weakSelf.view makeToast:@"修改个人资料失败"];
    } WithFailureBlock:^{
        [weakSelf.view makeToast:@"修改个人资料失败"];
    }];
    [self.viewModel updateProfile:self.profile];
}

@end
