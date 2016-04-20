//
//  YYWritePostViewController.m
//  yunya
//
//  Created by 陈凯 on 16/4/7.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYWritePostViewController.h"
#import "SCCameraNavigationController.h"
#import "DoImagePickerController.h"

@interface YYWritePostViewController()<LCActionSheetDelegate,SCCameraNavigationControllerDelegate,ImageContainerViewDelegate,UploadFileDelegate>

//viewmodel
@property (strong,nonatomic)YYWritePostViewModel *viewmodel;
@end

@implementation YYWritePostViewController{
    NSInteger imageCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageCount = 0;
    self.imageArray = [[NSMutableArray alloc] init];
    _imagePath = @"";
    //是否有图片存在
    _isimgexiting = 0;
    //viewmodel
    _viewmodel = [[YYWritePostViewModel alloc] initWithViewController:self];
    
    self.title = @"发帖子";
    
    self.isEmoticon = NO;
    
    self.keyboard = [YYEmoticonKeyboard shareInstance:CGRectMake(0, 0, screenWidth, 216) rows:5 columns:8];
    
    [self createView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
}

- (void)save{
    //TODO 上传图片
    for (UIImage *image in self.imageArray) {
        //有图片存在
        _isimgexiting = 1;
        
        NSData *dataImg = UIImagePNGRepresentation(image);
        UploadFile *upload = [[UploadFile alloc] init];
        upload.delegate = self;
        NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
        [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
    }
   
    //如果没有图片，直接发布，有图片则在所有图片上传结束后发布＝》returnImagePath方法里
    if (_isimgexiting == 0) {
        //发帖网络请求
        NSDictionary *dic = @{@"dn":self.user.dn,
                              @"isdoctor":self.user.isdoctor,
                              @"title":_atrTF.text,
                              @"imgurl":_imagePath,
                              @"content":[_atrTV emoticonText],
                              @"memberid":self.user.memberid
                              };
        [_viewmodel fetchAddPostWithDic:dic];
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
            if((NSDictionary*)returnValue){
                [weakSelf.view makeToast:@"帖子发布成功！" duration:3.0 position:CSToastPositionCenter];
                //返回上一页面
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        
        
    }
    
}
/**
 *  上传文件的回调
 *
 *  @param imagepath
 */
- (void)returnImagePath:(NSString *)imagepath{
    _imagePath = [NSString stringWithFormat:@"%@%@%@",_imagePath,imagepath,@","];
    
    NSArray *imgurlarray = [_imagePath componentsSeparatedByString:@","];
    if (imgurlarray.count-1 == _imageArray.count) {
        //去除最后一个逗号
        if (![_imagePath isEqualToString:@""]) {
            _imagePath = [_imagePath substringWithRange:NSMakeRange(0, _imagePath.length-1)];
        }
        //发帖网络请求
        NSDictionary *dic = @{@"dn":self.user.dn,
                              @"isdoctor":self.user.isdoctor,
                              @"title":_atrTF.text,
                              @"imgurl":_imagePath,
                              @"content":[_atrTV emoticonText],
                              @"memberid":self.user.memberid
                              };
        [_viewmodel fetchAddPostWithDic:dic];
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
            if((NSDictionary*)returnValue){
                [weakSelf.view makeToast:@"帖子发布成功！" duration:3.0 position:CSToastPositionCenter];
                //返回上一页面
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
        
        
        
    }
}
/**
 *  初始化视图
 */
- (void)createView{
    
    //需要设置一个通知，获取系统的键盘显示和隐藏消息，然后做出位置改变的操作
    //这里的UIKeyboardWillShowNotification时系统自带的
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //由于重新设置了内容，导致每次都要从顶部跳到最后一行，界面很闪，UITextView 中的 layoutManager(NSLayoutManager) 的是否非连续布局属性，默认是 true，设置为 false 后 UITextView 就不会再自己重置滑动了
    _atrTV.layoutManager.allowsNonContiguousLayout = NO;
    
    _detailImg.delegate = self;
}

//输入改变
- (void)textViewDidChange:(YYEmotionTextView *)textView{
    if (textView.inputView != nil) {
        [self.atrTV reloadAttributedText];
    }
    
}

//键盘显示的时候，按钮向上跑，不会被遮盖
-(void)keyboardShow:(NSNotification *)notification{
    //  键盘退出的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
        _bgImgToBottom.constant = 2+frame.size.height;
        _emojToBottom.constant = 8+frame.size.height;
        _photoToBottom.constant = 8+frame.size.height;
    
}
//键盘隐藏是，按钮向下回到原先的位置
//这里面尝试一个动画，和没有动画，直接确定位置是一个效果，差不多
-(void)keyboardHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        _bgImgToBottom.constant = 2;
        _emojToBottom.constant = 8;
        _photoToBottom.constant = 8;
    }completion:^(BOOL finished){
        
    }];
}
//表情
- (IBAction)WriteEmoj:(UIButton *)sender {
    if (!_isEmoticon) {
        if ([_atrTV isFirstResponder]) {
            [_atrTV resignFirstResponder];
        }
        
        _atrTV.inputView = _keyboard;
        [_keyboard settextView:_atrTV];
        [_atrTV becomeFirstResponder];
    }else{
        if ([_atrTV isFirstResponder]) {
            [_atrTV resignFirstResponder];
        }
        _atrTV.inputView = nil;
        [_atrTV becomeFirstResponder];
    }
    _isEmoticon = !_isEmoticon;
}
//拍照
- (IBAction)WritePhoto:(UIButton *)sender {
    if ([_atrTV isFirstResponder]) {
        [_atrTV resignFirstResponder];
    }
    if ([_atrTF isFirstResponder]) {
        [_atrTF resignFirstResponder];
    }
    if(imageCount!=2){
        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照",@"从相册选择"] redButtonIndex:-1 delegate:self];
        [sheet show];
    }else{
        [self.view makeToast:@"无法添加更多图片!"];
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
            cont.nMaxCount = 2-imageCount;
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
    imageCount ++;
    [self.imageArray addObject:image];
    [_detailImg setup];
    _detailImg.picPathStringsArray = self.imageArray;
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
    [_detailImg setup];
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        if(aSelected && aSelected.count >0){
            imageCount = imageCount + aSelected.count;
            [self.imageArray addObjectsFromArray:aSelected];
            _detailImg.picPathStringsArray = self.imageArray;
        }
        
    }
}
#pragma mark ImageContainerDelegate
//图片展示委托
- (void)deleteImageAtIndex:(NSInteger)index {
    [self.imageArray removeObjectAtIndex:index];
    imageCount -- ;
    _detailImg.picPathStringsArray = self.imageArray;
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
