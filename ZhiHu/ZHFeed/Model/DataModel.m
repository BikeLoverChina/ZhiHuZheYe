//
//  DataModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "DataModel.h"
#import "TargetModel.h"

@implementation DataModel

// targetModel actionText updatedTime verb actors(arayM) type idd
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.targetModel = [[TargetModel alloc] init];
        self.actionText = @"";
        self.updatedTime = @"";
        self.verb = @"";
        self.actors = [NSMutableArray array];
        self.type = @"";
        self.idd = @"";
    }
    return self;
}

@end
