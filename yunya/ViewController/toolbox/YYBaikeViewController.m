//
//  YYBaikeViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYBaikeViewController.h"
#import "YYBaikeCollectionViewCell.h"
#import "BaikeSubject.h"
#import "YYBaikeArticleTableViewController.h"

@interface YYBaikeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    BaikeSubject *selectedSubject;
}

@property (nonatomic, strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YYBaikeViewModel *viewModel;

@end

@implementation YYBaikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"孕期百科";
    
    self.array = [[NSArray alloc] init];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.viewModel = [[YYBaikeViewModel alloc] initWithViewController:self];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.collectionView reloadData];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [self.viewModel fetchBaikeSubjectWithDN:self.user.dn withMemberId:self.user.memberid];
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYBaikeCollectionViewCell *cell = [YYBaikeCollectionViewCell cellWithCollectionView:collectionView AtIndexPath:indexPath];
    [cell setValue:self.array[indexPath.row]];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 96);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedSubject = self.array[indexPath.row];
    [self performSegueWithIdentifier:@"toarticlearray" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"toarticlearray"]){
        YYBaikeArticleTableViewController *viewController = segue.destinationViewController;
        viewController.subject = selectedSubject;
    }
}


@end
