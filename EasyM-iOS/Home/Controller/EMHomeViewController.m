//
//  EMHomeViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/21.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMHomeViewController.h"
#import "EMHomeMemoCollectionView.h"
#import "EMHomeMemoCollectionViewCell.h"

@interface EMHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoArr;
@property (nonatomic, strong) EMHomeMemoCollectionView *collectionView;

@end

@implementation EMHomeViewController

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
    searchBar.placeholder = @"搜索您的笔记";
//    searchBar.showsCancelButton = YES;
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
    
    // 2. 添加笔记按钮
    UIButton *addMemoButton = [UIButton new];
    [self.view addSubview:addMemoButton];
    [addMemoButton setImage:[UIImage imageNamed:@"icon_memo_add"] forState:UIControlStateNormal];
    [addMemoButton setImage:[UIImage imageNamed:@"icon_memo_add_highlighted"] forState:UIControlStateHighlighted];
    addMemoButton.sd_layout
    .heightIs(128)
    .widthIs(128)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, TAB_BAR_HEIGHT);
    [addMemoButton addTarget:self action:@selector(addMemoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 3. 笔记本列表
    // 设置 flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 100);

    EMHomeMemoCollectionView *collectionView = [[EMHomeMemoCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.sd_layout
    .topSpaceToView(searchBar, 10)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(addMemoButton, 10);
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[EMHomeMemoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class])];
    self.collectionView = collectionView;
}

- (void)addMemoButtonClicked {
    NSString *memoName = [NSString stringWithFormat:@"笔记名—%ld", self.memoArr.count + 1];
    [self.memoArr addObject:memoName];
    
    [self.collectionView reloadData];
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

#pragma mark - 懒加载
- (NSMutableArray *)memoArr {
    if (!_memoArr) {
        _memoArr = [NSMutableArray array];
    }
    return _memoArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
