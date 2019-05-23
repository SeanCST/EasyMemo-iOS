//
//  EMRegisterViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/23.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMRegisterViewController.h"

@interface EMRegisterViewController ()
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *verifyCodeField;
@end


@implementation EMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
}

- (void)initViews {
    // Label - 账号注册
    UILabel *loginLabel = [UILabel new];
    [self.view addSubview:loginLabel];
    [loginLabel  setTextColor:[UIColor blackColor]];
    [loginLabel  setFont:[UIFont systemFontOfSize:20.0f]];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setText:@"账号注册"];
    loginLabel.sd_layout
    .topSpaceToView(self.view, 180)
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    
    // 填写手机号
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"手机号";
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

    // 填写验证码
    UITextField *verifyCodeField = [[UITextField alloc] init];
    verifyCodeField.placeholder = @"验证码";
    verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:verifyCodeField];
    verifyCodeField.sd_layout
    .topSpaceToView(phoneField, 10)
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.verifyCodeField = verifyCodeField;
    
    UIView *verifyCodeFieldBtmLine = [[UIView alloc] init];
    verifyCodeFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:verifyCodeFieldBtmLine];
    verifyCodeFieldBtmLine.sd_layout
    .bottomEqualToView(verifyCodeField)
    .leftEqualToView(verifyCodeField)
    .rightEqualToView(verifyCodeField)
    .heightIs(1);
    
    // 填写密码
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.secureTextEntry = YES;
    passwordField.placeholder = @"密码";
    [self.view addSubview:passwordField];
    passwordField.sd_layout
    .topSpaceToView(verifyCodeField, 10)
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
    
    
    // 获取验证码按钮
    UIButton *verifyCodeBtn = [[UIButton alloc] init];
    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyCodeBtn setBackgroundImage:[self imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [verifyCodeBtn setBackgroundImage:[self imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:verifyCodeBtn];
    verifyCodeBtn.sd_layout
    .rightEqualToView(passwordField)
    .widthIs(90)
    .heightIs(30)
    .centerYEqualToView(phoneField);
    
    // 完成注册并登陆按钮
    UIButton *rigisterBtn = [[UIButton alloc] init];
    [rigisterBtn setTitle:@"完成注册并登陆" forState:UIControlStateNormal];
    [rigisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigisterBtn setBackgroundImage:[self imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [rigisterBtn setBackgroundImage:[self imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [rigisterBtn addTarget:self action:@selector(rigisterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigisterBtn];
    rigisterBtn.sd_layout
    .topSpaceToView(passwordField, 30)
    .leftEqualToView(passwordField)
    .rightEqualToView(passwordField)
    .heightRatioToView(passwordField, 1);
}


/**
 获取验证码
 */
- (void)verifyCodeBtnClicked {
    
}

/**
 无账号、前往注册
 */
- (void)rigisterBtnClicked {
    //    NSString *URLString = [NSString stringWithFormat:@"%@/login/cellphone", BaseUrl];
    //    NSDictionary *params = @{@"phone": self.phoneField.text,
    //                             @"password": self.passwordField.text
    //                             };
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    [manager GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { // 登陆成功
    
    // 存储已登录的状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"LoginedAccount"];
    
    // 发送通知跳转控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessChangeVC" object:nil];
    
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
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
