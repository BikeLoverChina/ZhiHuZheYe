//
//  UIImageView+ZHSkin.h
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZHSkin)
// 直接使用UIView+HYBImageCliped中的扩展即可，如果不使用UIImageView，而是直接使用UIView来呈现图片，
// 这样可以提高一定的性能。扩展中已经添加了对UIView的支持，可以直接给layer设置图片显示
@end
