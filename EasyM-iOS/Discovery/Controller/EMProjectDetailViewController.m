//
//  EMProjectDetailViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/6/17.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMProjectDetailViewController.h"
#import "EMUserInfoViewController.h"

@interface EMProjectDetailViewController ()
@property (nonatomic, strong) UIImageView *memoIconView;
@property (nonatomic, strong) UILabel *memoNameLabel;
@property (nonatomic, strong) UILabel *pointCountLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) EMUpdatingModel *updatingModel;
@property (nonatomic, strong) EMProjectModel *projectModel;

@end

@implementation EMProjectDetailViewController

- (instancetype)initWithUpdatingModel:(EMUpdatingModel *)updatingModel {
    if (self = [super init]) {
        self.updatingModel = updatingModel;
    }
    return self;
}

- (instancetype)initWithProjectModel:(EMProjectModel *)projectModel{
    if (self = [super init]) {
        self.projectModel = projectModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"笔记详情";
    [self setupUI];
}

- (void)setupUI {
    _memoIconView = [[UIImageView alloc] init];
    [self.view addSubview:_memoIconView];
    _memoIconView.backgroundColor = EMBackgroundColor;
    _memoIconView.sd_layout
    .widthIs(100)
    .heightIs(130)
    .leftSpaceToView(self.view, 16)
    .topSpaceToView(self.view, NAVIGATION_BAR_HEIGHT + 20);
    
    // memoNameLabel
    _memoNameLabel = [UILabel new];
    _memoNameLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_memoNameLabel];
    _memoNameLabel.sd_layout
    .heightIs(20)
    .widthIs(kScreenWidth - 180)
    .topEqualToView(_memoIconView)
    .leftSpaceToView(_memoIconView, 20);
    
    // pointCountLabel
    _pointCountLabel = [UILabel new];
    _pointCountLabel.font = [UIFont systemFontOfSize:15];
    _pointCountLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_pointCountLabel];
    _pointCountLabel.sd_layout
    .heightIs(20)
    .widthIs(kScreenWidth - 180)
    .topSpaceToView(_memoNameLabel, 25)
    .leftSpaceToView(_memoIconView, 20);
    
    // updateTimeLabel
    _updateTimeLabel = [UILabel new];
    _updateTimeLabel.font = [UIFont systemFontOfSize:15];
    _updateTimeLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_updateTimeLabel];
    _updateTimeLabel.sd_layout
    .heightIs(20)
    .widthIs(kScreenWidth - 180)
    .topSpaceToView(_pointCountLabel, 25)
    .leftSpaceToView(_memoIconView, 20);
    
    // Avatar头像
    _avatarImageView = [UIImageView new];
    [self.view addSubview:_avatarImageView];
    _avatarImageView.sd_layout
    .topSpaceToView(_memoIconView, 40)
    .leftEqualToView(_memoIconView)
    .widthIs(64)
    .heightIs(64);
    _avatarImageView.sd_cornerRadius = @(32.0);
    _avatarImageView.clipsToBounds = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImageViewTaped)];
    [_avatarImageView addGestureRecognizer:recognizer];
    _avatarImageView.userInteractionEnabled = YES;
    
    // nickNameLabel
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_nickNameLabel];
    _nickNameLabel.sd_layout
    .topEqualToView(_avatarImageView)
    .leftSpaceToView(_avatarImageView, 10)
    .rightSpaceToView(self.view, 10)
    .autoHeightRatio(0);
    [_nickNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    // 下载
    UIButton *downloadBtn = [UIButton new];
    [self.view addSubview:downloadBtn];
    [downloadBtn setTitle:@"下载笔记" forState:UIControlStateNormal];
    [downloadBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [downloadBtn setBackgroundImage:[UIImage imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:[UIImage imageWithColor:EMButtonClickedColor] forState:UIControlStateHighlighted];
    downloadBtn.sd_layout
    .widthIs(250)
    .heightIs(50)
    .bottomSpaceToView(self.view, 150)
    .centerXEqualToView(self.view);
    [downloadBtn addTarget:self action:@selector(downloadProject) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.updatingModel) {
        [self setupDataWithUpdatingModel];
    }
    else if (self.projectModel) {
        [self setupDataWithProjectModel];
    }
}

- (void)setupDataWithUpdatingModel {
    NSString *coverImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, self.updatingModel.coverImg];
    [_memoIconView sd_setImageWithURL:[NSURL URLWithString:coverImgStr] placeholderImage:nil];
    
    [_memoNameLabel setText:self.updatingModel.knowProjectName];

    [_updateTimeLabel setText:[NSString stringWithFormat:@"最后更新于 %@", self.updatingModel.updateCreateTime]];

    NSString *avatarImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, self.updatingModel.headImg];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarImgStr] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    
    [_nickNameLabel setText:self.updatingModel.username];

    [_pointCountLabel setText:[NSString stringWithFormat:@"%ld 个知识点", self.updatingModel.knowPointCount]];
}


- (void)setupDataWithProjectModel {
    NSString *coverImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, self.projectModel.coverImg];
    [_memoIconView sd_setImageWithURL:[NSURL URLWithString:coverImgStr] placeholderImage:nil];
    
    [_memoNameLabel setText:self.projectModel.knowProjectName];
    
    [_updateTimeLabel setText:[NSString stringWithFormat:@"最后更新于 %@", self.projectModel.updateCreateTime]];

    NSString *avatarImgStr = [NSString stringWithFormat:@"%@%@", kBaseURL, self.projectModel.userImg];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarImgStr] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    
    
    [_nickNameLabel setText:self.projectModel.username];
    
    [_pointCountLabel setText:[NSString stringWithFormat:@"%ld 个知识点", (long)self.projectModel.knowPointCount]];
}

- (void)downloadProject {
    NSString *URLString = @"/easyM/downloadKnowProject";
    NSDictionary *params = @{
                             @"project_id": self.updatingModel ? self.updatingModel.knowProjectID : self.projectModel.knowProjectID
                             };
    
    
    [[EMSessionManager shareInstance] postRequestWithURL:URLString parameters:params success:^(id  _Nullable responseObject) {
        
        [SVProgressHUD showSuccessWithStatus:@"已下载笔记"];
        NSLog(@"responseObject - %@", responseObject);
        
    } fail:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}

#pragma mark - 点击事件
- (void)avatarImageViewTaped {
    EMUserInfoViewController *vc;
    
    if (self.updatingModel) {
        vc = [[EMUserInfoViewController alloc] initWithUserId:self.updatingModel.userId];
    } else {
        vc = [[EMUserInfoViewController alloc] initWithUserId:self.projectModel.userId];
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
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
