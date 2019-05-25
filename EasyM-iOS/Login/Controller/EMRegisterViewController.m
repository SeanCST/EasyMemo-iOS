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
@property (nonatomic, strong) UIButton *verifyCodeBtn;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSUInteger countDownSeconds;

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
    [verifyCodeBtn setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
    [verifyCodeBtn setBackgroundImage:[self imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:verifyCodeBtn];
    verifyCodeBtn.sd_layout
    .rightEqualToView(passwordField)
    .widthIs(90)
    .heightIs(30)
    .centerYEqualToView(phoneField);
    self.verifyCodeBtn = verifyCodeBtn;
    
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
    NSString *URLString = @"/easyM/sendCode";
    NSDictionary *params = @{
                             @"phoneNumber": self.phoneField.text,
                             };
    
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        if ([@"200" isEqualToString:responseObject[@"response"]]) {
            
            self.verifyCodeBtn.enabled = NO;
            self.verifyCodeBtn.selected = YES;
            self.countDownTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timeCountDown) userInfo:nil repeats:YES];
            self.countDownSeconds = 60;
            [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
            
        } else {
            [SVProgressHUD showInfoWithStatus:responseObject[@"response"]];
        }
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
    
}

/**
 短信倒计时
 */
- (void)timeCountDown {
    NSLog(@"%@", [NSString stringWithFormat:@"%lu 秒", (unsigned long)self.countDownSeconds]);
    if (self.countDownSeconds == 0) {
        self.verifyCodeBtn.enabled = YES;
        self.verifyCodeBtn.selected = NO;
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        [self.verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"%lu 秒", (unsigned long)self.countDownSeconds--] forState:UIControlStateNormal];
}

/**
 无账号、前往注册
 */
- (void)rigisterBtnClicked {

    NSString *URLString = @"/easyM/register";
    NSDictionary *params = @{
                             @"phoneNumber": self.phoneField.text,
                             @"password": self.passwordField.text,
                             @"verificationCode" : self.verifyCodeField.text
                             };
    
    [SVProgressHUD showWithStatus:@"注册中"];
    
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        // 注册成功，已不需要倒计时按钮，关闭定时器
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        
        if ([@"200" isEqualToString:responseObject[@"response"]]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功并登陆"];
            // 存储已登录的状态
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"LoginedAccount"];
            
            // 用户信息由字典转为模型并本地化
            EMUserModel *userModel = [EMUserInfo userModelWithDict:responseObject];
            [EMUserInfo saveLocalUser:userModel];
            
            // 发送通知跳转控制器
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessChangeVC" object:nil];
        } else {
            [SVProgressHUD showInfoWithStatus:responseObject[@"response"]];
        }
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"登陆失败"];
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
