//
//  YYArticleDetailViewController.m
//  yunya
//
//  Created by WongSuechang on 16/4/1.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYArticleDetailViewController.h"
#import "YYArticleDetailViewModel.h"

@interface YYArticleDetailViewController (){
    UIScrollView *scrollView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    YYDailyImgContainerView *imagesView;
}
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YYArticleDetailViewModel *viewModel;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//@property (weak, nonatomic) IBOutlet YYDailyImgContainerView *imagesView;

@end

@implementation YYArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[YYArticleDetailViewModel alloc] initWithViewController:self];
    
    
    self.title = @"详情";
    
    [self fetchArticledetail];
    
}

- (void)initViewsWithArticle:(Article *)article {
    
    //设置一个行高上限
    CGSize size = CGSizeMake(screenWidth-16,20000);
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
//    scrollView.backgroundColor = [UIColor grayColor];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, screenWidth-16, 21)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    titleLabel.text = article.title;
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //计算标题高度
    CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(size.width, size.height)];
    if(titleSize.width>=screenWidth-16){
        titleSize.width = screenWidth-16;
        titleLabel.frame = CGRectMake(8, 8, titleSize.width, titleSize.height);
    }else{
        titleLabel.frame = CGRectMake((screenWidth-16-titleSize.width)/2, 8, titleSize.width, titleSize.height);
    }
    
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, titleLabel.frame.origin.y + titleLabel.frame.size.height + 8, screenWidth-16, 21)];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];
    contentLabel.font = [UIFont boldSystemFontOfSize:13.f];
    contentLabel.text = article.content;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //计算内容高度
    CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(size.width, size.height)];
    contentLabel.frame = CGRectMake(8, titleLabel.frame.origin.y + titleLabel.frame.size.height + 8, contentSize.width, contentSize.height);
    
    imagesView = [[YYDailyImgContainerView alloc] initWithFrame:CGRectMake(8, contentLabel.frame.origin.y + contentLabel.frame.size.height + 8, screenWidth-16, 250)];
    
    NSArray *imageArray = [article.img componentsSeparatedByString:@","];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(NSString *string in imageArray){
        NSString *str = [NSString stringWithFormat:@"%@%@",imgIP,string];
        [array addObject:str];
    }
    imagesView.picPathStringsArray = array;
    [scrollView sc_addSubViews:@[titleLabel,contentLabel,imagesView]];
    NSLog(@"\nscroll的x:%f,\nscroll的width:%f,\n内容y:%f,\n内容height:%f",scrollView.frame.origin.x,scrollView.frame.size.width,contentLabel.frame.origin.y,contentLabel.size.height);
    scrollView.contentSize = CGSizeMake(0, imagesView.frame.origin.y + 250 +10);
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchArticledetail {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            [weakSelf initViewsWithArticle:returnValue];
//            [weakSelf.viewModel initViewsWithArticle:returnValue onScrollView:weakSelf.scrollView];
//            [weakSelf.view addSubview:weakSelf.scrollView];
        }
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchArticleDetailWithArticleId:self.articleId];
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
