//
//  UIButton+ZHSkin.m
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "UIButton+ZHSkin.h"
#import "ZHSkinManager.h"

@implementation UIButton (ZHSkin)

- (void)setBackgroundImageKey:(NSString *)key forState:(UIControlState)state
{
    [self setBackgroundImage:[[ZHSkinManager sharedManager] imageWithImageKey:key] forState:state];
}

- (void)setImageKey:(NSString *)key forState:(UIControlState)state
{
    [self setImage:[[ZHSkinManager sharedManager] imageWithImageKey:key] forState:state];
}

- (void)setBackgroundColorKey:(NSString *)key forState:(UIControlState)state
{
    [self setBackgroundImage:[self imageWithColorKey:key andSize:self.frame.size] forState:state];
}

- (void)setTitleColorKey:(NSString *)key forState:(UIControlState)state
{
    
}

- (UIImage *)imageWithColorKey:(NSString *)colorKey andSize:(CGSize)aSize {
    UIColor *color = [[ZHSkinManager sharedManager] colorWithColorKey:colorKey];
    return [self imageWithColor:color andSize:aSize];
}

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize {
    CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)zh_setImage:(id)image
            forState:(UIControlState)state
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale {
    [self zh_setImage:image
              forState:state
                toSize:self.frame.size
          cornerRadius:cornerRadius
          isEqualScale:isEqualScale];
}

- (void)zh_setImage:(id)image
            forState:(UIControlState)state
              toSize:(CGSize)targetSize
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale {
    [self _private_zh_setImage:image
                       forState:state
              isBackgroundImage:NO
                         toSize:targetSize
                   cornerRadius:cornerRadius
                   isEqualScale:isEqualScale];
}

- (void)zh_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale {
    [self zh_setBackgroundImage:image
                        forState:state
                          toSize:self.frame.size
                    cornerRadius:cornerRadius
                    isEqualScale:isEqualScale];
}

- (void)zh_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale {
    [self _private_zh_setImage:image
                       forState:state
              isBackgroundImage:YES
                         toSize:targetSize
                   cornerRadius:cornerRadius
                   isEqualScale:isEqualScale];
}

#pragma mark - Private
- (void)_private_zh_setImage:(id)image
                     forState:(UIControlState)state
            isBackgroundImage:(BOOL)isBackImage
                       toSize:(CGSize)targetSize
                 cornerRadius:(CGFloat)cornerRadius
                 isEqualScale:(BOOL)isEqualScale {
    if (image == nil || targetSize.width == 0 || targetSize.height == 0) {
        return;
    }
    
    UIImage *willBeClipedImage = image;
    if ([image isKindOfClass:[NSString class]]) {
        willBeClipedImage = [UIImage imageNamed:image];
    } else if ([image isKindOfClass:[UIImage class]]) {
        willBeClipedImage = image;
    } else if ([image isKindOfClass:[NSData class]]) {
        willBeClipedImage = [UIImage imageWithData:image];
    }
    
    if (willBeClipedImage == nil) {
        return;
    }
    
    __block UIImage *clipedImage = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool {
//            willBeClipedImage.zh_pathColor = self.zh_pathColor;
//            willBeClipedImage.zh_pathWidth = self.zh_pathWidth;
//            willBeClipedImage.zh_borderColor = self.zh_borderColor;
//            willBeClipedImage.zh_borderWidth = self.zh_borderWidth;
//            
//            clipedImage = [willBeClipedImage zh_clipToSize:targetSize
//                                               cornerRadius:cornerRadius
//                                                    corners:UIRectCornerAllCorners
//                                            backgroundColor:self.backgroundColor
//                                               isEqualScale:isEqualScale
//                                                   isCircle:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (clipedImage) {
                    if (isBackImage) {
                        [self setBackgroundImage:clipedImage forState:state];
                    } else {
                        [self setImage:clipedImage forState:state];
                    }
                }
            });
        }
    });
}

@end
