//
//  FeedListService.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHBaseService.h"

@class PagIngModel;
@interface FeedListService : ZHBaseService

@property (nonatomic, strong) PagIngModel *pagingModel;
@property (nonatomic, assign) BOOL        refresh;
@property (nonatomic, strong) NSMutableArray *feedListData;

- (void)getFeedListData:(NSString *)url;

@end
