//
//  UILabel+ZHSkin.m
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "UILabel+ZHSkin.h"
#import <objc/runtime.h>
#import "ZHSkinManager.h"

@implementation UILabel (ZHSkin)

#pragma mark - fontSizeKey

@dynamic fontSizeKey;
static char kPropertyFontSizeKey;

- (void)setFontSizeKey:(NSString *)fontSizeKey
{
    if (fontSizeKey != self.fontSizeKey) {
        objc_setAssociatedObject(self, &kPropertyFontSizeKey, fontSizeKey, OBJC_ASSOCIATION_COPY);
        // 先根据当前主题来设置对应字体大小
        [self changedFontSize];
    }
}

- (NSString *)fontSizeKey
{
    return objc_getAssociatedObject(self, &kPropertyFontSizeKey);
}

#pragma mark - fontNameKey

@dynamic fontNameKey;
static char kPropertyFontNameKey;

- (void)setFontNameKey:(NSString *)fontNameKey
{
    if (fontNameKey != self.fontNameKey)
    {
        objc_setAssociatedObject(self, &kPropertyFontNameKey, fontNameKey, OBJC_ASSOCIATION_COPY);
        [self changedFontName];
    }
}

- (NSString *)fontNameKey
{
    return objc_getAssociatedObject(self, &kPropertyFontNameKey);
}


#pragma mark - textColorKey


@dynamic highlightedTextColorKey;
static char kPropertyHighlightedTextColorKey;

- (void)setHighlightedTextColorKey:(NSString*)highlightedTextColorKey{
    
    if (highlightedTextColorKey != self.highlightedTextColorKey) {
        objc_setAssociatedObject(self, &kPropertyHighlightedTextColorKey, highlightedTextColorKey, OBJC_ASSOCIATION_COPY);
        [self changedHighlightedTextColor];
    }
}

- (NSString*)highlightedTextColorKey{
    
    return objc_getAssociatedObject(self, &kPropertyHighlightedTextColorKey);
}

@dynamic textColorKey;
static char kPropertyTextColorKey;

- (void)setTextColorKey:(NSString *)textColorKey
{
    if (textColorKey != self.textColorKey) {
        objc_setAssociatedObject(self, &kPropertyTextColorKey, textColorKey, OBJC_ASSOCIATION_COPY);
        [self changedTextColor];
    }
}

- (NSString *)textColorKey
{
    return objc_getAssociatedObject(self, &kPropertyTextColorKey);
}

#pragma mark - Override Method

- (void)changedFontSize
{
    if (self.fontSizeKey) {
        self.font = [[ZHSkinManager sharedManager] fontForNameKey:self.fontNameKey sizeKey:self.fontSizeKey];
    }
}

- (void)changedFontName
{
    if (self.fontNameKey) {
        self.font = [[ZHSkinManager sharedManager] fontForNameKey:self.fontNameKey sizeKey:self.fontSizeKey];
    }
}

- (void)changedTextColor
{
    if (self.textColorKey) {
        self.textColor = [[ZHSkinManager sharedManager] colorWithColorKey:self.textColorKey];
    }
}

- (void)changedHighlightedTextColor{
    
    if (self.highlightedTextColorKey) {
        self.highlightedTextColor = [[ZHSkinManager sharedManager]colorWithColorKey:self.highlightedTextColorKey];
    }
}
//获取文字宽度
+(CGFloat)calcLableWidth:(UILabel*)aLable withMaxHeight:(CGFloat)aMaxHeight {
    UIFont *font = nil;
    if (aLable.fontSizeKey
        && (font = [[ZHSkinManager sharedManager] fontForNameKey:aLable.fontNameKey sizeKey:aLable.fontSizeKey]))
    {
        CGSize titleSize = [aLable.text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, aMaxHeight)];
        return titleSize.width;
    }
    else
    {
        return 0.0f;
    }
}
//获取文字高度
+(CGFloat)calcLableHeight:(UILabel*)aLable withMaxWidth:(CGFloat)aMaxWidth {
    UIFont *font = nil;
    if (aLable.fontSizeKey
        && (font = [[ZHSkinManager sharedManager] fontForNameKey:aLable.fontNameKey sizeKey:aLable.fontSizeKey]))
    {
        CGSize titleSize = [aLable.text sizeWithFont:font constrainedToSize:CGSizeMake(aMaxWidth, MAXFLOAT)];
        return titleSize.height;
    }
    else
    {
        return 0.0f;
    }
}

@end
