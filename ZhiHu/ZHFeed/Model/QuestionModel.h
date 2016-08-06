//
//  QuestionModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthorModel;
@interface QuestionModel : NSObject

@property (nonatomic, strong) AuthorModel *autor;
@property (nonatomic, copy) NSString     *url;
@property (nonatomic, copy) NSString     *title;
@property (nonatomic, assign) BOOL       isFollowing;
@property (nonatomic, copy) NSString     *type;
@property (nonatomic, copy) NSString     *idd;

@end
