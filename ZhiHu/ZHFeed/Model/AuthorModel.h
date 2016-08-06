//
//  AutorModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

@property (nonatomic, assign) BOOL              isFollowed;
@property (nonatomic, strong) NSMutableArray    *badge;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *url;
@property (nonatomic, assign) NSInteger         gender;
@property (nonatomic, copy) NSString            *userType;
@property (nonatomic, copy) NSString            *headLine;
@property (nonatomic, copy) NSString            *avatarUrl;
@property (nonatomic, assign) BOOL              isFollowing;
@property (nonatomic, copy) NSString            *type;
@property (nonatomic, copy) NSString            *idd;

@end
