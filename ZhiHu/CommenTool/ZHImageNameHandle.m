//
//  ZHImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHImageNameHandle.h"

@implementation ZHImageNameHandle

+ (NSString *)handleImageBundle:(NSString *)bundle Name:(NSString *)image{
    if (image) {
        return [NSString stringWithFormat:@"%@%@%@",bundle,SEPARATESYMBOL,image];
    }
    return nil;
}

@end
