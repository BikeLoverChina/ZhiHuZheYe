//
//  FeedImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "FeedImageNameHandle.h"
#import "ZHImageNameHandle.h"

@implementation FeedImageNameHandle

+ (NSString *)handleImageName:(NSString *)image{
    return [ZHImageNameHandle handleImageBundle:@"ZHFeed" Name:image];
}

@end
