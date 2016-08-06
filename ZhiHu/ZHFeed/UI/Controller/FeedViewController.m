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
#import "FeedListService.h"

#define CONTENTINSET_BOTTOM 45
#define CONTENTINSET_TOP    44

@interface FeedViewController () <UISearchBarDelegate, BaseServiceDelegate>

@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) UISearchBar     *searchBar;
@property (nonatomic, strong) FeedListService *feedListService;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
    [self initData];
    [self initServices];
    [self initSearchView];
}

- (void)initTableView
{
    self.zhTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.zhTableView setBackgroundColor:[UIColor yellowColor]];
    self.contentInset = UIEdgeInsetsMake(0, 0, CONTENTINSET_BOTTOM, 0);
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
    [self setupSearchBar];
}

- (void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    
    self.searchBar.frame = CGRectMake(0, IOS7_STATUS_BAR_HEGHT, SCREEN_WIDTH, 44);
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索问答、文章、话题、或用户";
//    [self.view addSubview:self.searchBar];
    
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.5 animations:^{
        //1.
//        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
//        self.searchBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        
        //2.
//        self.searchBar.showsCancelButton = YES;
//        [self setupCancelButton];
        
//        [self.popView showThePopViewWithArray:self.titleArray];
    }];
}

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
        [self.dataArray addObject:[NSString stringWithFormat:@"Hello -- %d",rand()]];
    }
    [self.zhTableView reloadData];
}

- (void)showMore
{
    for (int i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"Good -- %d",rand()]];
    }
    [self.zhTableView reloadData];
}

#pragma mark- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
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
            [_dataArray addObject:[NSString stringWithFormat:@"Test title -- %d",i]];
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
