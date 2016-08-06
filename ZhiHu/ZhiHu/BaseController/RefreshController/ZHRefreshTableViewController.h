//
//  ZHRefreshTableViewController.h
//  ZhiHu
//
//  Created by Apple on 16/7/23.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

//刷新条类型
typedef NS_ENUM(NSInteger, PULLVIEW_TYPE){
    PULLVIEW_TYPE_HEADER,  //下拉刷新条
    PULLVIEW_TYPE_FOOTER   //上拉刷新条
};

@class MJRefreshComponent;
@interface ZHRefreshTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *zhTableView;

/*!
 @property
 @abstract 设置ahTableView 的contentInset
 */
@property (nonatomic, assign) UIEdgeInsets              contentInset;

/*!
 @method
 @abstract   ahTableView 刷新前调用，子类重写此方法
 */
- (void)pullUpdateTriggering:(MJRefreshComponent *)sender type:(PULLVIEW_TYPE)aType;
@end
