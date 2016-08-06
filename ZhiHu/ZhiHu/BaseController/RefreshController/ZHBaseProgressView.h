//
//  ZHBaseProgressView.h
//  PieAnimationDemo
//
//  Created by Apple on 16/7/31.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZHColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define ZHProgressViewItemMargin 10
#define ZHProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 100.0)
// 背景颜色
#define ZHProgressViewBackgroundColor ZHColorMaker(240, 240, 240, 0.9)

@interface ZHBaseProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes;

- (void)dismiss;

+ (id)progressView;

@end
