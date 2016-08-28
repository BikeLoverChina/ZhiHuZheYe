//
//  FeedViewController.m
//  ZhiHu
//
//  Created by Apple on 16/7/16.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "FeedViewController.h"
#import "ZHBaseService.h"
#import "ZHRefreshTableViewController.h"
#import "ZHConstants.h"
#import "ZHAdapterConstants.h"
#import "ZHUISkinConstants.h"
#import "UIView+ZHSkin.h"
#import "UIButton+ZHSkin.h"
#import "UILabel+ZHSkin.h"
#import "UIImage+ZHSkin.h"
#import "UIImageView+ZHSkin.h"
#import "ZHFeedImageConstants.h"
#import "FeedListService.h"
#import "SDAutoLayout.h"
#import "FeedImageNameHandle.h"
#import "TopPicBottomTextCell.h"
#import "DataModel.h"

#define CONTENTINSET_BOTTOM 45
#define CONTENTINSET_TOP    44

#define ZHFeedSearchTitle @"搜索问答、文章、话题、或用户"

static NSString *cellIdentifier = @"cellIdentifier";

@interface FeedViewController () <UISearchBarDelegate, BaseServiceDelegate>

@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) UIView          *searchBgView;
@property (nonatomic, strong) UIButton        *searchButton;
@property (nonatomic, strong) FeedListService *feedListService;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.zhTableView registerClass:[TopPicBottomTextCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self initTableView];
    [self initData];
    [self initServices];
    [self initSearchView];
}

- (void)initTableView
{
    self.zhTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.zhTableView.backgroundColorKey = ZHcolor08;
    self.contentInset = UIEdgeInsetsMake(IOS7_STATUS_BAR_HEGHT+NavigationBar_HEIGHT, 0, CONTENTINSET_BOTTOM, 0);
    [self.view addSubview:self.zhTableView];
}

- (void)initData
{
    
}

- (void)initServices
{
    self.feedListService = [[FeedListService alloc] init];
    self.feedListService.delegate = self;
}

- (void)initSearchView
{
    // 背景图
    self.searchBgView = [[UIView alloc] init];
    [self.view addSubview:self.searchBgView];
    self.searchBgView.backgroundColorKey = ZHcolor09;
    
    // 搜索按钮
    self.searchButton = [[UIButton alloc] init];
    [self.searchBgView addSubview:self.searchButton];
    [self.searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.layer.cornerRadius = 3.0;
    self.searchButton.layer.masksToBounds = YES;
    self.searchButton.backgroundColorKey = ZHcolor18;
    // 搜索图片
    UIImageView *searchImg = [[UIImageView alloc] init];
    [searchImg setImageKey:[FeedImageNameHandle handleImageName:ZHSearchHistoryIcon]];
    [self.searchButton addSubview:searchImg];
    // 搜索标题
    UILabel *searchTitleLbl = [[UILabel alloc] init];
    searchTitleLbl.text = ZHFeedSearchTitle;
    searchTitleLbl.fontSizeKey = ZHtextsize04;
    searchTitleLbl.textColorKey = ZHcolor05;
    [self.searchButton addSubview:searchTitleLbl];
    
    self.searchBgView.sd_layout
    .leftSpaceToView(self.view, ZHUIMargin0)
    .rightSpaceToView(self.view, ZHUIMargin0)
    .topSpaceToView(self.view, ZHUIMargin0)
    .heightIs(IOS7_STATUS_BAR_HEGHT+NavigationBar_HEIGHT);
    
    self.searchButton.sd_layout
    .leftSpaceToView(self.searchBgView, ZHUIMargin10)
    .rightSpaceToView(self.searchBgView, ZHUIMargin10)
    .bottomSpaceToView(self.searchBgView, ZHUIMargin10)
    .heightIs(ZHUIMargin25);
    
    CGFloat searchLblTitleW = [UILabel calcLableWidth:searchTitleLbl withMaxHeight:ZHUIMargin30];
    CGFloat searchImgWH = 15.0;
    CGFloat searcLblRMargin = 10.0;
    CGFloat searchImgLeftMargin = (SCREEN_WIDTH-ZHUIMargin10*2-searchImgWH-searcLblRMargin-searchLblTitleW)*0.5;
    
    searchImg.sd_layout
    .leftSpaceToView(self.searchButton, searchImgLeftMargin)
    .topSpaceToView(self.searchButton, (ZHUIMargin25-searchImgWH)*0.5)
    .heightIs(searchImgWH)
    .widthIs(searchImgWH);
    
    searchTitleLbl.sd_layout
    .leftSpaceToView(searchImg, ZHUIMargin10)
    .topSpaceToView(self.searchButton, ZHUIMargin0)
    .heightIs(ZHUIMargin25)
    .widthIs(searchLblTitleW);
}

#pragma mark- Click

- (void)searchButtonClick:(id)sender
{
    
}

#pragma mark- 网络请求相关

- (void)pullUpdateTriggering:(MJRefreshComponent *)sender type:(PULLVIEW_TYPE)aType
{
    [super pullUpdateTriggering:sender type:aType];
    if (aType == PULLVIEW_TYPE_HEADER) {
        [self getData];
    }
    else
    {
        [self showMore];
    }
}

- (void)getData
{
    [self.dataArray removeAllObjects];
    for (int i = 0; i < 10; i++) {
        DataModel *model = [[DataModel alloc] init];
        [self.dataArray addObject:model];
    }
    [self.zhTableView reloadData];
}

- (void)showMore
{
    for (int i = 0; i < 10; i++) {
        DataModel *model = [[DataModel alloc] init];
        [self.dataArray addObject:model];
    }
    [self.zhTableView reloadData];
}

#pragma mark- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel *model = self.dataArray[indexPath.row];
    CGFloat height = [self.zhTableView cellHeightForIndexPath:indexPath model:model keyPath:@"dataModel" cellClass:[TopPicBottomTextCell class] contentViewWidth:SCREEN_WIDTH];
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopPicBottomTextCell *cell = (TopPicBottomTextCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TopPicBottomTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    DataModel *model = self.dataArray[indexPath.row];
    [cell setDataModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZHBaseService *baseService = [[ZHBaseService alloc] init];
//    [baseService getData:nil];
    //https://api.zhihu.com/topstory?action_feed=true&limit=10&reverse_order=0
    [self.feedListService getData:@"https://api.zhihu.com/topstory?action_feed=true&limit=10&reverse_order=0"];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i = 0 ; i < 30; i++) {
            DataModel *model = [[DataModel alloc] init];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}


- (void)netServiceStartedWithObj:(id)obj
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)netServiceFinishedWithObj:(id)obj
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)netServiceErrorWithCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage netServiceObj:(id)obj
{
    NSLog(@"%s",__FUNCTION__);
}

@end
