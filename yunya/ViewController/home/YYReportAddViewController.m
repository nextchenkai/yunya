//
//  YYReportAddViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/12.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYReportAddViewController.h"
#import "YYReportAddViewModel.h"
#import "Inspect.h"
#import "YYReportImageTableViewCell.h"
#import "YYReportItemTableViewCell.h"
#import "YYReportTimeTableViewCell.h"
#import "DateTools.h"
#import "YYPickerCellTableViewCell.h"
#import "SCCameraNavigationController.h"
#import "DoImagePickerController.h"

@interface YYReportAddViewController ()<UITableViewDelegate,UITableViewDataSource,YYPickerViewDelegate,YYPickerViewDataSource,LCActionSheetDelegate,SCCameraNavigationControllerDelegate,UploadFileDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) YYReportAddViewModel *viewModel;
- (IBAction)camera:(id)sender;
@property (nonatomic, copy) NSString *date;

//年份数组
@property(nonatomic,retain) NSMutableArray *year;
//月份数组
@property(nonatomic,retain) NSMutableArray *month;
//天数数组
@property(nonatomic,retain) NSMutableArray *day;
//选择器
@property(nonatomic,strong) YYPickerView *pkview;
//预产期时间数组（年，月，日）
@property(nonatomic,retain) NSMutableArray *EdcArray;

@end

@implementation YYReportAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //年份数组
    _year = [DateTools tenyearsFromNow];
    //月份数组
    _month = [DateTools monthMax];
    //天数数组
    _day = [DateTools dayMax];
    
    NSDate *now = [NSDate date];
    self.date = [DateTools dateToString:now];
    
    self.viewModel = [[YYReportAddViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"新增产检报告";
    self.array = [[NSArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveReport:)];
    
    [self initData];
}

- (void)saveReport:(id)sender {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel addReportWithDN:self.user.dn withMemberId:self.user.memberid withImageUrl:self.imgurl withDate:self.date withReport:self.array];
}

/**
 *  获取产检项目
 */
- (void)initData {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchInspectItemWithDN:self.user.dn withMemberId:self.user.memberid];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.imgurl){
        return self.array.count + 2;
    }else{
        return self.array.count + 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return 1;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 1;
        }
    }
    return ((NSArray *)(((Inspect *)(self.array[section-1])).detail)).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return 0.f;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 5.f;
        }
    }
    return 30.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==0){
        YYReportTimeTableViewCell *cell = [YYReportTimeTableViewCell cellWithTableView:tableView];
        [cell setValue:self.date];
        return cell;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            YYReportImageTableViewCell *cell = [YYReportImageTableViewCell cellWithTableView:tableView];
            NSArray *a = [self.imgurl componentsSeparatedByString:@","];
            [cell setValue:a[0]];
            return cell;
        }
    }
    YYReportItemTableViewCell *cell = [YYReportItemTableViewCell cellWithTableView:tableView];
    [cell setValue:((NSArray *)(((Inspect *)(self.array[section-1])).detail))[row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    NSInteger section = indexPath.section;
    if(section==0){
        return 44.f;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return 96.f;
        }
    }
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    if(section==0){
        return nil;
    }
    if(sections==self.array.count+2){
        if(section==sections-1){
            return nil;
        }
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"FB9BA9" alpha:0.3f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-20, 30)];
    label.text = ((Inspect *)(self.array[section-1])).title;
    label.font = [UIFont systemFontOfSize:17.f];
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [self numberOfSectionsInTableView:tableView];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==0){
        //时间选择器
        [self createYYPickerView];
    }
    else{
        if(sections==self.array.count+2){
            if(section==sections-1){
                //图片
            }else{
                //其他 创建textpicker
                [self createTextViewWithTag:indexPath];
            }
        }
        

    }
    
}

- (void)createTextViewWithTag:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    InspectDetail *detail = ((NSArray *)(((Inspect *)(self.array[section-1])).detail))[row];
    //弹出框
    YYAlertView *alert;
    
    UITextField *_ttview = [[UITextField alloc] initWithFrame:CGRectMake(30, 35, 240, 30)];
    _ttview.backgroundColor = [UIColor whiteColor];
    _ttview.layer.borderWidth = 0.5;
    _ttview.layer.borderColor = [UIColor cgcolorWithHexString:@"7a7a7a"];
    //左侧缩进
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    _ttview.leftView = view;
    _ttview.leftViewMode = UITextFieldViewModeAlways;
    
    
    alert = [[YYAlertView alloc] initWithUIView:_ttview frame:CGRectMake((screenWidth-300)/2, (screenHeight-280)/2, 300, 120) WithButtonBlock:^{
        
        detail.svalue = _ttview.text;
//        [dict setValue:_ttview.text forKey:@"svalue"];
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
        self.view.alpha = 1;
    }];
    
    _ttview.keyboardType = UIKeyboardTypeDefault;
    [alert setLabelText:[NSString stringWithFormat:@"请输入%@",detail.title]];
    _ttview.placeholder = [NSString stringWithFormat:@"请输入%@",detail.title];
    
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
        //开始设置产检时间
        self.date = [self timeStr:_EdcArray];
        [self.tableView reloadData];
    }];
    [alert setLabelText:@"选择产检时间"];
    _EdcArray = [NSMutableArray arrayWithObjects:[_year objectAtIndex:10],[_month objectAtIndex:1],[_day objectAtIndex:1], nil];
    
    
    
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
            
            [_EdcArray replaceObjectAtIndex:column withObject:[_year objectAtIndex:row]];
            [self judgeIsNeedRefreshDay:_EdcArray];
            break;
        case 1:
            [_EdcArray replaceObjectAtIndex:column withObject:[_month objectAtIndex:row]];
            [self refreshday:[_EdcArray objectAtIndex:1] year:[_EdcArray objectAtIndex:0]];
            //更新day的数据
            break;
        case 2:
            [_EdcArray replaceObjectAtIndex:column withObject:[_day objectAtIndex:row]];
            NSLog(@"%@",_EdcArray);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)camera:(id)sender {
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照",@"从相册选择"] redButtonIndex:-1 delegate:self];
    [sheet show];
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
    NSData *dataImg = UIImagePNGRepresentation(image);
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
            NSData *dataImg = UIImagePNGRepresentation(aSelected[0]);
            UploadFile *upload = [[UploadFile alloc] init];
            
            upload.delegate = self;
            NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
            [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
        }
    }
}

- (void)returnImagePath:(NSString *)imagepath {
    self.imgurl = imagepath;
    [self.tableView reloadData];
}
@end
