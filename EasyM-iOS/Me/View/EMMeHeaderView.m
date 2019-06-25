//
//  EMMeHeaderView.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMMeHeaderView.h"
#import "UIView+Response.h"
#import "EMHeaderUploadViewController.h"

@interface EMMeHeaderView()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIButton *toFollowBtn;
@property (nonatomic, strong) UIButton *memoBtn;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIButton *fansBtn;

@end


@implementation EMMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    // 1. 头像
    UIImageView *avatarImageView = [UIImageView new];
    [avatarImageView setImage:[UIImage imageNamed:@"icon_avatar_default"]];
    [self addSubview:avatarImageView];
    avatarImageView.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 5)
    .widthIs(50)
    .heightIs(50);
    avatarImageView.sd_cornerRadius = @(25.0);
    avatarImageView.clipsToBounds = YES;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImageViewTaped)];
    [avatarImageView addGestureRecognizer:recognizer];
    avatarImageView.userInteractionEnabled = YES;
    self.avatarImageView = avatarImageView;
    
    // 2. 昵称
    UILabel *nicknameLabel = [UILabel new];
    nicknameLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:nicknameLabel];
    nicknameLabel.sd_layout
    .heightIs(17)
    .topSpaceToView(self, 15)
    .leftSpaceToView(avatarImageView, 20);
    [nicknameLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 30)];
    [nicknameLabel setText:@"默认用户名"];
    self.nicknameLabel = nicknameLabel;
    
//    // 3. 简介
//    UILabel *briefIntroLabel = [UILabel new];
//    briefIntroLabel.font = [UIFont systemFontOfSize:12];
//    briefIntroLabel.textColor = [UIColor grayColor];
//    [self addSubview:briefIntroLabel];
//    briefIntroLabel.sd_layout
//    .topSpaceToView(nicknameLabel, 10)
//    .leftEqualToView(nicknameLabel)
//    .heightIs(13);
//    // 设置最大宽度
//    [briefIntroLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 40)];
//    // 设置最大行数
//    [briefIntroLabel setText:@"简介：你就当我是学霸吧哈哈哈或哈哈哈哈或哈哈哈哈或哈哈哈😁啊啊"];
    
    // 4. 中间分割线
    UIView *midSeperateLine = [UIView new];
    [self addSubview:midSeperateLine];
    midSeperateLine.backgroundColor = UIColorFromRGB(0xefefef);
    midSeperateLine.sd_layout
    .widthIs(kScreenWidth)
    .heightIs(1)
    .leftEqualToView(self)
    .topSpaceToView(avatarImageView, 10);
    
    // 5. 底部分割小段
    UIView *bottomSeperateLine = [UIView new];
    [self addSubview:bottomSeperateLine];
    bottomSeperateLine.backgroundColor = UIColorFromRGB(0xefefef);
    bottomSeperateLine.sd_layout
    .widthIs(kScreenWidth)
    .heightIs(10)
    .leftEqualToView(self)
    .bottomEqualToView(self);
    
    // 6. 关注按钮
    UIButton *toFollowBtn = [UIButton new];
    [self addSubview:toFollowBtn];
    [toFollowBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [toFollowBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [toFollowBtn setBackgroundImage:[UIImage imageWithColor:EMBackgroundColor] forState:UIControlStateNormal];
    [toFollowBtn setBackgroundImage:[UIImage imageWithColor:EMButtonClickedColor] forState:UIControlStateNormal];
    [toFollowBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    toFollowBtn.sd_layout
    .topSpaceToView(self, 15)
    .widthIs(60)
    .heightIs(30)
    .rightSpaceToView(self, 30);
    toFollowBtn.sd_cornerRadius = @(5);
    toFollowBtn.clipsToBounds = YES;
    self.toFollowBtn = toFollowBtn;
    [self.toFollowBtn addTarget:self action:@selector(toFollowBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 7. 笔记/关注/粉丝按钮
    UIButton *memoBtn = [UIButton new];
    [self addSubview:memoBtn];
    [memoBtn setTitle:@"笔记" forState:UIControlStateNormal];
    [memoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [memoBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    memoBtn.sd_layout
    .topSpaceToView(midSeperateLine, 0)
    .widthIs(kScreenWidth / 3)
    .heightIs(50)
    .leftEqualToView(self);
    self.memoBtn = memoBtn;
    
    UIButton *followBtn = [UIButton new];
    [self addSubview:followBtn];
    [followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [followBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    followBtn.sd_layout
    .bottomEqualToView(memoBtn)
    .widthRatioToView(memoBtn, 1)
    .heightRatioToView(memoBtn, 1)
    .leftSpaceToView(memoBtn, 0);
    self.followBtn = followBtn;
    
    UIButton *fansBtn = [UIButton new];
    [self addSubview:fansBtn];
    [fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    [fansBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    fansBtn.sd_layout
    .bottomEqualToView(memoBtn)
    .widthRatioToView(memoBtn, 1)
    .heightRatioToView(memoBtn, 1)
    .leftSpaceToView(followBtn, 0);
    self.fansBtn = fansBtn;
}

- (void)setModel:(EMUserModel *)model
{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, model.img]] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    [self.nicknameLabel setText:model.username];
    
    if (!model.isOther) {
        self.toFollowBtn.hidden = YES;
    }
    
    NSString *memoBtnText = [NSString stringWithFormat:@"%ld 笔记", (long)model.projectNumber];
    NSLog(@"%@", memoBtnText);
    [self.memoBtn setTitle:memoBtnText forState:UIControlStateNormal];
    [self.fansBtn setTitle:[NSString stringWithFormat:@"%ld 粉丝", (long)model.fansNumber] forState:UIControlStateNormal];
    [self.followBtn setTitle:[NSString stringWithFormat:@"%ld 关注", (long)model.focusNumber] forState:UIControlStateNormal];
}

#pragma mark - 事件
- (void)avatarImageViewTaped {
    NSLog(@"avatarImageViewTaped");
    
    [self parentViewController].hidesBottomBarWhenPushed = YES; //隐藏 tabbar
    EMHeaderUploadViewController *vc = [[EMHeaderUploadViewController alloc] init];
    [[self parentViewController].navigationController pushViewController:vc animated:YES];
    [self parentViewController].hidesBottomBarWhenPushed = NO;
}

- (void)toFollowBtnClicked {
    self.toFollowBtn.selected = !self.toFollowBtn.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
