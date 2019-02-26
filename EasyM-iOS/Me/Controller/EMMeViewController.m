//
//  EMMeViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMMeViewController.h"
#import "EMMeHeaderView.h"
#import "EMHomeMemoCollectionView.h"
#import "EMHomeMemoCollectionViewCell.h"
#import "EMSettingViewController.h"

@interface EMMeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoArr;
@property (nonatomic, strong) EMHomeMemoCollectionView *collectionView;

@end

@implementation EMMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 左右上角 navigationItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"站内信" style:UIBarButtonItemStylePlain target:self action:@selector(messageClicked)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置UI
    [self setupUI];
    
    // 设置笔记数据
    for (int i = 0; i < 6; i++) {
        [self.memoArr addObject:[NSString stringWithFormat:@"笔记本-%d", i]];
    }
    [self.collectionView reloadData];
}

#pragma mark - setupUI
- (void)setupUI {
    // 1. 顶部个人信息
    EMMeHeaderView *headerView = [[EMMeHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, 120)];
    [self.view addSubview:headerView];
    
    // 2. 笔记本列表
    // 设置 flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 100);
    
    EMHomeMemoCollectionView *collectionView = [[EMHomeMemoCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.sd_layout
    .topSpaceToView(headerView, 10)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view, TAB_BAR_HEIGHT);
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[EMHomeMemoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class])];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.memoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EMHomeMemoCollectionViewCell *cell = (EMHomeMemoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class]) forIndexPath:indexPath];
    cell.memoName = self.memoArr[indexPath.row];
    return cell;
}

#pragma mark - ButtonClicked
- (void)settingClicked {
    NSLog(@"设置————点击");
    
    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar

    EMSettingViewController *settingVc = [[EMSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO; 
}

- (void)messageClicked {
    NSLog(@"站内信————点击");
}

#pragma mark - 懒加载
- (NSMutableArray *)memoArr {
    if (!_memoArr) {
        _memoArr = [NSMutableArray array];
    }
    return _memoArr;
}
@end
