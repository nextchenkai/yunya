//
//  YYEmoticonModel.m
//  yunya
//
//  Created by 陈凯 on 16/4/8.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYEmoticonModel.h"
#import "YYEmoticonManegaer.h"

@implementation YYEmoticonModel


- (instancetype)init:(NSString *)folder dic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.folder = folder;
        self.chs = [dic objectForKey:@"chs"];
        self.cht = [dic objectForKey:@"cht"];
        self.png = [dic objectForKey:@"png"];
        self.pngPath = [NSString stringWithFormat:@"%@/%@/%@",[YYEmoticonManegaer getbundlePath],self.folder,self.png];
    }
    return self;
}
@end
