//
//  PagIngModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/30.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagIngModel : NSObject

@property (nonatomic, assign) BOOL     isEnd;
@property (nonatomic, copy) NSString   *next;
@property (nonatomic, copy) NSString   *previous;

@end
