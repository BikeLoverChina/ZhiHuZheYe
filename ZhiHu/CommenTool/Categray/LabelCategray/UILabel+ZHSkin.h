//
//  UILabel+ZHSkin.h
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZHSkin)

/*!
 *  fontSize
 */
@property (nonatomic, copy) NSString              *fontSizeKey;

/*!
 *  fontName
 */
@property (nonatomic, copy) NSString              *fontNameKey;

/*!
 *  textColor
 */
@property (nonatomic, copy) NSString              *textColorKey;


/*!
 *  highlightedTextColorKey
 */
@property (nonatomic, copy) NSString              *highlightedTextColorKey;

/*!
 @property
 @abstract 获取文字宽度
 @author
 */
+(CGFloat)calcLableWidth:(UILabel*)aLable withMaxHeight:(CGFloat)aMaxHeight;

/*!
 @property
 @abstract 获取文字高度
 @author
 */
+(CGFloat)calcLableHeight:(UILabel*)aLable withMaxWidth:(CGFloat)aMaxWidth;

@end
