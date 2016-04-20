//
//  YYArticleDetailViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/4/1.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"
#import "Article.h"

@interface YYArticleDetailViewModel : SCViewModel

- (void)initViewsWithArticle:(Article *)article onScrollView:(UIScrollView *)scrollView;

- (void)fetchArticleDetailWithArticleId:(NSString *)articleId;

@end
