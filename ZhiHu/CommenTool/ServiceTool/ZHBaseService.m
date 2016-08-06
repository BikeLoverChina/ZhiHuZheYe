//
//  ZHBaseService.m
//  ZhiHu
//
//  Created by Apple on 16/7/17.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHBaseService.h"
#import "AFNetworking.h"

@implementation ZHBaseService

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - GET请求相关方法

-(void)getData:(NSString *)postUrl {
    
    if (self.httpSessionManager != nil) {
        [self.httpSessionManager invalidateSessionCancelingTasks:YES];
    }
    
    self.httpSessionManager = [[AFHTTPSessionManager alloc] init];
    
    // warning : parameters 下列请求头中的内容不要放在parameters,否则请求失败
    [self.httpSessionManager.requestSerializer setValue:@"Bearer 2.0ABCM3RdpHAkLAAAANNS1VwAQjN0XaRwJAACAxf0zGgoLAAAAYAJVTTTUtVcAztyqhxiSZqVyPXS6RyNl9fCOn6c5CWj9NXnUSjN6VjQNEDTMc2dJRA==" forHTTPHeaderField:@"Authorization"];
    [self.httpSessionManager.requestSerializer setValue:@"osee2unifiedRelease/482 CFNetwork/758.3.15 Darwin/15.4.0" forHTTPHeaderField:@"User-Agent"];
    
    // Started 放这里合适吗？待观察
    [self requestStarted];
    [self.httpSessionManager GET:postUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            [weakSelf requestFinished:responseObject];
            [self requestFinished:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailed:error];
    }];
}

- (void)requestStarted {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(netServiceStartedWithObj:)]) {
        
        [self.delegate netServiceStartedWithObj:self];
    }

}

- (void)requestFinished:(NSDictionary *)dict {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    @try {
        
        if (dict == nil)
        {
            //如果不是一个有效的json数据，则认为是出错了
//            [self notifyNetServiceError:self.handle errorCode:-1 errorMessage:NONETWORK];
            return;
        }
        
//        int successFlag = [[dic valueForKey:@"returncode"] intValue];
//        if (0 != successFlag)
//        {
            //如果服务器返回错误的代码，则处理为出错
//            if (self.handle == ENUserInfoService)
//            {
//                [self parseJSON:self.responseString];
//            }
//            [self notifyNetServiceError:_handle errorCode:successFlag errorMessage:[dic valueForKey:@"message"]];
//            
//            return;
//        }
        
        if ([self parseJsonDict:dict])
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(netServiceFinishedWithObj:)])
            {
                [self.delegate netServiceFinishedWithObj:self];
            }
        }
//        else
//        {
//            [self notifyNetServiceError:_handle errorCode:successFlag errorMessage:NONETWORK];
//        }
    }
    @catch (NSException *exception) {
        //解析出错，把错误传递出去
//        [self notifyNetServiceError:_handle errorCode:-1 errorMessage:NONETWORK];
    }
}

- (void)requestFailed:(NSError *)error {
    
}

//分发出错信息给委托
//- (void)notifyNetServiceError:(enum ServiceHandle)currentHandle errorCode:(int)errorCode errorMessage:(NSString *)errorMessage
//{
//    NSLog(@"errorCode========%d====%@",errorCode,errorMessage);
//    if (self.delegate && [self.delegate respondsToSelector:@selector(netServiceError: errorCode: errorMessage:)])
//    {
//        //把错误传递出去
//        if (errorMessage == nil
//            || [errorMessage isKindOfClass:[NSNull class]]
//            || errorMessage.length == 0)
//        {
//            [self.delegate netServiceError:currentHandle errorCode:errorCode errorMessage:NONETWORK];
//        }
//        else
//        {
//            [self.delegate netServiceError:currentHandle errorCode:errorCode errorMessage:errorMessage];
//        }
//    }
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(netServiceError:errorCode:errorMessage:netServiceObj:)]) {
//        if (errorMessage == nil
//            || [errorMessage isKindOfClass:[NSNull class]]
//            || errorMessage.length == 0) {
//            
//            [self.delegate netServiceError:currentHandle errorCode:errorCode errorMessage:NONETWORK netServiceObj:self];
//        }else{
//            
//            [self.delegate netServiceError:currentHandle errorCode:errorCode errorMessage:errorMessage netServiceObj:self];
//        }
//    }
//}

#pragma mark - 发送POST请求的相关方法

- (void)sendPost:(NSURL *)postURL parameter:(NSDictionary *)paraDic {
    
}

#pragma mark - 需子类实现的方法

-(BOOL)parseJsonDict:(NSDictionary *)strJsonDict {
    NSLog(@"%@",strJsonDict);
    return YES;
}

#pragma mark - 网络相关的请求

- (void)clearDelegatesAndCancel {
    
}

- (void)cancel {
    
}

@end
