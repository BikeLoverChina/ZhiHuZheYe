//
//  TargetModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionModel;
@class CanCommentModel;
@class AuthorModel;
@class ColumnModel;
@interface TargetModel : NSObject

/////////////// 上文中图下文 || 纯文字 /////////////////////
@property (nonatomic, strong) QuestionModel   *question;
@property (nonatomic, assign) BOOL            isCopyAble;
@property (nonatomic, strong) CanCommentModel *canComment;
@property (nonatomic, strong) AuthorModel      *autor;
@property (nonatomic, copy) NSString          *url;
@property (nonatomic, copy) NSString          *commentPerssion;
@property (nonatomic, copy) NSString          *excerpt;
@property (nonatomic, copy) NSString          *updatedTime;
/*!
 @property
 @abstract 代表图(没有的显示纯文字)
 */
@property (nonatomic, copy) NSString          *thumbnail;
@property (nonatomic, assign) NSInteger       commentCount;
@property (nonatomic, copy) NSString          *createdTime;
@property (nonatomic, assign) NSInteger       voteUpCount;
@property (nonatomic, copy) NSString          *type;
@property (nonatomic, copy) NSString          *idd;
@property (nonatomic, assign) NSInteger       thanksCount;
////////////////////////////////////

/////////////// 上图中文下文 /////////////////////
@property (nonatomic, copy) NSString           *updated;
//excerpt
@property (nonatomic, assign) BOOL             canTip;
//idd
//voteUpCount
@property (nonatomic, copy) NSString           *title;
//url
//commentPerssion
//autor
@property (nonatomic, assign) NSInteger        imageWidth;
@property (nonatomic, copy) NSString           *created;
@property (nonatomic, strong) ColumnModel      *column;
//commentCount
@property (nonatomic, assign) NSInteger           *imageHeight;
@property (nonatomic, copy) NSString           *imageUrl;
@property (nonatomic, copy) NSString           *voting;
//type
@property (nonatomic, assign) NSInteger        tipjarorsCount;
////////////////////////////////////
@end
