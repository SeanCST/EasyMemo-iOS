//
//  EMDiscoveryViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoveryViewController.h"
//#import "EMDiscoveryCollectionView.h"
//#import "EMDiscoveryCollectionViewCell.h"
#import "EMDiscoveryUpdatingsTableViewCell.h"
#import "EMDiscoverySearchViewController.h"

@interface EMDiscoveryViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

//@property (nonatomic, strong) NSMutableArray *categoryArr;
//@property (nonatomic, strong) EMDiscoveryCollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EMDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置UI
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    // 1. 顶部搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索笔记";
    searchBar.delegate = self;
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    [searchField setBackgroundColor: UIColorFromRGB(0xF8F8F8)];
    [searchField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [self.view addSubview:searchBar];
    searchBar.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 10 + NAVIGATION_BAR_HEIGHT)
    .heightIs(32);

    // 2. 动态列表
    UITableView *discoveryUpdatingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.view addSubview:discoveryUpdatingsTableView];
    discoveryUpdatingsTableView.estimatedRowHeight = 200.0f;
    discoveryUpdatingsTableView.sd_layout
    .topSpaceToView(searchBar, 10)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, TAB_BAR_HEIGHT);
    discoveryUpdatingsTableView.dataSource = self;
    discoveryUpdatingsTableView.delegate = self;
    [discoveryUpdatingsTableView registerClass:[EMDiscoveryUpdatingsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EMDiscoveryUpdatingsTableViewCell class])];
    self.tableView = discoveryUpdatingsTableView;
}


#pragma mark - UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:@"text" cellClass:[EMDiscoveryUpdatingsTableViewCell class] contentViewWidth:kScreenWidth];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMDiscoveryUpdatingsTableViewCell *cell = (EMDiscoveryUpdatingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMDiscoveryUpdatingsTableViewCell class]) forIndexPath:indexPath];
//    cell.contentView.backgroundColor = kRandomColor;
    //缓存高度，tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];

    return cell;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    EMDiscoverySearchViewController *searchVc = [[EMDiscoverySearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
    
    return NO;
}


@end
