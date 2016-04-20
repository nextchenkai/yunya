//
//  YYBaikeArticlesViewModel.h
//  yunya
//
//  Created by WongSuechang on 16/3/31.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "SCViewModel.h"

@interface YYBaikeArticlesViewModel : SCViewModel

- (void)fetchArticleArrayWithTopicId:(NSString *)topicId;

@end
