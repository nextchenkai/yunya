//
//  YYPickerView.h
//  yunya
//
//  Created by 陈凯 on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

/**
 *  全局思维，每一列是一个tableview，因此都是选择了某一列的某一行
 */

#import <UIKit/UIKit.h>
/**
 *  协议 YYPickerViewDataSource
    ｛
        1.列数 column
        2.行数 row
        3.某列cell的类型（可自定义的cell） 及内容
        4.某列cell宽度
        5.某行cell高度
        6.可视区域的cell个数
        ｝
    协议 YYPickerViewDelegate
        ｛
           1。选中某一行，返回该行的值
        ｝
    类   YYPickerView
        属性｛
            1.datasource，数据代理
            2.delegate：方法代理
        ｝
        方法｛
            1.按窗口位置初始化自己
            2.重新加载滚轮数据
            3.使某一行被选中
        ｝
 
 */

/**
 *  YYPickerViewDataSource,YYPickerViewDataSource的声明
 */
@protocol YYPickerViewDataSource,YYPickerViewDelegate;





@interface YYPickerView : UIView<UITableViewDelegate,UITableViewDataSource>

//数据代理
@property(nonatomic,assign)id<YYPickerViewDataSource> datasource;
//方法代理
@property(nonatomic,assign)id<YYPickerViewDelegate> delegate;
//列数
@property(nonatomic,assign)NSInteger column;
//每列中的行数
@property(nonatomic,strong)NSMutableArray *rowsInColumn;
//列宽
@property(nonatomic,assign)CGFloat cellwidth;
//行高
@property(nonatomic,assign)CGFloat cellheight;
//可见行数
@property(nonatomic,assign)NSInteger visiblerow;
//tableview的载体
@property(nonatomic,strong)NSMutableArray *tables;
//选中的背景视图
@property(nonatomic,strong)UIImageView *bgimageview;
//初始化
- (id)initWithFrame:(CGRect)frame;
//重新加载某一列
- (void)reloadData:(NSUInteger)column;

/**
 *  选中到某一行
 *
 *  @param column column == -1,所有列滚动，其他值则为指定列滚动
 *  @param row    行
 */
- (void)selectData:(NSUInteger)column row:(NSInteger)row;
@end


/**
 *  协议 YYPickerViewDataSource
 ｛
 1.列数 column
 2.行数 row
 3.某列cell的类型（可自定义的cell） 及内容
 4.某列cell宽度
 5.某行cell高度
 6.可视区域的cell个数
 ｝
 
 */
@protocol YYPickerViewDataSource <NSObject>

@required

- (NSInteger)numberOfColumnsInYYPickerView:(YYPickerView *)yypickerview;

- (NSInteger)yypickerview:(YYPickerView *)yypickerview numberOfRowsInColumn:(NSInteger)column;

- (UITableViewCell *)tableview:(UITableView *)tableview cellForColumn:(NSInteger)column atRow:(NSInteger)row;

- (CGFloat)widthForCellInColumn:(NSInteger)column;

- (CGFloat)heightForCellInRow:(YYPickerView *)yypickerview;

- (NSInteger)numberOfVisibleCell:(YYPickerView *)yypickerview;
@end

/**
 *  协议 YYPickerViewDelegate
 ｛
 1。选中某一行，返回该行的值
 ｝
 */
@protocol YYPickerViewDelegate <NSObject>

@required
//选择了某一行的某一列触发
- (void)yypickerview:(YYPickerView *)yypickerview didselectColumn:(NSInteger)column atRow:(NSInteger)row;

@end

