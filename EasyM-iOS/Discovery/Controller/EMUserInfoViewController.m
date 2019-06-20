
//
//  EMUserInfoViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/6/19.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMUserInfoViewController.h"
#import "EMMeHeaderView.h"
#import "EMHomeMemoCollectionView.h"
#import "EMHomeMemoCollectionViewCell.h"
#import "EMProjectModel.h"

@interface EMUserInfoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoArr;
@property (nonatomic, strong) EMHomeMemoCollectionView *collectionView;
@property (nonatomic, strong) EMMeHeaderView *headerView;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) EMUserModel *userModel;

@end

@implementation EMUserInfoViewController

- (instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置UI
    [self setupUI];
    [self requestData];
}

#pragma mark - setupUI
- (void)setupUI {
    // 1. 顶部个人信息
    EMMeHeaderView *headerView = [[EMMeHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, 130)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
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
    self.hidesBottomBarWhenPushed = NO; // 加这一句防止放回的时候也不显示 tabbar 了
}


#pragma mark - Data
- (void)requestData {
    EMWeakSelf;
    NSString *URLString = @"/easyM/projects";
    EMUserModel *localUserModel = [EMUserInfo getLocalUser];
    NSDictionary *params = @{
                             @"user_uid": localUserModel.uID
                             };
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
    
    
    NSString *userInfoURLString = @"/easyM/getUserInfo";
    NSDictionary *userInfoParams = @{
                             @"curUserId": localUserModel.uID,
                             @"userId" : self.userId
                             };
    [[EMSessionManager shareInstance] getRequestWithURL:userInfoURLString parameters:userInfoParams success:^(id  _Nullable responseObject) {
        weakSelf.userModel = [EMUserModel yy_modelWithDictionary:[responseObject firstObject]];
        weakSelf.userModel.other = YES;
        
        weakSelf.headerView.model = weakSelf.userModel;
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)memoArr {
    if (!_memoArr) {
        _memoArr = [NSMutableArray array];
    }
    return _memoArr;
}

@end
