//
//  AutorModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "AuthorModel.h"

@implementation AuthorModel

// badge(arrayM) name url userType headLine avatarUrl type idd
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.badge = [NSMutableArray array];
        self.name = @"";
        self.url = @"";
        self.userType = @"";
        self.headLine = @"";
        self.avatarUrl = @"";
        self.type = @"";
        self.idd = @"";
    }
    return self;
}

@end
