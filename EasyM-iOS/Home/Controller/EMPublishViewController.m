//
//  EMPublishViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/30.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMPublishViewController.h"
#import "UIImage+GetImage.h"

@interface EMPublishViewController ()
@property (nonatomic, strong) EMProjectModel *projectModel;

@property (nonatomic, strong) UITextView *briefTextView;
@property (nonatomic, strong) UITextField *schoolField;
@property (nonatomic, strong) UITextField *majorField;

@end

@implementation EMPublishViewController

- (instancetype)initWithProjectModel:(EMProjectModel *)model {
    self = [super init];
    if (self) {
        self.projectModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    UILabel *briefLabel = [UILabel new];
    [self.view addSubview:briefLabel];
    briefLabel.font = [UIFont systemFontOfSize:16];
    briefLabel.textColor = UIColorFromRGB(0x000000);
    briefLabel.text = @"简介";
    briefLabel.sd_layout
    .leftSpaceToView(self.view, 20)
    .heightIs(20)
    .widthIs(100)
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT + 20);
    
    UITextView *briefTextView = [UITextView new];
    [self.view addSubview:briefTextView];
    briefTextView.font = [UIFont systemFontOfSize:16];
    briefTextView.layer.borderColor = [UIColor grayColor].CGColor;
    briefTextView.layer.borderWidth = 1.0f;
    briefTextView.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .heightIs(120)
    .topSpaceToView(briefLabel, 10);
    self.briefTextView = briefTextView;
    
    // Label - 学校
    UILabel *schoolLabel = [UILabel new];
    [self.view addSubview:schoolLabel];
    [schoolLabel  setTextColor:[UIColor blackColor]];
    [schoolLabel  setFont:[UIFont systemFontOfSize:16.0f]];
    [schoolLabel setText:@"学校"];
    schoolLabel.sd_layout
    .topSpaceToView(briefTextView, 20)
    .leftEqualToView(briefLabel)
    .widthIs(50)
    .heightIs(50);
    
    UITextField *schoolField = [[UITextField alloc] init];
    schoolField.placeholder = @"填写学校";
    [self.view addSubview:schoolField];
    schoolField.sd_layout
    .topEqualToView(schoolLabel)
    .leftSpaceToView(schoolLabel, 10)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.schoolField = schoolField;
    
    UIView *schoolFieldBtmLine = [[UIView alloc] init];
    schoolFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:schoolFieldBtmLine];
    schoolFieldBtmLine.sd_layout
    .bottomEqualToView(schoolField)
    .leftEqualToView(schoolField)
    .rightEqualToView(schoolField)
    .heightIs(1);
    
    
    // label - 专业
    UILabel *majorLabel = [UILabel new];
    [self.view addSubview:majorLabel];
    [majorLabel  setTextColor:[UIColor blackColor]];
    [majorLabel  setFont:[UIFont systemFontOfSize:16.0f]];
    [majorLabel setText:@"专业"];
    majorLabel.sd_layout
    .topSpaceToView(schoolLabel, 20)
    .leftEqualToView(briefLabel)
    .widthIs(50)
    .heightIs(50);
    
    // 填写手机号
    UITextField *majorField = [[UITextField alloc] init];
    majorField.placeholder = @"填写专业";
    [self.view addSubview:majorField];
    majorField.sd_layout
    .topEqualToView(majorLabel)
    .leftSpaceToView(majorLabel, 10)
    .rightSpaceToView(self.view, 50)
    .heightIs(50);
    self.majorField = majorField;
    
    UIView *majorFieldBtmLine = [[UIView alloc] init];
    majorFieldBtmLine.backgroundColor = EMSeperateLineColor;
    [self.view addSubview:majorFieldBtmLine];
    majorFieldBtmLine.sd_layout
    .bottomEqualToView(majorField)
    .leftEqualToView(majorField)
    .rightEqualToView(majorField)
    .heightIs(1);
    
    // 发布按钮
    UIButton *pubBtn = [[UIButton alloc] init];
    [pubBtn setTitle:@"发布" forState:UIControlStateNormal];
    [pubBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pubBtn setBackgroundImage:[UIImage imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [pubBtn setBackgroundImage:[UIImage imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    [pubBtn addTarget:self action:@selector(pubBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pubBtn];
    pubBtn.sd_layout
    .topSpaceToView(majorField, 30)
    .leftEqualToView(majorField)
    .rightEqualToView(majorField)
    .heightRatioToView(majorField, 1);
}

- (void)pubBtnClicked {
    NSString *url = @"/easyM/shareKnowProject";
    NSDictionary *dict = @{
                             @"createUserId" : [EMUserInfo getLocalUser].uID,
                             @"brief" : self.briefTextView.text,
                             @"school" : self.schoolField.text,
                             @"major" : self.majorField.text,
                             @"knowProjectID" : self.projectModel.knowProjectID
                             };
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"projectJSON" : jsonString
                             };
    
    [[EMSessionManager shareInstance] postRequestWithURL:url parameters:params success:^(id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError * _Nullable error) {
//        [SVProgressHUD showErrorWithStatus:error];
        NSLog(@"%@", error);
    }];
}

@end
