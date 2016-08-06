//
//  ZHRefreshTableViewController.m
//  ZhiHu
//
//  Created by Apple on 16/7/23.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "ZHRefreshTableViewController.h"
#import "MJRefreshStateHeader.h"
#import "MJRefreshFooter.h"
#import "UIView+MJExtension.h"
#import "MJRefresh.h"
#import "ZHConstants.h"
#import "ZHRefreshHeaderView.h"
#import "ZHRefreshFooterView.h"

@interface ZHRefreshTableViewController () 

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZHRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 顶部刷新控件
    [self initRefreshHeader];
    // 底部刷新控件
    [self initRefreshFooter];
}

- (void)initRefreshHeader
{
    ZHRefreshHeaderView *freshHeaderView = [ZHRefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(headerViewPullToRefresh:)];
    [freshHeaderView beginRefreshing];
    self.zhTableView.mj_header = freshHeaderView;
}

- (void)initRefreshFooter
{
    ZHRefreshFooterView *freshFooterView = [ZHRefreshFooterView footerWithRefreshingTarget:self refreshingAction:@selector(footerViewPullToRefresh:)];
    self.zhTableView.mj_footer = freshFooterView;
}

- (void)setContentInset:(UIEdgeInsets)contentInset{
    if (!UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset)) {
        _contentInset = contentInset;
        self.zhTableView.contentInset = _contentInset;
        self.zhTableView.scrollIndicatorInsets = _contentInset;
    }
}

- (void)headerViewPullToRefresh:(MJRefreshHeader *)refreshHeader
{
    [self pullUpdateTriggering:refreshHeader type:PULLVIEW_TYPE_HEADER];
}

- (void)footerViewPullToRefresh:(MJRefreshFooter *)refreshFooter
{
    [self pullUpdateTriggering:refreshFooter type:PULLVIEW_TYPE_FOOTER];
}

- (void)pullUpdateTriggering:(MJRefreshComponent *)sender type:(PULLVIEW_TYPE)aType
{
    __weak UITableView *tableView = self.zhTableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        if (aType == PULLVIEW_TYPE_HEADER) {
            [tableView.mj_header endRefreshing];
        }
        else
        {
            [tableView.mj_footer endRefreshing];
        }
    });
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableView *)zhTableView
{
    if (_zhTableView == nil) {
        _zhTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                        style:UITableViewStylePlain];
        _zhTableView.dataSource = self;
        [_zhTableView setBackgroundColor:[UIColor yellowColor]];
        _zhTableView.delegate=self;
        _zhTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _zhTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _zhTableView;
}

@end
