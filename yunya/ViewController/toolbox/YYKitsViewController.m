//
//  YYKitsViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYKitsViewController.h"
#import "YYKitCollectionViewCell.h"
#import "YYDailyViewController.h"
#import "YYScheduleViewController.h"
#import "YYReportsViewController.h"

@interface YYKitsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation YYKitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.array = @[@"每日记录",@"产检报告",@"产检时间表",@"胎教音乐",@"待产包",@"孕期百科"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    YYKitCollectionViewCell *cell = [YYKitCollectionViewCell cellWithCollectionView:collectionView AtIndexPath:indexPath];
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
    NSLog(@"%ld",(long)indexPath.row);
    NSInteger index = indexPath.row;
    switch (index) {
            //每日记录
        case 0:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            YYDailyViewController *viewController = [story instantiateViewControllerWithIdentifier:@"dailys"];
            [self.navigationController pushViewController:viewController animated:YES];
            }
            break;
            //产检报告
        case 1:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            YYReportsViewController *viewController = [story instantiateViewControllerWithIdentifier:@"reports"];
            [self.navigationController pushViewController:viewController animated:YES];
            }
            break;
            //产检时间表
        case 2:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            YYScheduleViewController *viewController = [story instantiateViewControllerWithIdentifier:@"schedule"];
            [self.navigationController pushViewController:viewController animated:YES];
            }
            break;
            //胎教音乐
        case 3:
            [self performSegueWithIdentifier:@"tomusic" sender:nil];
            break;
            //待产包
        case 4:
            [self performSegueWithIdentifier:@"topackage" sender:nil];
            break;
            //孕期百科
        case 5:
            [self performSegueWithIdentifier:@"tobaike" sender:nil];
            break;
            
        default:
            break;
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

@end
