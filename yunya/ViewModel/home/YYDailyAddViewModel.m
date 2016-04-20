//
//  YYDailyAddViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/3/25.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYDailyAddViewModel.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+EMIKit.h"
#import "SCCameraNavigationController.h"
#import "DoImagePickerController.h"
#import "YYEmoticonKeyboard.h"
#import "YYDailyAddViewController.h"

@interface YYDailyAddViewModel()<LCActionSheetDelegate,SCCameraNavigationControllerDelegate,ImageContainerViewDelegate,UITextViewDelegate,UploadFileDelegate>

@property (nonatomic,strong) YYEmoticonKeyboard *keyboard;
//是否是表情
@property (assign,nonatomic) BOOL isEmoticon;

@end

@implementation YYDailyAddViewModel{
    
    NSInteger imageCount;
    
    
    CGRect buttonOriginFrame;
    CGRect buttonKeyboardFrame;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super initWithViewController:viewController];
    if(self){
        self.isEmoticon = NO;
        self.keyboard = [[YYEmoticonKeyboard alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 216) rows:5 columns:8];
        //需要设置一个通知，获取系统的键盘显示和隐藏消息，然后做出位置改变的操作
        //这里的UIKeyboardWillShowNotification时系统自带的
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

//键盘显示的时候，按钮向上跑，不会被遮盖
-(void)keyboardShow:(NSNotification *)notification{
    //  键盘退出的frame
    CGRect frame = [notification.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _buttonView.sd_layout.bottomSpaceToView(_buttonView.superview,2+frame.size.height);
  
}
//键盘隐藏是，按钮向下回到原先的位置
//这里面尝试一个动画，和没有动画，直接确定位置是一个效果，差不多
-(void)keyboardHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        _buttonView.sd_layout.bottomSpaceToView(_buttonView.superview,0);
    }completion:^(BOOL finished){
        
    }];
}

//输入改变
- (void)textViewDidChange:(YYEmotionTextView *)textView{
    if (textView.inputView != nil) {
        [_contentTextView reloadAttributedText];
    }
    
}

- (void)initViewsOn:(UIView *)view{
    
    
    
    imageCount = 0;
    self.imageArray = [[NSMutableArray alloc] init];
    
    _buttonView = [UIView new];
    _buttonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"write_bg"]];
    _emojiBtn = [UIButton new];
    [_emojiBtn setImage:[UIImage imageNamed:@"write_emoji"] forState:UIControlStateNormal];
    [_emojiBtn addTarget:self action:@selector(emoji:) forControlEvents:UIControlEventTouchUpInside];
    
    _cameraBtn = [UIButton new];
    [_cameraBtn setImage:[UIImage imageNamed:@"write_camera"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView sc_addSubViews:@[_emojiBtn,_cameraBtn]];
    _emojiBtn.sd_layout.heightIs(30).widthIs(30).bottomSpaceToView(_buttonView,15).leftSpaceToView(_buttonView,screenWidth/2-30-15);
    _cameraBtn.sd_layout.heightIs(30).widthIs(30).bottomSpaceToView(_buttonView,15).rightSpaceToView(_buttonView,screenWidth/2-30-15);
    
    [view addSubview:_buttonView];
    _buttonView.sd_layout.heightIs(60);
    _buttonView.sd_layout.leftSpaceToView(view,0).rightSpaceToView(view,0).bottomSpaceToView(view,0);
    
//    buttonOriginFrame = _buttonView.frame;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    _dateLabel = [UILabel new];
    _dateLabel.textColor = [UIColor colorWithHexString:@"FB9BA9"];
    _dateLabel.font = [UIFont boldSystemFontOfSize:15.f];
    NSDate *now = [NSDate date];
    _dateLabel.text = [DateTools dateTimeToString:now];

    _contentTextView = [YYEmotionTextView new];
    _contentTextView.font = [UIFont systemFontOfSize:15.f];
    _contentTextView.layoutManager.allowsNonContiguousLayout = NO;
    _contentTextView.delegate = self;
    
    _containerView = [YYDailyImgContainerView new];
    _containerView.delegate = self;
    _containerView.hiddenDelButton = NO;
    
    
    
    [scrollView sc_addSubViews:@[_dateLabel,_contentTextView,_containerView]];
    
    _dateLabel.sd_layout.leftSpaceToView(scrollView,20).rightSpaceToView(scrollView,20).heightIs(30).topSpaceToView(scrollView,64+20);
    
    _contentTextView.sd_layout.leftSpaceToView(scrollView,20).rightSpaceToView(scrollView,20).heightIs(128).topSpaceToView(_dateLabel,10);
    
    _containerView.sd_layout
    .leftSpaceToView(scrollView,20)
//    .rightSpaceToView(scrollView,20)
    .heightIs(250)
    .topSpaceToView(_contentTextView,10);
    
    scrollView.contentSize = CGSizeMake(0, 600);
    
    [view addSubview:scrollView];
    
    scrollView.sd_layout.bottomSpaceToView(_buttonView,2).leftSpaceToView(view,0).rightSpaceToView(view,0).topSpaceToView(view,0);
    
    
    
    if(((YYDailyAddViewController *)self.viewController).daily){
        [self showDaily:((YYDailyAddViewController *)self.viewController).daily];
    }
}

- (void)showDaily:(Daily *)daily {
    self.contentTextView.text = daily.content;
    self.dateLabel.text = daily.ctime;
    self.containerView.picPathStringsArray = [daily.imgurl componentsSeparatedByString:@","];
}


/**
 *  表情
 *
 *  @param sender
 */
- (void)emoji:(id)sender {
//
    if (!_isEmoticon) {
        if ([_contentTextView isFirstResponder]) {
            [_contentTextView resignFirstResponder];
        }
        
        _contentTextView.inputView = _keyboard;
        [_keyboard settextView:_contentTextView];
        [_contentTextView becomeFirstResponder];
    }else{
        if ([_contentTextView isFirstResponder]) {
            [_contentTextView resignFirstResponder];
        }
        _contentTextView.inputView = nil;
        [_contentTextView becomeFirstResponder];
    }
    _isEmoticon = !_isEmoticon;
}

/**
 *  打开选择照片和拍照
 *
 *  @param sender 
 */
- (void)camera:(id)sender {
    if ([_contentTextView isFirstResponder]) {
        [_contentTextView resignFirstResponder];
    }
    if(imageCount!=9){
        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照",@"从相册选择"] redButtonIndex:-1 delegate:self];
        [sheet show];
    }else{
        [self.viewController.view makeToast:@"无法添加更多图片!"];
    }
}

- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            //拍照
            SCCameraNavigationController *cameraController = [[SCCameraNavigationController alloc] init];
            cameraController.cameraDelegate = self;
            [cameraController showCameraWithParentController:self.viewController];
            break;
        }
        case 1:{
            //从相册选择
            DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
            cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
            cont.delegate = self;
            cont.nMaxCount = 9-imageCount;
            cont.nColumnCount = 3;
            [self.viewController presentViewController:cont animated:YES completion:nil];
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
    NSData *dataImg = UIImagePNGRepresentation(image);
    UploadFile *upload = [[UploadFile alloc] init];
    
    upload.delegate = self;
    NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
    [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
    
    
    [navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)returnImagePath:(NSString *)imagepath {
//
    [self.imageArray addObject:imagepath];
    if(!_containerView.picPathStringsArray){
        _containerView.picPathStringsArray = [[NSArray alloc] init];
    }
    NSLog(@"图片地址:%@",_containerView.picPathStringsArray);
    NSString *string = [NSString stringWithFormat:@"%@%@",imgIP,imagepath];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:_containerView.picPathStringsArray];
    [tempArray addObject:string];
    _containerView.picPathStringsArray = tempArray;
}
#pragma mark - DoImagePickerControllerDelegate
//选择照片的委托
- (void)didCancelDoImagePickerController
{
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        if(aSelected && aSelected.count >0){
            imageCount = imageCount + aSelected.count;
            for (int i=0; i<aSelected.count; i++) {
                NSData *dataImg = UIImagePNGRepresentation(aSelected[i]);
                UploadFile *upload = [[UploadFile alloc] init];
                
                upload.delegate = self;
                NSString *string = [NSString stringWithFormat:@"%@%@",serverIP,@"/uploadfile.do"];
                [upload uploadFileWithURL:[NSURL URLWithString:string] data:dataImg];
            }
        }
    }
}
#pragma mark ImageContainerDelegate
//图片展示委托
- (void)deleteImageAtIndex:(NSInteger)index {
    [self.imageArray removeObjectAtIndex:index];
    imageCount -- ;
    _containerView.picPathStringsArray = self.imageArray;
}

- (void)addDaily:(Daily *)daily {
    NSDictionary *params = [daily mj_keyValues];
    NSLog(@"修改或新增记录:%@",params);
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/addmodifydaily.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self addDailySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)update:(Daily *)daily{
    NSDictionary *params = [daily mj_keyValues];
    NSLog(@"修改或新增记录:%@",params);
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/updatemodifydaily.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self addDailySuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
    
}

- (void)addDailySuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    NSLog(@"记录结果:\n%@",dict);
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        self.returnBlock(@"1");
    }else{
        self.returnBlock(nil);
    }
}

@end
