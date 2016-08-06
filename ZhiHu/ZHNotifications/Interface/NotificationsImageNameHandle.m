//
//  NotificationsImageNameHandle.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "NotificationsImageNameHandle.h"
#import "ZHImageNameHandle.h"

@implementation NotificationsImageNameHandle

+ (NSString *)handleImageName:(NSString *)image{
    return [ZHImageNameHandle handleImageBundle:@"ZHNotifications" Name:image];
}

@end
