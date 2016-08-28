

//
//  TopPicBottomTextCell.m
//  ZhiHu
//
//  Created by Apple on 16/8/28.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "TopPicBottomTextCell.h"
#import "ZHAdapterConstants.h"
#import "ZHConstants.h"
#import "SDAutoLayout.h"
#import "UILabel+ZHSkin.h"
#import "ZHAdapterConstants.h"
#import "ZHUISkinConstants.h"
#import "UIView+ZHSkin.h"
#import "UIButton+ZHSkin.h"
#import "UIImage+ZHSkin.h"
#import "UIImageView+ZHSkin.h"
#import "DataModel.h"
#import "UIImageView+AFNetworking.h"

#define ZHRepresentImgRadio 2.4 //图片宽高比

@interface TopPicBottomTextCell ()

/*!
 @property
 @abstract 头像
 */
@property (nonatomic, strong) UIImageView *headerIcon;

/*!
 @property
 @abstract 来自话题
 */
@property (nonatomic, strong) UILabel     *fromTopicLabel;

/*!
 @property
 @abstract 更多按钮
 */
@property (nonatomic, strong) UIButton    *moreButton;

/*!
 @property
 @abstract 代表图
 */
@property (nonatomic, strong) UIImageView *representIcon;

/*!
 @property
 @abstract 标题
 */
@property (nonatomic, strong) UILabel     *titleLabel;

/*!
 @property
 @abstract 子标题
 */
@property (nonatomic, strong) UILabel     *subTitleLabel;

/*!
 @property
 @abstract 赞
 */
@property (nonatomic, strong) UIButton    *upCountBtn;

/*!
 @property
 @abstract 赞后面分割圆点
 */
@property (nonatomic, strong) UILabel     *firstPointLabel;

/*!
 @property
 @abstract 评论
 */
@property (nonatomic, strong) UIButton    *commentBtn;

/*!
 @property
 @abstract 评论面分割圆点
 */
@property (nonatomic, strong) UILabel     *secondPointLabel;

/*!
 @property
 @abstract 去往专栏
 */
@property (nonatomic, strong) UIButton   *specialBtn;

/*!
 @property
 @abstract 关注
 */
@property (nonatomic, strong) UIButton   *concernBtn;

@end

@implementation TopPicBottomTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    // 头像
    self.headerIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headerIcon];
    
    // 来自话题
    self.fromTopicLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.fromTopicLabel];
    [self.fromTopicLabel setTextColorKey:ZHcolor05];
    [self.fromTopicLabel setFontSizeKey:ZHtextsize03];
    
    // 更多按钮
    self.moreButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.moreButton];
    [self.moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 代表图
    self.representIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.representIcon];
    
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel setTextColorKey:ZHcolor02];
    [self.titleLabel setFontSizeKey:ZHtextsize02];
    
    // 子标题
    self.subTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel setTextColorKey:ZHcolor04];
    [self.subTitleLabel setFontSizeKey:ZHtextsize04];
    
    // 赞
    self.upCountBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.upCountBtn];
    [self.upCountBtn setTitle:@"1000赞同" forState:UIControlStateNormal];
    [self.upCountBtn setTitleColorKey:ZHcolor05 forState:UIControlStateNormal];
    [self.upCountBtn.titleLabel setFontSizeKey:ZHtextsize03];
    [self.upCountBtn addTarget:self action:@selector(upCountBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 赞后面分割圆点
    self.firstPointLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.firstPointLabel];
    [self.firstPointLabel setText:@"·"];
    [self.firstPointLabel setTextColorKey:ZHcolor05];
    [self.firstPointLabel setFontSizeKey:ZHtextsize03];
    [self.firstPointLabel setTextAlignment:NSTextAlignmentCenter];
    
    // 评论
    self.commentBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn setTitleColorKey:ZHcolor05 forState:UIControlStateNormal];
    [self.commentBtn.titleLabel setFontSizeKey:ZHtextsize03];
    [self.commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 评论后面分割圆点
    self.secondPointLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.secondPointLabel];
    [self.secondPointLabel setText:@"·"];
    [self.secondPointLabel setTextColorKey:ZHcolor05];
    [self.secondPointLabel setFontSizeKey:ZHtextsize03];
    [self.secondPointLabel setTextAlignment:NSTextAlignmentCenter];
    
    // 去往专栏
    self.specialBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.specialBtn];
    self.specialBtn.hidden = YES;
    [self.specialBtn setTitle:@"去往专栏" forState:UIControlStateNormal];
    [self.specialBtn setTitleColorKey:ZHcolor05 forState:UIControlStateNormal];
    [self.specialBtn.titleLabel setFontSizeKey:ZHtextsize03];
    [self.specialBtn addTarget:self action:@selector(specialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 关注
    self.concernBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.concernBtn];
    [self.concernBtn setTitle:@"关注问题" forState:UIControlStateNormal];
    [self.concernBtn setTitleColorKey:ZHcolor05 forState:UIControlStateNormal];
    [self.concernBtn.titleLabel setFontSizeKey:ZHtextsize03];
    [self.concernBtn addTarget:self action:@selector(concernBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 适配
    UIView *contentView = self.contentView;
    
    // 头像
    self.headerIcon.sd_layout
    .leftSpaceToView(contentView, ZHUIMargin10)
    .topSpaceToView(contentView, ZHUIMargin10)
    .widthIs(ZHUIMargin20)
    .heightEqualToWidth();
    
    // 更多按钮
    self.moreButton.sd_layout
    .topEqualToView(self.headerIcon)
    .rightSpaceToView(contentView, ZHUIMargin10)
    .heightIs(ZHUIMargin20)
    .widthIs(ZHUIMargin20);
    
    // 来自话题
    self.fromTopicLabel.sd_layout
    .leftSpaceToView(self.headerIcon, ZHUIMargin5)
    //.rightSpaceToView(self.moreButton, ZHUIMargin5+ZHUIMargin20)
    .topEqualToView(self.headerIcon)
    .heightIs(ZHUIMargin20);
    [self.fromTopicLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    // 标题
    self.titleLabel.sd_layout
    .leftEqualToView(self.headerIcon)
    .rightSpaceToView(contentView, ZHUIMargin0)
    .topSpaceToView(self.headerIcon, ZHUIMargin10)
    .autoHeightRatio(0);
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel setMaxNumberOfLinesToShow:2];
    
    
    // 代表图
    self.representIcon.sd_layout
    .leftSpaceToView(contentView, ZHUIMargin0)
    .rightSpaceToView(contentView, ZHUIMargin0)
    .topSpaceToView(self.titleLabel, ZHUIMargin10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(SCREEN_WIDTH/ZHRepresentImgRadio);
    
    // 子标题
    self.subTitleLabel.sd_layout
    .leftSpaceToView(contentView, ZHUIMargin10)
    .rightSpaceToView(contentView, ZHUIMargin0)
    .topSpaceToView(self.representIcon, ZHUIMargin10)
    .autoHeightRatio(0);
    self.subTitleLabel.numberOfLines = 0;
    [self.subTitleLabel setMaxNumberOfLinesToShow:3];
    
    // 赞
    CGFloat upCountBtnH = [UILabel calcLableHeight:self.upCountBtn.titleLabel withMaxWidth:CGFLOAT_MAX];
    self.upCountBtn.sd_layout
    .leftEqualToView(self.subTitleLabel)
    .topSpaceToView(self.subTitleLabel, ZHUIMargin10);
    [self.upCountBtn setupAutoSizeWithHorizontalPadding:0.0 buttonHeight:upCountBtnH];
    
    // 赞后面分割圆点
    self.firstPointLabel.sd_layout
    .leftSpaceToView(self.upCountBtn, ZHUIMargin0)
    .topEqualToView(self.upCountBtn)
    .heightIs(upCountBtnH)
    .widthIs(ZHUIMargin21);
    
    // 评论
    self.commentBtn.sd_layout
    .leftSpaceToView(self.firstPointLabel, ZHUIMargin0)
    .topEqualToView(self.upCountBtn)
    .heightIs(upCountBtnH);
    [self.commentBtn setupAutoSizeWithHorizontalPadding:0.0 buttonHeight:upCountBtnH];
    
    // 评论后面分割圆点
    self.secondPointLabel.sd_layout
    .leftSpaceToView(self.commentBtn, ZHUIMargin0)
    .topEqualToView(self.commentBtn)
    .heightRatioToView(self.firstPointLabel, 1.0)
    .widthRatioToView(self.firstPointLabel, 1.0);
    
    // 关注
    self.concernBtn.sd_layout
    .leftSpaceToView(self.secondPointLabel, ZHUIMargin0)
    .topEqualToView(self.upCountBtn)
    .heightIs(upCountBtnH);
    [self.concernBtn setupAutoSizeWithHorizontalPadding:0.0 buttonHeight:upCountBtnH];
    
    // 去往专栏
    self.specialBtn.sd_layout
    .leftSpaceToView(self.secondPointLabel, ZHUIMargin0)
    .topEqualToView(self.upCountBtn)
    .heightIs(upCountBtnH);
    [self.specialBtn setupAutoSizeWithHorizontalPadding:0.0 buttonHeight:upCountBtnH];
    
    [self setupAutoHeightWithBottomView:self.upCountBtn bottomMargin:ZHUIMargin10];
}

- (void)setDataModel:(DataModel *)dataModel
{
    // 头像
//    self.headerIcon setImageWithURL:<#(nonnull NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
    self.headerIcon.backgroundColor = [UIColor redColor];
    
    // 来自话题
    self.fromTopicLabel.text = @"来自话题:旅游";
    self.moreButton.backgroundColor = [UIColor redColor];
    
    // 带表图
//    self.representIcon setImageWithURL:<#(nonnull NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
    self.representIcon.backgroundColor = [UIColor purpleColor];
    
    // 标题
    self.titleLabel.text = @"宝石修复的具体过程有哪些?";
    
    // 子标题
    self.subTitleLabel.text = @"今天上午，刚刚加盟洛杉矶湖人队的易建联出现在深圳福田易建联篮球训练中心，出席薪火阵营篮球发展计划发布会。这是他加盟湖人后第一次也是唯一一次公开亮相。在发布会上，阿联表达了对宏远的感谢，同时他表示，如果4年后身体状态允许，他还会再参加一次奥运会。";
    
    // 赞同
    [self.upCountBtn setTitle:@"41赞同" forState:UIControlStateNormal];
    
    // 评论
    [self.commentBtn setTitle:@"100评论" forState:UIControlStateNormal];
    
    // 关注
    [self.concernBtn setTitle:@"关注问题" forState:UIControlStateNormal];
}

// 更多按钮
- (void)moreButtonClick:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(moreButtonDidClick:)]) {
        [self.delegate moreButtonDidClick:sender];
    }
}

// 点赞按钮
- (void)upCountBtnClick:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(upCountBtnDidClick:)]) {
        [self.delegate upCountBtnDidClick:sender];
    }
}

// 评论按钮
- (void)commentBtnClick:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(commentBtnDidClick:)]) {
        [self.delegate commentBtnDidClick:sender];
    }
}

// 去往专栏按钮
- (void)specialBtnClick:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(specialBtnDidClick:)]) {
        [self.delegate specialBtnDidClick:sender];
    }
}

// 关注按钮
- (void)concernBtnClick:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(concernBtnDidClick:)]) {
        [self.delegate concernBtnDidClick:sender];
    }
}

@end
