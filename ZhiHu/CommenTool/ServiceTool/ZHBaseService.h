//
//  ZHBaseService.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServiceDelegate.h"

@class AFHTTPSessionManager;
@interface ZHBaseService : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
/*!
 @property
 @abstract 网络服务监听的委托者
 */
@property (nonatomic, weak) id<BaseServiceDelegate> delegate;

#pragma mark - GET请求相关方法
/*!
 @method
 @abstract   发送get请求
 @discussion 发送get请求
 @param      postUrl 数据地址
 @result     返回结果 nil
 */
-(void)getData:(NSString *)postUrl;

#pragma mark - 发送POST请求的相关方法
/*!
 @method
 @abstract   发送post请求
 @discussion 发送post请求
 @param      postURL数据地址， paraDic表示为上传的参数字典
 @result     返回结果 nil
 */
- (void)sendPost:(NSString *)postURL parameter:(NSDictionary *)paraDic;

#pragma mark - 需子类实现的方法
/*!
 @method
 @abstract   解析json
 @discussion 解析json 在子类中继承实现解析的方法
 @param      strJSON 返回的json数据, 也可以通过responseData（NSData类型）数据解析
 @result     返回结果 nil
 */
-(BOOL)parseJsonDict:(NSDictionary *)strJsonDict;

#pragma mark - 网络相关的请求
/*!
 @method
 @abstract   取消网络请求
 @discussion 取消网络请求,并且设置httpRequest的delegate为空
 @result     返回结果 nil
 */
- (void)clearDelegatesAndCancel;

/*!
 @method
 @abstract   取消网络请求
 @discussion 取消网络请求
 @result     返回结果 nil
 */
- (void)cancel;

@end
