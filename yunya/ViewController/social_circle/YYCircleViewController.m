//
//  YYCircleViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYCircleViewController.h"
#import "YYDetailPostViewController.h"
#import "YYForumCell.h"
#import "YYFriendCell.h"
#import "YYRefreshHeaderView.h"
#import "YYAutoFooterView.h"
#import "Posting.h"
#import "Friends.h"
#import "YYRightMenu.h"
#import "YYDetailPostViewController.h"

@interface YYCircleViewController ()<LFLUISegmentedControlDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//viewmodel
@property (strong,nonatomic)YYCircleViewModel *viewmodel;

@property (nonatomic, assign) int currentPage;

//@property (nonatomic,assign) int totalPage;
//帖子列表
@property (nonatomic, strong) NSMutableArray *postarray;
//好友列表
@property (nonatomic, strong) NSMutableArray *friendarray;

//tables
@property (nonatomic, strong) NSMutableArray *tablearray;

@property (nonatomic,strong) Posting *post;

@property (nonatomic,strong) Friends *friend;
//弹出框
@property(nonatomic,strong) YYRightMenu *rightmenu;
//记录弹出框是否显示着
@property(nonatomic,assign)BOOL isshow;
//帖子id
@property(nonatomic,copy) NSString *postid;
@end

@implementation YYCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        
    //viewmodel
    _viewmodel = [[YYCircleViewModel alloc] initWithViewController:self];
    
    _tablearray = [[NSMutableArray alloc] init];
    
    //初始化视图
    [self createSegument];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
}

//顶部degment
- (void)createSegument{
    //title
    _segment = [[LFLUISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 80, 28)];
    _segment.delegate = self;
    [_segment AddSegumentArray:[NSArray arrayWithObjects:@"热帖",@"好友", nil]];
    self.navigationItem.titleView = _segment;
    //右侧rightbar
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"add" highImageName:@"add" target:self action:@selector(openAddView)];
    _isshow = NO;
    //创建滚动视图
    [self createMainScroll];
}
/**
 *  发帖子，加好友
 */
- (void)openAddView{
    if (!_isshow) {
        _rightmenu = [[YYRightMenu alloc] initWithFrame:CGRectMake(screenWidth-90, 64, 90, 70) firstBlock:^{
            //发帖
            [self performSegueWithIdentifier:@"circletowritepost" sender:nil];
            [_rightmenu removeFromSuperview];
        } secondBlock:^{
            //加好友
            [self performSegueWithIdentifier:@"circletoaddfriend" sender:nil];
            [_rightmenu removeFromSuperview];
        }];
        [_rightmenu setButtonTitlesWithArray:[NSArray arrayWithObjects:@"发帖",@"加好友", nil]];
        [self.view addSubview:_rightmenu];
        _isshow = YES;
    }else{
        [_rightmenu removeFromSuperview];
        _isshow = NO;
    }
    
}
- (void)createMainScroll{
    _mainscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
    _mainscroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainscroll];
    _mainscroll.tag = -1;//用于判断UIScrollViewDelegate触发时是谁触发的
    _mainscroll.bounces = NO;
    _mainscroll.pagingEnabled = YES;
    _mainscroll.contentSize = CGSizeMake(screenWidth*2, 0);
    _mainscroll.delegate = self;
    //添加tableview
    [self createTableview];
}
//添加tableview
- (void)createTableview{
    for (int i = 0; i<2; i++) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(i*screenWidth,0 , screenWidth, screenHeight-64)];
        tableview.tag = i;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor whiteColor];
        tableview.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
        //论坛数据的tableview需要分页
        if (i == 0) {
            //设置下拉刷新和上拉加载
            tableview.mj_header = [YYRefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            [tableview.mj_header beginRefreshing];
            
            tableview.mj_footer = [YYAutoFooterView footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
        [_tablearray addObject:tableview];
        [_mainscroll addSubview:tableview];
    }
}
- (void)loadNewData {
    self.currentPage = 0;
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
        if((NSDictionary*)returnValue){
//            weakSelf.totalPage = [[returnValue objectForKey:@"totalpage"] intValue];
            weakSelf.postarray = [NSMutableArray arrayWithArray:[[returnValue objectForKey:@"forum"] objectForKey:@"data"]];
        }
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]) reloadData];
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_header endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_header endRefreshing];
    } WithFailureBlock:^{
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_header endRefreshing];
    }];
    NSLog(@"%@",self.user.isdoctor);
    NSDictionary *dic = @{@"dn":self.user.dn,
                          @"isdoctor":self.user.isdoctor,
                          @"currentpage":[NSString stringWithFormat:@"%d",self.currentPage]};
    
    [self.viewmodel fetchPostWithDic:dic];
}

- (void)loadMoreData {
    self.currentPage ++;
//    if(self.currentPage>self.totalPage){
//        self.currentPage --;
//        [((UITableView *)[self.tablearray objectAtIndex:0]).mj_footer endRefreshingWithNoMoreData];
//    }
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
        if((NSDictionary*)returnValue){
//            weakSelf.totalPage = [[returnValue objectForKey:@"totalpage"] intValue];
            //计数数组，用来判断是否还有数据
            NSMutableArray *countArray = [NSMutableArray arrayWithArray:[[returnValue objectForKey:@"forum"] objectForKey:@"data"]];
           
            if (countArray.count > 0) {
                 weakSelf.postarray = countArray;
                [((UITableView *)[weakSelf.tablearray objectAtIndex:0]) reloadData];
                [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_footer endRefreshing];
            }else{
                weakSelf.currentPage --;
                [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_footer endRefreshingWithNoMoreData];
            }

        }
        
        
    } WithErrorBlock:^(id errorCode) {
        weakSelf.currentPage --;
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_footer endRefreshing];
    } WithFailureBlock:^{
        weakSelf.currentPage --;
        [((UITableView *)[weakSelf.tablearray objectAtIndex:0]).mj_footer endRefreshing];
    }];
    
    NSDictionary *dic = @{@"dn":self.user.dn,
                          @"isdoctor":self.user.isdoctor,
                          @"currentpage":[NSString stringWithFormat:@"%d",self.currentPage]};
    
    [self.viewmodel fetchPostWithDic:dic];

}

/**
 点击了某个标题的代理事件
 */
-(void)uisegumentSelectionChange:(NSInteger)selection{
    NSLog(@"%ld",(long)selection);
    //加入动画
    [UIView animateWithDuration:0.2 animations:^{
        [self.mainscroll setContentOffset:CGPointMake(screenWidth*selection, 0)];
    }];
    
    //点击好友标题后加载一遍好友列表
    if (selection == 1) {
        __unsafe_unretained __typeof(self) weakSelf = self;
        [self.viewmodel setBlockWithReturnBlock:^(id returnValue) {
            if((NSDictionary*)returnValue){
                weakSelf.friendarray = [NSMutableArray arrayWithArray:[returnValue objectForKey:@"datalist"]];
            }
            [((UITableView *)[weakSelf.tablearray objectAtIndex:1]) reloadData];
        } WithErrorBlock:^(id errorCode) {
        
        } WithFailureBlock:^{
        
        }];
        
        NSDictionary *dic = @{@"dn":self.user.dn,
                              @"memberid":self.user.memberid,
                              @"isdoctor":self.user.isdoctor
                              };
        
        [self.viewmodel fetchFriendWithDic:dic];
    }
}
/**
 *  滑动代理
 *
 *  @param scrollView 响应滑动者
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == -1) {
        NSInteger count = (int)(scrollView.contentOffset.x/screenWidth);
        [self.segment selectTheSegument:count];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0){
        
        return _postarray.count;
    }
    if (tableView.tag == 1) {
        
        return _friendarray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        YYForumCell *forumcell = [YYForumCell cellWithTableView:tableView];
        _post = [Posting mj_objectWithKeyValues:[_postarray objectAtIndex:indexPath.row]];
        [forumcell initView:forumcell value:_post];
//        forumcell.tag = [_post.forumid intValue];//帖子id
        return forumcell;
    }
    if (tableView.tag == 1) {
        YYFriendCell *friendcell = [YYFriendCell cellWithTableView:tableView];
        _friend = [Friends mj_objectWithKeyValues:[_friendarray objectAtIndex:indexPath.row]];
        [friendcell setValue:_friend];
        //拨打电话
        friendcell.telbtn.tag = indexPath.row;
        [friendcell.telbtn addTarget:self action:@selector(playCall:) forControlEvents:UIControlEventTouchUpInside];
        return friendcell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        YYForumCell *cell = (YYForumCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        if (cell.contentImgHeight.constant == 0) {
            return CGRectGetMaxY(cell.headImg.frame)-82;
        }
        else{
            return 200-(35-cell.contentHeight.constant);
        }
        
    }
    if (tableView.tag == 1) {
        return 60;
    }
    return 0;
}
/**
 *  cell选中事件
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //帖子详情
    if (tableView.tag == 0) {
        _postid = [[_postarray objectAtIndex:indexPath.row] objectForKey:@"forumid"];
        [self performSegueWithIdentifier:@"circletopost" sender:self];
    }
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
/**
 *  拨打电话
 *
 *  @param sender 拨话按钮
 */
- (void)playCall:(UIButton *)sender{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[[_friendarray objectAtIndex:sender.tag] valueForKey:@"dn"]];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"circletopost"]) {
        YYDetailPostViewController *dest = segue.destinationViewController;
        dest.postid = _postid;
    }
   
}
@end
