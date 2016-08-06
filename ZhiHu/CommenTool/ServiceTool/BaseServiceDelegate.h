//
//  BaseServiceDelegate.h
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

@protocol BaseServiceDelegate <NSObject>

@optional
/*!
 @method
 @abstract   开始获取网络请求时的调用
 @discussion 开始传输数据
 @param      obj 用于网络请求传递的对象
 */
- (void)netServiceStartedWithObj:(id)obj;
/*!
 @method
 @abstract   接受完传输数据时的调用
 @discussion 完成传输数据
 @param      obj 用于网络请求传递的对象
 */
- (void)netServiceFinishedWithObj:(id)obj;
/*!
 @method
 @abstract   请求错误时的调用
 @discussion 请求接口错误或接口返回错误信息时调用此方法
 @param      obj 用于网络请求传递的对象
 */
- (void)netServiceErrorWithCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage netServiceObj:(id)obj;
@end