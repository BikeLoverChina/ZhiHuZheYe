//
//  ZHBaseProgressView.m
//  PieAnimationDemo
//
//  Created by Apple on 16/7/31.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHBaseProgressView.h"

@implementation ZHBaseProgressView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZHProgressViewBackgroundColor;
        self.layer.cornerRadius = MIN(self.frame.size.width, self.frame.size.height)*0.5;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (progress >= 1.0) {
//            [self removeFromSuperview];
//        } else {
            [self setNeedsDisplay];
//        }
    });
    
}

- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes
{
    CGFloat xCenter = self.frame.size.width * 0.5;
    CGFloat yCenter = self.frame.size.height * 0.5;
    
    // 判断系统版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        CGSize strSize = [text sizeWithAttributes:attributes];
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        [text drawAtPoint:CGPointMake(strX, strY) withAttributes:attributes];
    } else {
        CGSize strSize;
        NSAttributedString *attrStr = nil;
        if (attributes[NSFontAttributeName]) {
            strSize = [text sizeWithFont:attributes[NSFontAttributeName]];
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        } else {
            strSize = [text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
            attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]}];
        }
        
        CGFloat strX = xCenter - strSize.width * 0.5;
        CGFloat strY = yCenter - strSize.height * 0.5;
        
        [attrStr drawAtPoint:CGPointMake(strX, strY)];
    }
    
    
    
}

// 清除指示器
- (void)dismiss
{
    self.progress = 1.0;
}

+ (id)progressView
{
    return [[self alloc] init];
}

@end
