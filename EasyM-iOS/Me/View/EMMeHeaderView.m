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

@end


@implementation EMMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        [self setupData];
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
    nicknameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:nicknameLabel];
    nicknameLabel.sd_layout
    .heightIs(17)
    .topSpaceToView(self, 15)
    .leftSpaceToView(avatarImageView, 20);
    [nicknameLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 30)];
    [nicknameLabel setText:@"默认用户名"];
    self.nicknameLabel = nicknameLabel;
    
    // 3. 简介
    UILabel *briefIntroLabel = [UILabel new];
    briefIntroLabel.font = [UIFont systemFontOfSize:12];
    briefIntroLabel.textColor = [UIColor grayColor];
    [self addSubview:briefIntroLabel];
//    briefIntroLabel.numberOfLines = 0;
    briefIntroLabel.sd_layout
    .topSpaceToView(nicknameLabel, 10)
    .leftEqualToView(nicknameLabel)
    .heightIs(13);
//    .autoHeightRatio(0);
    // 设置最大宽度
    [briefIntroLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 40)];
    // 设置最大行数
//    [briefIntroLabel setMaxNumberOfLinesToShow:2];
    [briefIntroLabel setText:@"简介：你就当我是学霸吧哈哈哈或哈哈哈哈或哈哈哈哈或哈哈哈😁啊啊"];
    
    // 4. 分割小段
    UIView *bottomSeperateLine = [UIView new];
    [self addSubview:bottomSeperateLine];
    bottomSeperateLine.backgroundColor = UIColorFromRGB(0xefefef);
    bottomSeperateLine.sd_layout
    .widthIs(kScreenWidth)
    .heightIs(10)
    .leftEqualToView(self)
    .bottomEqualToView(self);
    
    // 5. 关注/粉丝按钮
    UIButton *followBtn = [UIButton new];
    [self addSubview:followBtn];
    [followBtn setTitle:@"113 我关注的人" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [followBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    followBtn.sd_layout
    .bottomSpaceToView(bottomSeperateLine, 5)
    .widthIs(kScreenWidth / 2)
    .heightIs(30)
    .centerXIs(kScreenWidth / 4);
    
    UIButton *fansBtn = [UIButton new];
    [self addSubview:fansBtn];
    [fansBtn setTitle:@"1777 关注我的人" forState:UIControlStateNormal];
    [fansBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    fansBtn.sd_layout
    .topEqualToView(followBtn)
    .widthRatioToView(followBtn, 1)
    .heightRatioToView(followBtn, 1)
    .centerXIs(kScreenWidth / 4 * 3);
    
    // 6. 关注、粉丝之间的分割竖线
    UIView *seperateLine = [UIView new];
    [self addSubview:seperateLine];
    seperateLine.backgroundColor = [UIColor grayColor];
    seperateLine.sd_layout
    .widthIs(1)
    .heightIs(10)
    .centerYEqualToView(followBtn)
    .centerXIs(kScreenWidth / 2);
    
}

- (void)setupData {
    EMUserModel *model = [EMUserInfo getLocalUser];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, model.img]] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    [self.nicknameLabel setText:model.username];
}


#pragma mark - 事件
- (void)avatarImageViewTaped {
    NSLog(@"avatarImageViewTaped");
    
    EMHeaderUploadViewController *vc = [[EMHeaderUploadViewController alloc] init];
    [[self parentViewController].navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
