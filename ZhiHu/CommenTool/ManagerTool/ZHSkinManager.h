//
//  ZHSkinManager.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHSkinManager : NSObject

/*!
 *  当前的皮肤包名称，默认为"AHDefaultSkin"
 */
@property (nonatomic, strong) NSString *skinName;
/**
 *  @method:创建单例对象
 *
 *  @return 创建好的皮肤管理器
 */
+ (instancetype)sharedManager;
/**
 *  @method:根据图片key返回UIImage对象
 *
 *  @param key 每一个图片对应的key
 *
 *  @return 返回的image对象
 */
- (UIImage *)imageWithImageKey:(NSString *)key;

/**
 *  @method:返回的颜色
 *
 *  @param  颜色key
 *
 *  @return 返回的颜色
 */
- (UIColor *)colorWithColorKey:(NSString *)key;

/**
 *  @method:根据字体key返回对应的字体
 *
 *  @param nameKey 字体key
 *
 *  @param sizeKey 大小key
 *
 *  @return 返回的字体
 */
- (UIFont *)fontForNameKey:(NSString*)nameKey sizeKey:(NSString *)sizeKey;

@end
