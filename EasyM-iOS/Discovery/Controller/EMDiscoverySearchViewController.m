//
//  EMDiscoverySearchViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/29.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMDiscoverySearchViewController.h"
#import "EMDiscoverySearchTableViewCell.h"
#import "EMProjectModel.h"

@interface EMDiscoverySearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchedResults;

@end

@implementation EMDiscoverySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置 UI
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
    
    // 3. 搜索列表
    UITableView *searcheTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.view addSubview:searcheTableView];
    searcheTableView.estimatedRowHeight = 150.0f;
    searcheTableView.sd_layout
    .topSpaceToView(searchBar, 10)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, TAB_BAR_HEIGHT);
    searcheTableView.dataSource = self;
    searcheTableView.delegate = self;
    [searcheTableView registerClass:[EMDiscoverySearchTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EMDiscoverySearchTableViewCell class])];
    self.tableView = searcheTableView;
    
}

#pragma mark - UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchedResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:@"text" cellClass:[EMDiscoverySearchTableViewCell class] contentViewWidth:kScreenWidth];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMDiscoverySearchTableViewCell *cell = (EMDiscoverySearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMDiscoverySearchTableViewCell class]) forIndexPath:indexPath];
    [cell setupData:self.searchedResults[indexPath.row]];
    //缓存高度，tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self requestDataWithKeywords:searchBar.text];
}

#pragma mark - 数据
- (void)requestDataWithKeywords:(NSString *)keywords {
    NSString *url = @"/easyM/searchKnowProject";
    NSDictionary *params = @{
                             @"project_name" : keywords
                             };
    [[EMSessionManager shareInstance] getRequestWithURL:url parameters:params success:^(id  _Nullable responseObject) {
        [self.searchedResults removeAllObjects];
        for (NSDictionary *dict in responseObject) {
            EMProjectModel *model = [EMProjectModel yy_modelWithDictionary:dict];
            [self.searchedResults addObject:model];
        }
        [self.tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"搜索失败"];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)searchedResults {
    if (!_searchedResults) {
        _searchedResults = [NSMutableArray array];
    }
    return _searchedResults;
}

@end
