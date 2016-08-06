//
//  PagIngModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/30.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "PagIngModel.h"

@implementation PagIngModel
// next previous
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.next = @"";
        self.previous = @"";
    }
    return self;
}
@end
