//
//  YYTabBarController.m
//  yunya
//
//  Created by WongSuechang on 16/3/17.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYTabBarController.h"
#import "YYHomeViewController.h"
#import "YYPregTestViewController.h"
#import "YYCircleViewController.h"
#import "RDVTabBarItem.h"

@interface YYTabBarController ()

@end

@implementation YYTabBarController

- (instancetype) init {
    self = [super init];
    if(self){
//        self.user = [SystemUtils getUser];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewControllers {
    //首页
    UIStoryboard *homeStory = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    YYHomeViewController *home = [homeStory instantiateViewControllerWithIdentifier:@"home"];
    home.title = @"首页";
    YYNavigationController *homeNavi = [[YYNavigationController alloc] initWithRootViewController:home];
    
    //孕检
    UIStoryboard *testStory = [UIStoryboard storyboardWithName:@"PregTest" bundle:nil];
    YYPregTestViewController *test = [testStory instantiateViewControllerWithIdentifier:@"test"];
    test.title = @"孕检";
    YYNavigationController *testNavi = [[YYNavigationController alloc] initWithRootViewController:test];
    
    //孕芽圈
    UIStoryboard *circleStory = [UIStoryboard storyboardWithName:@"Circle" bundle:nil];
    YYCircleViewController *circle = [circleStory instantiateViewControllerWithIdentifier:@"circle"];
    circle.title = @"孕芽圈";
    YYNavigationController *circleNavi = [[YYNavigationController alloc] initWithRootViewController:circle];
    
    //工具箱
    UIStoryboard *kitsStory = [UIStoryboard storyboardWithName:@"Kits" bundle:nil];
    YYPregTestViewController *kits = [kitsStory instantiateViewControllerWithIdentifier:@"kits"];
    kits.title = @"工具箱";
    YYNavigationController *kitsNavi = [[YYNavigationController alloc] initWithRootViewController:kits];
    
    //我的
    UIStoryboard *mineStory = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    YYPregTestViewController *mine = [mineStory instantiateViewControllerWithIdentifier:@"mine"];
    mine.title = @"我的";
    YYNavigationController *mineNavi = [[YYNavigationController alloc] initWithRootViewController:mine];
    
    self.viewControllers = @[homeNavi,testNavi,circleNavi,kitsNavi,mineNavi];
    
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"home", @"test", @"circle",@"kits",@"mine"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            item.selectedTitleAttributes = @{
                                             NSFontAttributeName: [UIFont systemFontOfSize:12],
                                             NSForegroundColorAttributeName: [UIColor colorWithHexString:@"FB9BA9"],
                                             };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            item.selectedTitleAttributes = @{
                                             UITextAttributeFont: [UIFont systemFontOfSize:12],
                                             UITextAttributeTextColor: [UIColor colorWithHexString:@"FB9BA9"],
                                             };
#endif
        }
        
        index++;
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
