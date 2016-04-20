//
//  YYPickerView.m
//  yunya
//
//  Created by 陈凯 on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYPickerView.h"

//私有方法
@interface YYPickerView (Private)

//创建yypickerview
- (void)createYYPickerview;
//创建tableview
- (void)setTableview:(NSUInteger)witchcolumn;
//选中背景图片
- (void)setSelectionimg;
@end

@implementation YYPickerView
@synthesize datasource,delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _rowsInColumn = [[NSMutableArray alloc] init];
        _tables = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)setDelegate:(id<YYPickerViewDelegate>)_delegate{
    delegate = _delegate;
    
}
//要在设置和数据源之后再创建视图
- (void)setDatasource:(id<YYPickerViewDataSource>)_datasource{
    datasource = _datasource;
    [self createYYPickerview];
}

- (void)createYYPickerview{
    //列数
    _column = [datasource numberOfColumnsInYYPickerView:self];
    //行高
    _cellheight = [datasource heightForCellInRow:self];
    //可视行数
    _visiblerow = [datasource numberOfVisibleCell:self];
    //创建tableview
    [self setTableview:-1];

}

- (void)setTableview:(NSUInteger)witchcolumn{
    //循环创建column个tableview
    
    // 如果witchcolumn＝＝－1，说明为第一次加载，其余为刷新
    if (witchcolumn == -1) {
        //x坐标
        CGFloat x = 0.0;
        
        for (NSInteger i=0; i<_column; i++) {
            //列宽
            _cellwidth = [datasource widthForCellInColumn:i];
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0+x+2, 5, _cellwidth, _cellheight*_visiblerow)];
            table.tag = i;//标记table
            //动态改变x坐标
            x = x + _cellwidth;
            
            //行数数组
            //返回行数加2，确保最后一行和第一行可选到
            
            [_rowsInColumn addObject:[NSString stringWithFormat:@"%d",[datasource yypickerview:self numberOfRowsInColumn:table.tag]+2]];
            
            table.dataSource = self;
            table.delegate = self;
            table.scrollEnabled = YES;//允许滚动
            table.backgroundColor=[UIColor clearColor];
            table.separatorStyle=UITableViewCellSeparatorStyleNone;
            table.showsVerticalScrollIndicator=NO;
            table.bounces=NO;
            table.decelerationRate=0;
            [self addSubview:table];
            //把table加入它的载体中去
            
            
            [_tables addObject:table];
            
        }

    }else{
        //利用循环计算tableview的x坐标
        //x坐标
        CGFloat x = 0.0;
        for (NSInteger i=0; i<witchcolumn; i++ ) {
            //列宽
           x  = x+[datasource widthForCellInColumn:i];
            
        }
        _cellwidth = [datasource widthForCellInColumn:witchcolumn];
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0+x+2, 5, _cellwidth, _cellheight*_visiblerow)];
        table.tag = witchcolumn;//标记table
        
        //行数数组
        //返回行数加2，确保最后一行和第一行可选到
        
        //替换原来的值
        [_rowsInColumn replaceObjectAtIndex:witchcolumn withObject:[NSString stringWithFormat:@"%d",[datasource yypickerview:self numberOfRowsInColumn:table.tag]+2]];
        
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = YES;//允许滚动
        table.backgroundColor=[UIColor clearColor];
        table.separatorStyle=UITableViewCellSeparatorStyleNone;
        table.showsVerticalScrollIndicator=NO;
        table.bounces=NO;
        table.decelerationRate=0;
        [self addSubview:table];
        //把table加入它的载体中去
        
        
        [_tables replaceObjectAtIndex:witchcolumn withObject:table];

    }
    
    //选中背景图片
    if (_bgimageview!=nil) {
        [_bgimageview removeFromSuperview];
    }
    [self setSelectionimg];
}

//选中背景图片
- (void)setSelectionimg{
    _bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(2, _cellheight, self.frame.size.width-32, _cellheight)];
    //平铺
    _bgimageview.image = [[UIImage imageNamed:@"selectionbg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _bgimageview.alpha = 0.5;
    
    [self addSubview:_bgimageview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [[_rowsInColumn objectAtIndex:tableView.tag] intValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (indexPath.row>=1&&indexPath.row<=[[_rowsInColumn objectAtIndex:tableView.tag] intValue]-2) {
        cell = [datasource tableview:tableView cellForColumn:tableView.tag atRow:indexPath.row-1];
    }
    //第一个和最后一个cell
    else{
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"";
    }
    return  cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellheight;
}

//处理滚动列表停止滚动的事件-普通滚动
- (void)stopScrollNoLoop:(UIScrollView *)sc{
    CGFloat rowHeight = _cellheight;
    //滚动列表，使距离中间的选择区域最近的Cell始终保持在选择区域，因为用户的滚动很可能让滚轮处于当不当正不正的位置，这里使用round()的四舍五入函数，实际就是哪个Cell在中间的区域占据的高度超过自身的高度的一半，谁就滚动到中间选中的区域
    [sc setContentOffset:CGPointMake(sc.contentOffset.x, round(sc.contentOffset.y/rowHeight)*rowHeight) animated:YES];
    NSInteger cellCountsOffset=round(sc.contentOffset.y/rowHeight);
    //选中代理
    [delegate yypickerview:self didselectColumn:sc.tag atRow:cellCountsOffset];

    
}

//处理滚动列表停止滚动的事件-普通滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)sc willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self stopScrollNoLoop:sc];
    }
}

//处理滚动列表停止滚动的事件-普通滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sc{
    [self stopScrollNoLoop:sc];
}

//选中到某一行
- (void)selectData:(NSUInteger)column row:(NSInteger)row{
    if (column == -1) {
        for (int i = 0; i<_tables.count; i++) {
            UIScrollView *sc = [_tables objectAtIndex:i];
            //滚动到指定视图
            [sc setContentOffset:CGPointMake(sc.contentOffset.x, _cellheight*row) animated:YES];
            //选中代理
            //[delegate yypickerview:self didselectColumn:sc.tag atRow:row];

        }
    }
    else{
        UIScrollView *sc = [_tables objectAtIndex:column];
        //滚动到指定视图
        [sc setContentOffset:CGPointMake(sc.contentOffset.x, _cellheight*row) animated:YES];
        //选中代理
        //[delegate yypickerview:self didselectColumn:sc.tag atRow:row];
    }
    
}
//重新加载
- (void)reloadData:(NSUInteger)column{
        UIScrollView *scroll = [_tables objectAtIndex:column];
        //移除视图
        [scroll removeFromSuperview];
    
        [self setTableview:column];
}
@end
