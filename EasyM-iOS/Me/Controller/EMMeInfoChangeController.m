//
//  EMMeInfoChangeController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/6/25.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMMeInfoChangeController.h"

@interface EMMeInfoChangeController ()
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UIView *usernameLine;
@end

@implementation EMMeInfoChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    
    [self setupUI];
    
    // 编辑、确定按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitleColor:EMBackgroundColor forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
}

- (void)setupUI {
    EMUserModel *model = [EMUserInfo getLocalUser];
    
    // 账号
    UILabel *phoneLabel = [UILabel new];
    [self.view addSubview:phoneLabel];
    phoneLabel.font = [UIFont systemFontOfSize:18];
    phoneLabel.text = @"帐号";
    phoneLabel.sd_layout
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT)
    .heightIs(44)
    .widthIs(60)
    .leftSpaceToView(self.view, 30);
    
    UILabel *phoneNumberLabel = [UILabel new];
    [self.view addSubview:phoneNumberLabel];
    phoneNumberLabel.font = [UIFont systemFontOfSize:18];
    phoneNumberLabel.text = model.phoneNumber;
    phoneNumberLabel.textColor = [UIColor grayColor];
    phoneNumberLabel.sd_layout
    .topEqualToView(phoneLabel)
    .rightEqualToView(self.view)
    .heightIs(44)
    .leftSpaceToView(phoneLabel, 30);
    
    UIView *phoneBtmLine = [[UIView alloc] init];
    phoneBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:phoneBtmLine];
    phoneBtmLine.sd_layout
    .bottomEqualToView(phoneLabel)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(1);
    
    // 用户名
    UILabel *usernameLabel = [UILabel new];
    [self.view addSubview:usernameLabel];
    usernameLabel.font = [UIFont systemFontOfSize:18];
    usernameLabel.text = @"用户名";
    usernameLabel.sd_layout
    .topSpaceToView(phoneLabel, 0)
    .heightIs(44)
    .widthIs(60)
    .leftEqualToView(phoneLabel);
    
    UITextField *usernameField = [UITextField new];
    [self.view addSubview:usernameField];
    usernameField.font = [UIFont systemFontOfSize:18];
    usernameField.text = model.username;
    usernameField.textColor = [UIColor grayColor];
    usernameField.sd_layout
    .topEqualToView(usernameLabel)
    .rightEqualToView(self.view)
    .heightIs(44)
    .leftSpaceToView(usernameLabel, 30);
    usernameField.userInteractionEnabled = NO;
    self.usernameField = usernameField;
    
    UIView *usernameBtmLine = [[UIView alloc] init];
    usernameBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:usernameBtmLine];
    usernameBtmLine.sd_layout
    .bottomEqualToView(usernameLabel)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(1);
    
    UIView *usernameLine = [[UIView alloc] init];
    usernameLine.backgroundColor = [UIColor blackColor];
    [usernameField addSubview:usernameLine];
    usernameLine.sd_layout
    .bottomSpaceToView(usernameField, 5)
    .leftEqualToView(usernameField)
    .rightSpaceToView(usernameField, 50)
    .heightIs(1);
    usernameLine.hidden = YES;
    self.usernameLine = usernameLine;
}

- (void)editBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected) { // 点击了编辑
        self.usernameLine.hidden = NO;
        self.usernameField.userInteractionEnabled = YES;
        
    } else { // 点击了完成
        self.usernameLine.hidden = YES;
        self.usernameField.userInteractionEnabled = NO;
        
        EMUserModel *model = [EMUserInfo getLocalUser];
        if (![self.usernameField.text isEqualToString:model.username]) { // 用户名不一样，有改动
            NSString *URLString = @"/easyM/changeUsername";
            NSDictionary *params = @{
                                     @"uID": model.uID,
                                     @"username": self.usernameField.text
                                     };
            
            [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
                if ([@"200" isEqualToString:responseObject[@"response"]]) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    // 新用户名本地化
                    model.username = self.usernameField.text;
                    [EMUserInfo saveLocalUser:model];
            
                } else {
                    [SVProgressHUD showInfoWithStatus:responseObject[@"response"]];
                }
                
            } fail:^(NSError * _Nullable error) {
                NSLog(@"%@", error);
            }];
        }
    }    
}

@end
