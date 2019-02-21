//
//  EMLoginViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/21.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMLoginViewController.h"

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
    // 填写手机号
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"手机号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneField];
    phoneField.sd_layout
    .topSpaceToView(self.view, 180)
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

}


/**
 登陆 - 网络请求
 */
- (void)loginBtnClicked {
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
