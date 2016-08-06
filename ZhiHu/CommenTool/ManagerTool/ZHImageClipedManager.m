//
//  ZHImageClipedManager.m
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHImageClipedManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>

static inline NSUInteger ZHCacheCostForImage(UIImage *image) {
    return image.size.height * image.size.width * image.scale * image.scale;
}

@interface ZHImageClipedManager ()

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation ZHImageClipedManager

+ (instancetype)shared {
    static  ZHImageClipedManager *s_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[[self class] alloc] init];
    });
    
    return s_manager;
}

- (NSCache *)sharedCache {
    return self.cache;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(zh_private_clearCaches)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        self.shouldCache = YES;
        self.totalCostInMemory = 60 * 1024 * 1024; // 默认60M
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = self.totalCostInMemory;
        _serialQueue = dispatch_queue_create("com.huangyibiao.imagecliped_serial_queue",
                                             DISPATCH_QUEUE_SERIAL);
        dispatch_sync(self.serialQueue, ^{
            self.fileManager = [[NSFileManager alloc] init];
        });
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

- (void)zh_private_clearCaches {
    [self.cache removeAllObjects];
}

+ (UIImage *)clipedImageFromDiskWithKey:(NSString *)key {
    if (key && key.length) {
        NSString *subpath = [self zh_md5:key];
        
        UIImage *image = nil;
        if ([ZHImageClipedManager shared].shouldCache) {
            image = [[ZHImageClipedManager shared].cache objectForKey:subpath];
            
            if (image) {
                return image;
            }
        }
        
        NSString *path = [[self zh_cachePath] stringByAppendingPathComponent:subpath];
        image = [UIImage imageWithContentsOfFile:path];
        
        return image;
    }
    
    return nil;
}

+ (void)clipedImageFromDiskWithKey:(NSString *)key completion:(ZHCacheImage)completion {
    if (key && key.length) {
        dispatch_async([ZHImageClipedManager shared].serialQueue, ^{
            NSString *subpath = [self zh_md5:key];
            
            UIImage *image = nil;
            if ([ZHImageClipedManager shared].shouldCache) {
                image = [[ZHImageClipedManager shared].cache objectForKey:subpath];
                
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completion) {
                            completion(image);
                        }
                    });
                    return;
                }
            }
            
            NSString *path = [[self zh_cachePath] stringByAppendingPathComponent:subpath];
            image = [UIImage imageWithContentsOfFile:path];
            
            if (image != nil && [ZHImageClipedManager shared].shouldCache) {
                NSUInteger cost = ZHCacheCostForImage(image);
                [[ZHImageClipedManager shared].cache setObject:image forKey:subpath cost:cost];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(image);
                }
            });
        });
    } else {
        if (completion) {
            completion(nil);
        }
    }
}

+ (void)storeClipedImage:(UIImage *)clipedImage toDiskWithKey:(NSString *)key {
    if (clipedImage == nil || key == nil || key.length == 0) {
        return;
    }
    
    NSString *subpath = [self zh_md5:key];
    
    if ([ZHImageClipedManager shared].shouldCache) {
        NSUInteger cost = ZHCacheCostForImage(clipedImage);
        [[ZHImageClipedManager shared].cache setObject:clipedImage forKey:subpath cost:cost];
    }
    
    dispatch_async([ZHImageClipedManager shared].serialQueue, ^{
        if (![[ZHImageClipedManager shared].fileManager fileExistsAtPath:[self zh_cachePath] isDirectory:nil]) {
            NSError *error = nil;
            BOOL isOK = [[ZHImageClipedManager shared].fileManager createDirectoryAtPath:[self zh_cachePath]
                                                              withIntermediateDirectories:YES
                                                                               attributes:nil
                                                                                    error:&error];
            if (isOK && error == nil) {
#ifdef kZHImageCliped
                NSLog(@"create folder ZHClipedImages ok");
#endif
            } else {
                return;
            }
        }
        
        @autoreleasepool {
            NSString *path = [[self zh_cachePath] stringByAppendingPathComponent:subpath];
            
            NSData *data = UIImageJPEGRepresentation(clipedImage, 1.0);
            BOOL isOk = [[ZHImageClipedManager shared].fileManager createFileAtPath:path
                                                                            contents:data
                                                                          attributes:nil];
            if (isOk) {
#ifdef kZHImageCliped
                NSLog(@"save cliped image to disk ok, key path is %@", path);
#endif
            } else {
#ifdef kZHImageCliped
                NSLog(@"save cliped image to disk fail, key path is %@", path);
#endif
            }
        }
    });
}

+ (void)clearClipedImagesCache {
    dispatch_async([ZHImageClipedManager shared].serialQueue, ^{
        [[ZHImageClipedManager shared].cache removeAllObjects];
        
        NSString *directoryPath = [self zh_cachePath];
        
        if ([[ZHImageClipedManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:nil]) {
            NSError *error = nil;
            [[ZHImageClipedManager shared].fileManager removeItemAtPath:directoryPath error:&error];
            
            if (error) {
                NSLog(@"clear caches error: %@", error);
            } else {
                NSLog(@"clear caches ok");
            }
        }
    });
}

+ (unsigned long long)imagesCacheSize {
    NSString *directoryPath = [self zh_cachePath];
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[ZHImageClipedManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[ZHImageClipedManager shared].fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[ZHImageClipedManager shared].fileManager attributesOfItemAtPath:path
                                                                                                      error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

#pragma mark - Private
+ (NSString *)zh_cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZHClipedImages"];
}

+ (NSString *)zh_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}


@end
