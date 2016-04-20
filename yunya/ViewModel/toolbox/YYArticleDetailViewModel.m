//
//  YYArticleDetailViewModel.m
//  yunya
//
//  Created by WongSuechang on 16/4/1.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYArticleDetailViewModel.h"
#import "YYDailyImgContainerView.h"

@implementation YYArticleDetailViewModel
- (void)initViewsWithArticle:(Article *)article onScrollView:(UIScrollView *)scrollView {
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    titleLabel.text = article.title;
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];
    contentLabel.font = [UIFont boldSystemFontOfSize:13.f];
    contentLabel.text = article.content;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    YYDailyImgContainerView *imageViews = [YYDailyImgContainerView new];
    NSArray *imageArray = [article.img componentsSeparatedByString:@","];
    imageViews.picPathStringsArray = imageArray;
    
    [scrollView sc_addSubViews:@[titleLabel,contentLabel,imageViews]];
    
    titleLabel.sd_layout
    .topSpaceToView(scrollView,10)
    .leftSpaceToView(scrollView,20)
    .rightSpaceToView(scrollView,20);
    
    contentLabel.sd_layout
    .topSpaceToView(titleLabel,10)
    .leftSpaceToView(scrollView,20)
    .rightSpaceToView(scrollView,20);
    
    imageViews.sd_layout
    .topSpaceToView(contentLabel,10)
    .leftSpaceToView(scrollView,20)
    .rightSpaceToView(scrollView,20)
    .bottomSpaceToView(scrollView,10)
    .heightIs(250);
    
    NSLog(@"scrollView.y:%f\ntitlelabel.y:%ftitlelabel.height:%f",scrollView.frame.origin.y,titleLabel.frame.origin.y,titleLabel.frame.size.height);
    NSLog(@"%f",imageViews.frame.origin.y);
    scrollView.contentSize = CGSizeMake(0, imageViews.frame.origin.y + 260);
}

- (void)fetchArticleDetailWithArticleId:(NSString *)articleId {
    NSDictionary *params = @{@"id":articleId};
    [SCHttpOperation requestWithMethod:RequestMethodTypePost withURL:[NSString stringWithFormat:@"%@%@",serverIP,@"/toolknowpregnancycontent.do"] withparameter:params WithReturnValeuBlock:^(id returnValue) {
        [self fetchArticleSuccessWithDic:returnValue];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } WithFailureBlock:^{
        [self netFailure];
    }];
}

- (void)fetchArticleSuccessWithDic:(NSDictionary *)returnValue {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:returnValue];
    long success = [(NSNumber *)[dict objectForKey:@"success"] longValue];
    if(success==1){
        NSDictionary *mydic = [dict objectForKey:@"data"];
        Article *result = [Article mj_objectWithKeyValues:mydic];
        self.returnBlock(result);
    }else{
        self.returnBlock(nil);
    }
}

@end
