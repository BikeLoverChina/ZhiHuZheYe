//
//  ColumnModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/30.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ColumnModel.h"
#import "AuthorModel.h"

@implementation ColumnModel
//updated author url commentPermission title imageUrl type idd
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.updated = @"";
        self.author = [[AuthorModel alloc] init];
        self.commentPermission = @"";
        self.title = @"";
        self.imageUrl = @"";
        self.type = @"";
        self.idd = @"";
    }
    return self;
}
@end
