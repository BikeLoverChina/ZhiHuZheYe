//
//  UIButton+ZHSkin.h
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZHSkin)

/*!
 *  设置 backgroundImage
 */
- (void)setBackgroundImageKey:(NSString *)key forState:(UIControlState)state;
/*!
 *  设置 image
 */
- (void)setImageKey:(NSString *)key forState:(UIControlState)state;
/*!
 *  设置 backgroundColor
 */
- (void)setBackgroundColorKey:(NSString *)key forState:(UIControlState)state;
/*!
 *  设置 titleColor
 */
- (void)setTitleColorKey:(NSString *)key forState:(UIControlState)state;

/**
 * 下面是一个小例子，设置正常和高亮状态下的图片:
 *
 * [button zh_setImage:@"img1.jpeg" forState:UIControlStateNormal cornerRadius:40 isEqualScale:YES];
 [button zh_setImage:@"bimg5.jpg" forState:UIControlStateHighlighted cornerRadius:40 isEqualScale:NO];
 */


#pragma mark - 设置按钮图片
/**
 *	处理图片过大问题，要求button本身的size已经确定有值，否则不处理.
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image				图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *	@param cornerRadius	圆角
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)zh_setImage:(id)image
            forState:(UIControlState)state
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale;

/**
 *	处理图片过大问题，要求button本身的size已经确定有值，否则不处理
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可*
 *
 *	@param image				图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *  @param targetSize   图片最终大小
 *	@param cornerRadius	圆角
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)zh_setImage:(id)image
            forState:(UIControlState)state
              toSize:(CGSize)targetSize
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale;

#pragma mark - 设置按钮背景图片
/**
 *	处理图片大小与控件大小不一致问题。设置背景图片。要求按钮本身已经有确定的大小。
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image        图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *	@param cornerRadius	圆角大小
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)zh_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;

/**
 *	处理图片大小与控件大小不一致问题。设置背景图片。要求按钮本身已经有确定的大小。
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image        图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *  @param targetSize   图片最终大小
 *	@param cornerRadius	圆角大小
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)zh_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;
@end
