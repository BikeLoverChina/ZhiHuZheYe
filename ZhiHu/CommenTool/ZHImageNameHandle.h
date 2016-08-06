//
//  ZHImageNameHandle.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

//bundle 和图片名字的分隔符
#define  SEPARATESYMBOL @":"

@interface ZHImageNameHandle : NSObject

/*!
 @method
 @abstract      给图片名字加上bundle路径前缀，以 SEPARATESYMBOL 分隔
 @param image   图片名字
 @param bundle  图片bundle路径
 @result        返回 bundlename+SEPARATESYMBOL+image 格式字符串
 */
+ (NSString *)handleImageBundle:(NSString *)bundle Name:(NSString *)image;

@end
