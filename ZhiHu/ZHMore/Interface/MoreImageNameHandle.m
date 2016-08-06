//
//  MoreImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "MoreImageNameHandle.h"
#import "ZHImageNameHandle.h"

@implementation MoreImageNameHandle

+ (NSString *)handleImageName:(NSString *)image{
    return [ZHImageNameHandle handleImageBundle:@"ZHMore" Name:image];
}

@end
