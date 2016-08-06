//
//  DataModel.h
//  ZhiHu
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TargetModel;
@class ActorModel;
@interface DataModel : NSObject

@property (nonatomic, strong) TargetModel    *targetModel;
@property (nonatomic, copy) NSString         *actionText;
@property (nonatomic, copy) NSString         *updatedTime;
@property (nonatomic, copy) NSString         *verb;
@property (nonatomic, strong) NSMutableArray <ActorModel *> *actors;
@property (nonatomic, copy) NSString         *type;
@property (nonatomic, copy) NSString         *idd;
@end
