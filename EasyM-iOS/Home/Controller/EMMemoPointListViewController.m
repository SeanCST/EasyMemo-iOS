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
#import "EMProjectModel.h"

@interface EMMemoPointListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *memoPointArr;
@property (nonatomic, copy) NSString *memoName;
@property (nonatomic, copy) NSString *memoId;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EMMemoPointListViewController

- (instancetype)initWithMemoName:(NSString *)memoName memoId:(NSString *)memoId {
    if (self = [super init]) {
        self.memoName = memoName;
        self.memoId = memoId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.memoName;
    
    [self setupUI];
    [self requestData];
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

#pragma mark - Data
- (void)requestData {
    NSString *URLString = @"/easyM/getAllKonwPoint";
    NSDictionary *params = @{
                             @"knowProjectID": self.memoId
                             };
    
    EMWeakSelf;
    [[EMSessionManager shareInstance] getRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        NSString *response = [NSString stringWithFormat:@"%@", responseObject[@"response"]];
        if ([response isEqualToString:@"200"]) {
            if ([responseObject[@"knowPoints"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in responseObject[@"knowPoints"]) {
                    EMKnowPointModel *model = [EMKnowPointModel yy_modelWithDictionary:dict];
                    [weakSelf.memoPointArr addObject:model];
                }
                
                [weakSelf.tableView reloadData];
            } else {
                NSLog(@"responseObject - %@", responseObject);
            }
        } else {
            NSLog(@"responseObject - %@", responseObject);
        }
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
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
    EMKnowPointModel *model = self.memoPointArr[indexPath.row];
    cell.textLabel.text = model.question;
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

        [self createKnowPointWithQuestion:questionTextField.text answer:answerTextField.text];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    // 弹出提示框
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)createKnowPointWithQuestion:(NSString *)question answer:(NSString *)answer {
    NSString *URLString = @"/easyM/createKnowPoint";
    NSString *uuid = [self uuidString];
    NSDictionary *dict = @{
                           @"knowPointID": uuid,
                           @"question" : question,
                           @"answer" : answer,
                           @"knowProjectID" : self.memoId,
                           };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"pointJSON" : jsonString
                             };
    
    EMWeakSelf;
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"知识点添加成功"];
        EMKnowPointModel *model = [EMKnowPointModel new];
        model.question = question;
        model.answer = answer;
        [weakSelf.memoPointArr addObject:model];
        [weakSelf.tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@", error]);
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
        
//        for (int i = 0; i < 5; i++) {
//            [_memoPointArr addObject:[NSString stringWithFormat:@"这是问题啊 —— %d", i + 1]];
//        }
    }
    return _memoPointArr;
}


@end
