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

@interface EMDiscoveryViewController () <UITableViewDataSource, UITableViewDelegate>

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
    //    searchBar.delegate = self;
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
    
//    // 2. 分类列表
//    // 设置 flowLayout
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = 10;
//    flowLayout.minimumLineSpacing = 10;
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    flowLayout.itemSize = CGSizeMake(80, 50);
//    EMDiscoveryCollectionView *collectionView = [[EMDiscoveryCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
//    [self.view addSubview:collectionView];
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.sd_layout
//    .topSpaceToView(searchBar, 10)
//    .leftSpaceToView(self.view, 10)
//    .rightSpaceToView(self.view, 10)
//    .heightIs(140);
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
////    collectionView.backgroundColor = [UIColor whiteColor];
//    [collectionView registerClass:[EMDiscoveryCollectionViewCell class] forCellWithReuseIdentifier:kDiscoveryCollectionViewCell];
//    self.collectionView = collectionView;
//
    // 3. 动态列表
    UITableView *discoveryUpdatingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.view addSubview:discoveryUpdatingsTableView];
    discoveryUpdatingsTableView.estimatedRowHeight = 80.0f;
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



//#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.categoryArr.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    EMDiscoveryCollectionViewCell *cell = (EMDiscoveryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDiscoveryCollectionViewCell forIndexPath:indexPath];
//    cell.categoryName = self.categoryArr[indexPath.row];
//    return cell;
//}

#pragma mark - UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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

//#pragma mark - 懒加载
//- (NSMutableArray *)categoryArr {
//    if (!_categoryArr) {
//        _categoryArr = [NSMutableArray arrayWithObjects:@"计算机科学", @"法律", @"金融", @"医学", @"经管", @"其他", nil];
//    }
//    return _categoryArr;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
