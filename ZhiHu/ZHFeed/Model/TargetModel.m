//
//  TargetModel.m
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "TargetModel.h"
#import "QuestionModel.h"
#import "CanCommentModel.h"
#import "AuthorModel.h"
#import "ColumnModel.h"

@implementation TargetModel
//question canComment autor commentPerssion excerpt updatedTime thumbnail createdTime type idd updated title
//imageWidth created column imageHeight imageUrl voting tipjarorsCount
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.question = [[QuestionModel alloc] init];
        self.canComment = [[CanCommentModel alloc] init];
        self.autor = [[AuthorModel alloc] init];
        self.commentPerssion = @"";
        self.excerpt = @"";
        self.updatedTime = @"";
        self.thumbnail = @"";
        self.createdTime = @"";
        self.type = @"";
        self.idd = @"";
        self.updated = @"";
        self.title = @"";
        self.created = @"";
        self.column = [[ColumnModel alloc] init];
        self.imageUrl = @"";
        self.voting = @"";
    }
    return self;
}
@end
