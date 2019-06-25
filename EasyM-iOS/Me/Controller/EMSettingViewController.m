//
//  EMSettingViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/26.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMSettingViewController.h"
#import "EMSettingTableViewCell.h"

@interface EMSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    self.itemArr = @[@[@"每日复习提醒时间", @"夜间模式", @"删除缓存", @"仅在 WiFi 环境下载", @"软件升级"], @[@"联系我们"], @[@"注销登陆"]];
    
    // 设置UI
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    // 3. 动态列表
    UITableView *settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:settingTableView];
    settingTableView.estimatedRowHeight = 44.0f;
    settingTableView.sd_layout
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, TAB_BAR_HEIGHT);
    settingTableView.dataSource = self;
    settingTableView.delegate = self;
    [settingTableView registerClass:[EMSettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EMSettingTableViewCell class])];
    self.tableView = settingTableView;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.itemArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMSettingTableViewCell class]) forIndexPath:indexPath];

    if (indexPath.section == 2) {
        NSArray *arr = self.itemArr[indexPath.section];
        cell.title = arr[indexPath.row];

    } else {
        NSArray *arr = self.itemArr[indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
        if (indexPath.section == 0) {
            if (indexPath.row == 1 || indexPath.row == 3) {
                UISwitch *switchView = [[UISwitch alloc] init];
                cell.accessoryView = switchView;
            }
        }
    
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        // 注销登陆
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 登录状态改为未登录
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:NO forKey:@"LoginedAccount"];
            // 发送通知跳转控制器
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessChangeVC" object:nil];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        // 弹出提示框
        [self presentViewController:alertController animated:true completion:nil];
        
        
    }
}

@end
