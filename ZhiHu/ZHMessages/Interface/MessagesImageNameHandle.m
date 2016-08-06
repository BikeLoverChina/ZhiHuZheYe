//
//  MessagesImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "MessagesImageNameHandle.h"
#import "ZHImageNameHandle.h"

@implementation MessagesImageNameHandle

+ (NSString *)handleImageName:(NSString *)image{
    return [ZHImageNameHandle handleImageBundle:@"ZHMessages" Name:image];
}

@end
