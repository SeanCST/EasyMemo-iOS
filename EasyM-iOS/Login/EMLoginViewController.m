//
//  EMLoginViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/21.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMLoginViewController.h"
#import "EMRegisterViewController.h"

@interface EMLoginViewController ()
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *passwordField;
@end

@implementation EMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.title = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
}

- (void)initViews {
    // Label - 账号登录
    UILabel *loginLabel = [UILabel new];
    [self.view addSubview:loginLabel];
    [loginLabel  setTextColor:[UIColor blackColor]];
    [loginLabel  setFont:[UIFont systemFontOfSize:20.0f]];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setText:@"账号登录"];
    loginLabel.sd_layout
    .topSpaceToView(self.view, 180)
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    
    // 填写手机号
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"账号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneField];
    phoneField.sd_layout
    .topSpaceToView(loginLabel, 50)
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.phoneField = phoneField;

    UIView *phoneFieldBtmLine = [[UIView alloc] init];
    phoneFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:phoneFieldBtmLine];
    phoneFieldBtmLine.sd_layout
    .bottomEqualToView(phoneField)
    .leftEqualToView(phoneField)
    .rightEqualToView(phoneField)
    .heightIs(1);
    
    
    // 填写密码
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.secureTextEntry = YES;
    passwordField.placeholder = @"密码";
    [self.view addSubview:passwordField];
    passwordField.sd_layout
    .topSpaceToView(phoneField, 10)
    .leftEqualToView(phoneField)
    .rightEqualToView(phoneField)
    .heightRatioToView(phoneField, 1);
    self.passwordField = passwordField;

    UIView *passwordFieldBtmLine = [[UIView alloc] init];
    passwordFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:passwordFieldBtmLine];
    passwordFieldBtmLine.sd_layout
    .bottomEqualToView(passwordField)
    .leftEqualToView(passwordField)
    .rightEqualToView(passwordField)
    .heightRatioToView(phoneFieldBtmLine, 1);
    
    
    // 登陆按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[self imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[self imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    loginBtn.sd_layout
    .topSpaceToView(passwordField, 30)
    .leftEqualToView(passwordField)
    .rightEqualToView(passwordField)
    .heightRatioToView(passwordField, 1);

    // 无账号、注册按钮
    UIButton *rigisterBtn = [[UIButton alloc] init];
    [rigisterBtn setTitle:@"前往注册" forState:UIControlStateNormal];
    [rigisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigisterBtn setBackgroundImage:[self imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [rigisterBtn setBackgroundImage:[self imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [rigisterBtn addTarget:self action:@selector(rigisterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigisterBtn];
    rigisterBtn.sd_layout
    .topSpaceToView(loginBtn, 30)
    .leftEqualToView(loginBtn)
    .rightEqualToView(loginBtn)
    .heightRatioToView(loginBtn, 1);
}


/**
 登陆 - 网络请求
 */
- (void)loginBtnClicked {
    
    NSString *URLString = @"/easyM/login";
    NSDictionary *params = @{
                             @"phoneNumber": self.phoneField.text,
                             @"password": self.passwordField.text
                             };
    
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {

        if ([@"200" isEqualToString:responseObject[@"response"]]) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            // 存储已登录的状态
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"LoginedAccount"];
            
            // 发送通知跳转控制器
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessChangeVC" object:nil];
        } else {
            [SVProgressHUD showInfoWithStatus:responseObject[@"response"]];
        }

    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"登陆失败"];
    }];
    
}

/**
 无账号、前往注册
 */
- (void)rigisterBtnClicked {
    EMRegisterViewController *reVc = [[EMRegisterViewController alloc] init];
    [self presentViewController:reVc animated:YES completion:^{
        
    }];
}


// 颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
