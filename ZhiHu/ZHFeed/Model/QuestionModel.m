//
//  QuestionModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "QuestionModel.h"
#import "AuthorModel.h"

@implementation QuestionModel
// autor url title type idd
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autor = [[AuthorModel alloc] init];
        self.url = @"";
        self.title = @"";
        self.type = @"";
        self.idd = @"";
    }
    return self;
}
@end
