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
#import "EMProjectModel.h"
#import "EMMeInfoChangeController.h"

@interface EMMeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoArr;
@property (nonatomic, strong) EMHomeMemoCollectionView *collectionView;
@property (nonatomic, strong) EMMeHeaderView *headerView;
@property (nonatomic, strong) EMUserModel *userModel;

@end

@implementation EMMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 左右上角 navigationItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置UI
    [self setupUI];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // 更新数据
    self.headerView.model = [EMUserInfo getLocalUser];
}

#pragma mark - setupUI
- (void)setupUI {
    // 1. 顶部个人信息
    EMMeHeaderView *headerView = [[EMMeHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, 130)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    self.headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTaped)];
    [self.headerView addGestureRecognizer:recognizer];
    
    
    // 2. 笔记本列表
    // 设置 flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 130);
    
    EMHomeMemoCollectionView *collectionView = [[EMHomeMemoCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.sd_layout
    .topSpaceToView(headerView, 10)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view, NAVIGATION_BAR_HEIGHT);
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[EMHomeMemoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class])];
    self.collectionView = collectionView;
    
    
}

#pragma mark - ButtonClicked
- (void)settingClicked {
    NSLog(@"设置————点击");
    
    self.hidesBottomBarWhenPushed = YES; // 隐藏 tabbar

    EMSettingViewController *settingVc = [[EMSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO; 
}

- (void)headerViewTaped {
    self.hidesBottomBarWhenPushed = YES; // 隐藏 tabbar
    EMMeInfoChangeController *vc = [[EMMeInfoChangeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.memoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EMHomeMemoCollectionViewCell *cell = (EMHomeMemoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class]) forIndexPath:indexPath];
    
    [cell setProjectModel:self.memoArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar
    
//    EMProjectModel *projModel = self.memoArr[indexPath.row];
    
//    EMMemoPointListViewController *vc = [[EMMemoPointListViewController alloc] initWithMemoModel:projModel];
//    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO; // 加这一句防止放回的时候也不显示 tabbar 了
    
    
}


#pragma mark - Data
- (void)requestData {
    // 获取关于笔记的信息
    NSString *URLString = @"/easyM/projects";
    EMUserModel *localUserModel = [EMUserInfo getLocalUser];
    NSDictionary *params = @{
                             @"user_uid": localUserModel.uID
                             };
    EMWeakSelf;
    [[EMSessionManager shareInstance] getRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in responseObject) {
                EMProjectModel *model = [EMProjectModel yy_modelWithDictionary:dict];
                [weakSelf.memoArr addObject:model];
            }
            
            [weakSelf.collectionView reloadData];
        } else {
            NSLog(@"responseObject - %@", responseObject);
        }
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
    
    // 获取关于用户资料的信息
    NSString *userInfoURLString = @"/easyM/getUserInfo";
    NSDictionary *userInfoParams = @{
                                     @"curUserId": localUserModel.uID,
                                     @"userId" : localUserModel.uID
                                     };
    [[EMSessionManager shareInstance] getRequestWithURL:userInfoURLString parameters:userInfoParams success:^(id  _Nullable responseObject) {
        weakSelf.userModel = [EMUserModel yy_modelWithDictionary:[responseObject firstObject]];
        weakSelf.userModel.other = NO;
        weakSelf.headerView.model = weakSelf.userModel;
        
        
        EMUserModel *model = [EMUserInfo getLocalUser];
        model.img = weakSelf.userModel.img;
        model.username = weakSelf.userModel.username;
        model.focusNumber = weakSelf.userModel.focusNumber;
        model.fansNumber = weakSelf.userModel.fansNumber;
        model.projectNumber = weakSelf.userModel.projectNumber;
        [EMUserInfo saveLocalUser:model];
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}


#pragma mark - private methods

#pragma mark - 懒加载
- (NSMutableArray *)memoArr {
    if (!_memoArr) {
        _memoArr = [NSMutableArray array];
    }
    return _memoArr;
}

@end
