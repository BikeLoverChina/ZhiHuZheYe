//
//  UIImageView+ZHSkin.m
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "UIImageView+ZHSkin.h"
#import <objc/runtime.h>
#import "ZHSkinManager.h"

@implementation UIImageView (ZHSkin)

#pragma mark - imageKey

@dynamic imageKey;
static char kPropertyImageKey;

- (void)setImageKey:(NSString *)imageKey
{
    objc_setAssociatedObject(self, &kPropertyImageKey, imageKey, OBJC_ASSOCIATION_COPY);
    [self changedImage];
}

- (NSString *)imageKey
{
    return objc_getAssociatedObject(self, &kPropertyImageKey);
}

- (void)changedImage
{
    if (self.imageKey) {
        self.image = [[ZHSkinManager sharedManager] imageWithImageKey:self.imageKey];
    }
}

@end
