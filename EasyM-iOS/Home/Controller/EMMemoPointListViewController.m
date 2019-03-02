//
//  EMMemoPointListViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMMemoPointListViewController.h"
#import "EMPointDetailViewController.h"
#import "EMmemoListHeaderScrollView.h"

@interface EMMemoPointListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoPointArr;
@property (nonatomic, copy) NSString *memoName;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EMMemoPointListViewController

- (instancetype)initWithMemoName:(NSString *)memoName {
    if (self = [super init]) {
        self.memoName = memoName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.memoName;
    
    [self setupUI];
}

- (void)setupUI {
    // 1. 添加笔记知识点按钮
    UIButton *addMemoPointButton = [UIButton new];
    [self.view addSubview:addMemoPointButton];
    [addMemoPointButton setImage:[UIImage imageNamed:@"icon_memo_add"] forState:UIControlStateNormal];
    [addMemoPointButton setImage:[UIImage imageNamed:@"icon_memo_add_highlighted"] forState:UIControlStateHighlighted];
    addMemoPointButton.sd_layout
    .heightIs(128)
    .widthIs(128)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    [addMemoPointButton addTarget:self action:@selector(addMemoPointButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 2. 笔记知识点列表
    UITableView *memoPointTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:memoPointTableView];
    memoPointTableView.estimatedRowHeight = 50.0f;
    memoPointTableView.backgroundColor = [UIColor whiteColor];
    memoPointTableView.sd_layout
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 128);
    memoPointTableView.dataSource = self;
    memoPointTableView.delegate = self;
//    [memoPointTableView registerClass:[UITableView class] forCellReuseIdentifier:@"EMMemoPointListViewCell"];
    self.tableView = memoPointTableView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.memoPointArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[EMMemoListHeaderScrollView alloc] initWithTitles:@[@"按时间排序", @"忽略记得", @"最易忘记"] size:CGSizeMake(kScreenWidth, 44)];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES; //隐藏 tabbar

    EMPointDetailViewController *detailVc = [[EMPointDetailViewController alloc] initWithPointArr:self.memoPointArr currentIndex:indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EMMemoPointListViewCell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EMMemoPointListViewCell"];
    cell.textLabel.text = self.memoPointArr[indexPath.row];
    return cell;
}


#pragma mark - 按钮点击
- (void)addMemoPointButtonClicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加笔记知识点" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入问题";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入答案";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *questionTextField = alertController.textFields.firstObject;
        UITextField *answerTextField = alertController.textFields[1];
        NSLog(@"你输入的问题======%@", questionTextField.text);
        NSLog(@"你输入的答案======%@", answerTextField.text);

        [self.memoPointArr addObject:questionTextField.text];
        [self.tableView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    // 弹出提示框
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)orderByTimeBtnClicked {
    
}

- (void)neglectRememberBtnClicked {
    
}

- (void)mostForgotBtnClicked {
    
}

#pragma 懒加载
- (NSMutableArray *)memoPointArr {
    if (!_memoPointArr) {
        _memoPointArr = [NSMutableArray array];
        
        for (int i = 0; i < 5; i++) {
            [_memoPointArr addObject:[NSString stringWithFormat:@"这是问题啊 —— %d", i + 1]];
        }
    }
    return _memoPointArr;
}


@end
