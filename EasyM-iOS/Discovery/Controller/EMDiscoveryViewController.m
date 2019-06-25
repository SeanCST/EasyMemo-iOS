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
#import "EMUpdatingModel.h"
#import "EMProjectDetailViewController.h"

@interface EMDiscoveryViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

//@property (nonatomic, strong) NSMutableArray *categoryArr;
//@property (nonatomic, strong) EMDiscoveryCollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *updates;

@end

@implementation EMDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置UI
    [self setupUI];
    
    [self requestData];
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

#pragma mark - requestData
- (void)requestData {
    NSString *URLString = @"/easyM/getAllUpdates";
    EMUserModel *userModel = [EMUserInfo getLocalUser];
    NSDictionary *params = @{
                             @"userId": userModel.uID
                             };
    
    EMWeakSelf;
    [[EMSessionManager shareInstance] getRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in responseObject) {
                EMUpdatingModel *model = [EMUpdatingModel yy_modelWithDictionary:dict];
                [weakSelf.updates addObject:model];
            }
            
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"responseObject - %@", responseObject);
        }
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
    
}


#pragma mark - UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.updates.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:@"text" cellClass:[EMDiscoveryUpdatingsTableViewCell class] contentViewWidth:kScreenWidth];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMDiscoveryUpdatingsTableViewCell *cell = (EMDiscoveryUpdatingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMDiscoveryUpdatingsTableViewCell class]) forIndexPath:indexPath];
    [cell setDataModel:self.updates[indexPath.row]];
    //缓存高度，tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar

    EMProjectDetailViewController *detailVc = [[EMProjectDetailViewController alloc] initWithUpdatingModel:self.updates[indexPath.row]];
    [self.navigationController pushViewController:detailVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar
    
    EMDiscoverySearchViewController *searchVc = [[EMDiscoverySearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
    return NO;
}

#pragma mark - lazy loading
- (NSMutableArray *)updates {
    if (!_updates) {
        _updates = [NSMutableArray array];
    }
    return _updates;
}

@end
