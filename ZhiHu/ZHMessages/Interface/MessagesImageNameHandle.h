//
//  MessagesImageNameHandle.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessagesImageNameHandle : NSObject

/*!
 @method
 @abstract      给图片名字加上bundle路径前缀，以 SEPARATESYMBOL 分隔
 @param image   图片名字
 @result        返回 bundlename+SEPARATESYMBOL+image 格式字符串
 */
+ (NSString *)handleImageName:(NSString *)image;

@end
