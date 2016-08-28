//
//  TopPicBottomTextCell.h
//  ZhiHu
//
//  Created by Apple on 16/8/28.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopPicBottomTextCellDelegate <NSObject>

// 更多按钮
- (void)moreButtonDidClick:(id)sender;

// 点赞按钮
- (void)upCountBtnDidClick:(id)sender;

// 评论按钮
- (void)commentBtnDidClick:(id)sender;

// 去往专栏按钮
- (void)specialBtnDidClick:(id)sender;

// 关注按钮
- (void)concernBtnDidClick:(id)sender;

@end

@class DataModel;
@interface TopPicBottomTextCell : UITableViewCell

@property (nonatomic, weak) id<TopPicBottomTextCellDelegate> delegate;

@property (nonatomic, strong) DataModel *dataModel;

@end
