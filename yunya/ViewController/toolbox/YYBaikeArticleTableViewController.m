//
//  YYBaikeArticleViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaikeArticleTableViewController.h"
#import "YYBaikeArticlesViewModel.h"
#import "Article.h"
#import "YYArticleDetailViewController.h"

@interface YYBaikeArticleTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) YYBaikeArticlesViewModel *viewModel;

@property (nonatomic, strong) Article *selectedArticle;
@end

@implementation YYBaikeArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"文章列表";
    self.viewModel = [[YYBaikeArticlesViewModel alloc] initWithViewController:self];
    
    [self getArticleList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getArticleList {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
        }
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [self.viewModel fetchArticleArrayWithTopicId:self.subject.topicid];
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    YYMusicTableViewCell *cell = [YYMusicTableViewCell cellWithTableView:tableView];
    //    [cell setValue:self.array[indexPath.row]];
    //    return cell;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYMusicTableViewCell"];
    cell.textLabel.text = ((Article *)(self.array[indexPath.row])).title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //单击文章,查看文章详情
    self.selectedArticle = (Article *)(self.array[indexPath.row]);
    [self performSegueWithIdentifier:@"toarticledetail" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"toarticledetail"]){
        YYArticleDetailViewController *viewController = segue.destinationViewController;
        viewController.articleId = self.selectedArticle.id;
    }
}


@end
