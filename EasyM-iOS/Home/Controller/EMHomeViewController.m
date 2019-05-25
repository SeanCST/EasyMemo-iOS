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
#import "EMMemoPointListViewController.h"
#import "EMProjectModel.h"

@interface EMHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *memoArr;
//@property (nonatomic, strong) NSMutableArray *searchResultArr;
//@property (nonatomic, assign) BOOL searchActive;

@property (nonatomic, strong) EMHomeMemoCollectionView *collectionView;

@end

@implementation EMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    // 设置UI
    [self setupUI];
    [self requestData];
}

#pragma mark - setupUI
- (void)setupUI {
//    // 1. 顶部搜索栏
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.placeholder = @"搜索您的笔记";
//    searchBar.delegate = self;
//    UITextField *searchField = [searchBar valueForKey:@"searchField"];
//    [searchField setBackgroundColor: UIColorFromRGB(0xF8F8F8)];
//    [searchField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
//    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
//    [self.view addSubview:searchBar];
//    searchBar.sd_layout
//    .leftSpaceToView(self.view, 10)
//    .rightSpaceToView(self.view, 10)
//    .topSpaceToView(self.view, 10 + NAVIGATION_BAR_HEIGHT)
//    .heightIs(32);
    
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
//    .topSpaceToView(searchBar, 10)
    .topSpaceToView(self.view, 10 + NAVIGATION_BAR_HEIGHT)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(addMemoButton, 10);
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[EMHomeMemoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class])];
    self.collectionView = collectionView;
    
    // 给 collectionView 添加长按手势
    UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0f;
    longPressGr.delegate = self;
    longPressGr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:longPressGr];
}

- (void)addMemoButtonClicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建笔记" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入笔记名";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *memoNameTextField = alertController.textFields.firstObject;
        NSLog(@"你输入的文本 —— %@", memoNameTextField.text);
        
        [self createKnowProjectWithTitle:memoNameTextField.text];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    // 弹出提示框
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)longPressToDo:(UILongPressGestureRecognizer *)longPressGr {
//    if(longPressGr.state != UIGestureRecognizerStateEnded) {
//        return;
//    }
    
    CGPoint p = [longPressGr locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if(indexPath == nil) {
        NSLog(@"couldn't find index path");
    } else {
        EMProjectModel *projModel = self.memoArr[indexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:projModel.know_project_name message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"编辑——");
        }];
        UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"分享——");
        }];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"删除—— %@", projModel.know_project_name);
            [self deleteProjectAtIndex:indexPath.row];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消——");
        }];
        [alertController addAction:editAction];
        [alertController addAction:shareAction];
        [alertController addAction:deleteAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

- (void)createKnowProjectWithTitle:(NSString *)title {
    NSString *URLString = @"/easyM/createKnowProject";
    EMUserModel *userModel = [EMUserInfo getLocalUser];
    NSString *uuid = [self uuidString];
    NSDictionary *dict = @{
                           @"createUserId": userModel.uID,
                           @"knowProjectName" : title,
                           @"knowProjectID" : uuid,
                           };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"projectJSON" : jsonString
                             };
    
    EMWeakSelf;
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"笔记创建成功"];
        EMProjectModel *model = [EMProjectModel new];
        model.know_project_name = title;
        model.know_project_id = uuid;
        [weakSelf.memoArr addObject:model];
        [weakSelf.collectionView reloadData];
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}

- (void)deleteProjectAtIndex:(NSUInteger)index {
    NSString *URLString = @"/easyM/delKnowProject";
    EMUserModel *userModel = [EMUserInfo getLocalUser];
    EMProjectModel *projModel = self.memoArr[index];
    NSDictionary *dict = @{
                            @"createUserId": userModel.uID,
                            @"knowProjectName" : projModel.know_project_name,
                            @"knowProjectID" : projModel.know_project_id,
                            };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"projectJSON" : jsonString
                             };
    
    EMWeakSelf;
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"笔记删除成功"];
        [weakSelf.memoArr removeObjectAtIndex:index];
        [weakSelf.collectionView reloadData];
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.searchActive) {
//        return self.searchResultArr.count;
//    } else {
        return self.memoArr.count;
//    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EMHomeMemoCollectionViewCell *cell = (EMHomeMemoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EMHomeMemoCollectionViewCell class]) forIndexPath:indexPath];
    
//    NSString *memoName;
//    if (self.searchActive) {
//        memoName = self.searchResultArr[indexPath.row];
//    } else {
//       memoName = self.memoArr[indexPath.row];
//    }
//    cell.memoName = memoName;
    
    [cell setProjectModel:self.memoArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar

    EMProjectModel *projModel = self.memoArr[indexPath.row];
    
    EMMemoPointListViewController *vc = [[EMMemoPointListViewController alloc] initWithMemoName:projModel.know_project_name memoId:projModel.know_project_id];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO; // 加这一句防止放回的时候也不显示 tabbar 了
}


#pragma mark - UISearchBarDelegate
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    [self.searchResultArr removeAllObjects];
//
//    if (searchText.length == 0) {
//        self.searchActive = NO;
//        [self.collectionView reloadData];
//        return;
//    }
//    self.searchActive = YES;
//
//    EMWeakSelf;
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
//    dispatch_async(globalQueue, ^{
//
//        // 遍历需要搜索的所有内容
//        [weakSelf.memoArr enumerateObjectsUsingBlock:^(NSString *memoName, NSUInteger idx, BOOL * _Nonnull stop) {
//            // 把搜索结果存放 searchResultArr 数组
//            if ([memoName containsString:searchText]) {
//                NSLog(@"加入——%@", memoName);
//                [weakSelf.searchResultArr addObject:memoName];
////                NSLog(@"%@", weakSelf.searchResultArr);
//            }
//        }];
//
//        //回到主线程
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.collectionView reloadData];
//        });
//    });
//
//}

#pragma mark - Data
- (void)requestData {
    NSString *URLString = @"/easyM/projects";
    EMUserModel *userModel = [EMUserInfo getLocalUser];
    NSDictionary *params = @{
                             @"user_uid": userModel.uID
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
}


#pragma mark - private methods
/**
 *  生成32位UUID
 */
- (NSString *)uuidString{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    
    NSString *UUID = [uuid lowercaseString];
    
    NSLog(@"随机生成 —— UUID —— %@", UUID);
    
    return UUID;
}

#pragma mark - 懒加载
- (NSMutableArray *)memoArr {
    if (!_memoArr) {
        _memoArr = [NSMutableArray array];
//        [_memoArr addObjectsFromArray:@[@"笔记1", @"笔记2", @"笔记3", @"数据结构", @"算法分析与设计"]];
    }
    return _memoArr;
}

//- (NSMutableArray *)searchResultArr {
//    if (!_searchResultArr) {
//        _searchResultArr = [NSMutableArray array];
//    }
//    return _searchResultArr;
//}

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
