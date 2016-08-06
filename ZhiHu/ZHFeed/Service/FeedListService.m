//
//  FeedListService.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "FeedListService.h"
#import "DataModel.h"
#import "TargetModel.h"
#import "ActorModel.h"
#import "QuestionModel.h"
#import "CanCommentModel.h"
#import "AuthorModel.h"
#import "PagIngModel.h"

@implementation FeedListService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.feedListData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)parseJsonDict:(NSDictionary *)strJsonDict {
    
    @try
    {
        if (strJsonDict && [strJsonDict isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *pagingDict = [strJsonDict valueForKey:@"paging"];
            
            self.pagingModel = [[PagIngModel alloc] init];
            self.pagingModel.isEnd = [[pagingDict valueForKey:@"is_end"] boolValue];
            self.pagingModel.next = [pagingDict valueForKey:@"next"];
            self.pagingModel.previous = [pagingDict valueForKey:@"previous"];
            
            NSArray *dataList = [strJsonDict valueForKey:@"data"];
            for (NSDictionary *subDict in dataList) {
                
                DataModel *dataModel = [[DataModel alloc] init];

                // Target
                {
                    NSDictionary  *targetDict = [subDict valueForKey:@"target"];
                    TargetModel *targetModel = [[TargetModel alloc] init];
                    dataModel.targetModel = targetModel;
                    
                    // question
                    {
                        NSDictionary *questionDict = [targetDict objectForKey:@"question"];
                        QuestionModel *questionModel = [[QuestionModel alloc] init];
                        targetModel.question = questionModel;
                        
                        // -> author
                        {
                           NSDictionary *authorDict = [questionDict valueForKey:@"author"];
                            AuthorModel *authorModel = [[AuthorModel alloc] init];
                            questionModel.autor = authorModel;
                            // 用的时候在打开
                            //authorModel.badge = [authorDict valueForKey:@"badge"];
                            authorModel.name = [authorDict valueForKey:@"name"];
                            authorModel.url = [authorDict valueForKey:@"url"];
                            authorModel.gender = [[authorDict valueForKey:@"gender"] integerValue];
                            authorModel.userType = [authorDict valueForKey:@"user_type"];
                            authorModel.headLine = [authorDict valueForKey:@"autorModel"];
                            authorModel.avatarUrl = [authorDict valueForKey:@"avatar_url"];
                            authorModel.type = [authorDict valueForKey:@"authorModel"];
                            authorModel.idd = [authorDict valueForKey:@"id"];
                        }
                        questionModel.url = [questionDict valueForKey:@"url"];
                        questionModel.title = [questionDict valueForKey:@"title"];
                        questionModel.isFollowing = [[questionDict valueForKey:@"is_following"] boolValue];
                        questionModel.type = [questionDict valueForKey:@"type"];
                        questionModel.idd = [questionDict valueForKey:@"id"];
                    }
                    ////question
                    
                    // other
                    targetModel.isCopyAble = [[targetDict valueForKey:@"targetDict"] boolValue];
                    
                    // cancomment
                    {
                        NSDictionary *canCommentDict = [targetDict valueForKey:@"can_comment"];
                        CanCommentModel *canCommentModel = [[CanCommentModel alloc] init];
                        targetModel.canComment = canCommentModel;
                        canCommentModel.status = [[canCommentDict valueForKey:@"status"] boolValue];
                        canCommentModel.reason = [canCommentDict valueForKey:@"reason"];
                    }
                    ////cancomment
                    
                    // author
                    {
                        NSDictionary *authorDict = [targetDict valueForKey:@"author"];
                        AuthorModel *authorModel = [[AuthorModel alloc] init];
                        targetModel.autor = authorModel;
                        authorModel.isFollowed = [[authorDict valueForKey:@"is_following"] boolValue];
                        //有数据再解析
                        //authorModel.badge = [authorDict valueForKey:@"badge"];
                        authorModel.name = [authorDict valueForKey:@"name"];
                        authorModel.url = [authorDict valueForKey:@"url"];
                        authorModel.gender = [[authorDict valueForKey:@"gender"] integerValue];
                        authorModel.userType = [authorDict valueForKey:@"user_type"];
                        authorModel.headLine = [authorDict valueForKey:@"headline"];
                        authorModel.avatarUrl = [authorDict valueForKey:@"avatar_url"];
                        authorModel.isFollowing = [[authorDict valueForKey:@"is_following"] boolValue];
                        authorModel.type = [authorDict valueForKey:@"type"];
                        authorModel.idd = [authorDict valueForKey:@"id"];
                    }
                    ////author
                    
                    // url
                    targetModel.url = [targetDict valueForKey:@"url"];
                    targetModel.commentPerssion = [targetDict valueForKey:@"comment_permission"];
                    targetModel.excerpt = [targetDict valueForKey:@"excerpt"];
                    targetModel.thumbnail = [targetDict valueForKey:@"thumbnail"];
                    targetModel.updatedTime = [targetDict valueForKey:@"updated_time"];
                    targetModel.commentCount = [[targetDict valueForKey:@"comment_count"] integerValue];
                    targetModel.createdTime = [targetDict valueForKey:@"created_time"];
                    targetModel.voteUpCount = [[targetDict valueForKey:@"voteup_count"] integerValue];
                    targetModel.type = [targetDict valueForKey:@"voteup_count"];
                    targetModel.idd = [targetDict valueForKey:@"id"];
                    targetModel.thanksCount = [[targetDict valueForKey:@"thanks_count"] integerValue];
                    
                    // 上图中文下文特有字段
                    targetModel.updated = [targetDict valueForKey:@"thumbnail"];
                    targetModel.canTip = [[targetDict valueForKey:@"can_tip"] boolValue];
                    targetModel.title = [targetDict valueForKey:@"title"];
                    targetModel.imageWidth = [[targetDict valueForKey:@"image_height"] integerValue];
                    targetModel.imageUrl = [targetDict valueForKey:@"image_url"];
                    targetModel.voting = [targetDict valueForKey:@"voting"];
                    targetModel.tipjarorsCount = [[targetDict valueForKey:@"tipjarors_count"] integerValue];
                }
                
                // other
                dataModel.actionText = [subDict valueForKey:@"action_text"];
                dataModel.updatedTime = [subDict valueForKey:@"updated_time"];
                dataModel.verb = [subDict valueForKey:@"verb"];

                // actor
                {
                    NSMutableArray *actorsArrayM = [[NSMutableArray alloc] init];
                    NSDictionary *actorsDict = [subDict valueForKey:@"actors"];
                    for (NSDictionary *subModelDict in actorsDict) {
                        ActorModel *actor = [[ActorModel alloc] init];
                        actor.name = [subModelDict valueForKey:@"name"];
                        actor.url = [subModelDict valueForKey:@"url"];
                        actor.excerpt = [subModelDict valueForKey:@"excerpt"];
                        actor.introduction = [subModelDict valueForKey:@"introduction"];
                        actor.avatarUrl = [subModelDict valueForKey:@"avatar_url"];
                        [actorsArrayM addObject:actor];
                    }
                    
                    ////////////////////////////////////
                    dataModel.actors = actorsArrayM;
                }
                
                // other
                dataModel.type = [subDict valueForKey:@"type"];
                dataModel.idd = [subDict valueForKey:@"id"];
                
                [self.feedListData addObject:dataModel];
            }
            
        }
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }
    
    return YES;
}

- (void)getFeedListData:(NSString *)url {
    //@"https://api.zhihu.com/topstory?action_feed=true&limit=10&reverse_order=0";
    [self getData:url];
}

@end
