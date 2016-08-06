//
//  DiscoveryImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "DiscoveryImageNameHandle.h"
#import "ZHImageNameHandle.h"

@implementation DiscoveryImageNameHandle

+ (NSString *)handleImageName:(NSString *)image{
    return [ZHImageNameHandle handleImageBundle:@"ZHDiscovery" Name:image];
}

@end
