//
//  YYHomeViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/18.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "CircleMenu.h"
#import "HomeInfo.h"

@interface YYHomeViewModel : SCViewModel

/**
 *  根据用户手机号码dn和类型type,获取首页内容
 *
 *  @param dn   用户手机号码
 *  @param type 用户类型,-1还未选择用户类型 0普通家属 1备孕中 2怀孕呢 3生完宝宝
 */
- (void)fetchHomeInfoWithUserPhone:(NSString *)dn withType:(NSString *)type;

/**
 *  新建首页转盘按钮
 *
 *  @param braceletArray 检查项目array
 *
 *  @return 转盘
 */
- (CircleMenu *)newCircleMenuWithArray:(NSArray *)braceletArray;

/**
 *  把homeinfo的属性转为数组在tableview里展示
 *
 *  @param info 首页数据
 *
 *  @return array
 */
- (NSMutableArray *)translateToArrayWithHomeInfo:(HomeInfo *)info;

/**
 *  完成任务
 *
 *  @param task
 */
- (void)finishTask:(Task *)task WithDN:(NSString *)dn withMemberId:(NSString *)memberid;

@end
