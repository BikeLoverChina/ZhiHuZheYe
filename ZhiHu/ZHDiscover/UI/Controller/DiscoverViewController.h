//
//  DiscoverViewController.h
//  ZhiHu
//
//  Created by Apple on 16/7/16.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UINavigationController

/*!
 @property
 @abstract tabbar标题
 */
@property (nonatomic, copy) NSString *tabbarTitle;
/*!
 @property
 @abstract tabar nor 图片
 */
@property (nonatomic, copy) NSString *tabbarNorImage;
/*!
 @property
 @abstract tabar hightlighted图片
 */
@property (nonatomic, copy) NSString *tabbarHithtLightImage;

@end
