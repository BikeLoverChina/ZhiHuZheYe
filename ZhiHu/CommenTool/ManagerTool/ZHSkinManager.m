//
//  ZHSkinManager.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHSkinManager.h"
#import "UIColor+ZHSkin.h"

#define COMMON_BUNDLE_NAME @"common"

@interface ZHSkinManager ()

/*!
 @property
 @abstract 字体和颜色的字典
 */
@property (nonatomic,strong) NSMutableDictionary *attributesDic;

@end

@implementation ZHSkinManager

+ (instancetype)sharedManager{
    static ZHSkinManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZHSkinManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _skinName = @"AHDefaultSkin";
        //更新字体和文字颜色的配置字典
        [self updateFontAndTextColorDictionary];
        
    }
    return self;
}

- (UIImage *)imageWithImageKey:(NSString *)key {
    
    NSArray *keyComponets = [key componentsSeparatedByString:@":"];
    NSString *bundleName = COMMON_BUNDLE_NAME;
    if ([keyComponets count] > 1) {
        bundleName = keyComponets[0];
        key = keyComponets[1];
    }
    
    UIImage *image = nil;
    //从main bundle读取资源
    NSString *mainBundlePath = [[NSBundle mainBundle]bundlePath];
    //指定的bundle是否在main bundle中
    NSString *bundlePath = [[mainBundlePath stringByAppendingPathComponent:bundleName] stringByAppendingPathExtension:@"bundle"];
    
    image = [self imageWithImageKey:key inBundlePath:bundlePath];
    return image;
}

//从bundle路径中加载图片资源
- (UIImage *)imageWithImageKey:(NSString *)key inBundlePath:(NSString *)bundlePath
{
    NSBundle *skinBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [skinBundle.resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Images/%@.png", key]];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (UIColor *)colorWithColorKey:(NSString *)key
{
    NSString *hexString = self.attributesDic[key];
    if (hexString) {
        return [UIColor colorWithHexString:hexString];
    }
    return [UIColor blackColor];
    
}

- (void)updateFontAndTextColorDictionary;
{
    //先移除原有的配置字典
    [self.attributesDic removeAllObjects];

    //从main bundle读取资源
    NSString *mainBundlePath = [[NSBundle mainBundle]bundlePath];
    //指定的bundle是否在main bundle中
    NSString *bundlePath = [[mainBundlePath stringByAppendingPathComponent:COMMON_BUNDLE_NAME] stringByAppendingPathExtension:@"bundle"];
    
    //换肤逻辑这里处理
    
    //添加当前主题的路径
    NSString *bundlePathWithSkin = [[bundlePath stringByAppendingPathComponent:_skinName]stringByAppendingPathExtension:@"bundle"];
    
    NSBundle *sourceBundle = [NSBundle bundleWithPath:bundlePathWithSkin];
    if (sourceBundle) {
        
        NSString *tempStr = [NSString stringWithFormat:@"%@.plist", self.skinName];
        NSString *plistPath = [sourceBundle.resourcePath stringByAppendingPathComponent:tempStr];
        
        NSMutableDictionary *tempAttDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        [tempAttDic enumerateKeysAndObjectsUsingBlock:^(NSString *key,NSDictionary *obj, BOOL *stop) {
            
            if (![key isEqualToString:@"img"]) {
                [obj enumerateKeysAndObjectsUsingBlock:^(NSString *key1,NSDictionary *obj1, BOOL *stop) {
                    
                    [obj enumerateKeysAndObjectsUsingBlock:^(NSString *key2, NSDictionary *obj2, BOOL *stop) {
                        [obj2 enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSString *obj3, BOOL *stop) {
                            [temp setObject:obj3 forKey:name];
                        }];
                    }];
                }];
            }
        }];
        
        self.attributesDic = temp;
    }
}

@end
