//
//  Actormodel.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ActorModel.h"

@implementation ActorModel

// name url excerpt introduction avatarUrl type idd
- (instancetype)init
{
    self = [super init];
    if (self) {
       self.name = @"";
        self.url = @"";
        self.excerpt = @"";
        self.introduction = @"";
        self.avatarUrl = @"";
        self.type = @"";
        self.idd = @"";
    }
    return self;
}

@end
