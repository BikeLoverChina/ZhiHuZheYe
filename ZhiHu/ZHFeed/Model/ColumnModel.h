//
//  ColumnModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/30.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthorModel;
@interface ColumnModel : NSObject

@property (nonatomic, copy) NSString        *updated;
@property (nonatomic, strong) AuthorModel   *author;
@property (nonatomic, copy) NSString        *url;
@property (nonatomic, copy) NSString        *commentPermission;
@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *imageUrl;
@property (nonatomic, copy) NSString        *type;
@property (nonatomic, copy) NSString        *idd;

@end
