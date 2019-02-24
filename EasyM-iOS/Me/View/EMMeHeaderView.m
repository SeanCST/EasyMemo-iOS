//
//  EMMeHeaderView.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMMeHeaderView.h"

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
    [avatarImageView setImage:[UIImage imageNamed:@"icon_memo_add"]];
    [self addSubview:avatarImageView];
    avatarImageView.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 5)
    .widthIs(50)
    .heightIs(50);
    
    // 2. 昵称
    UILabel *nicknameLabel = [UILabel new];
    nicknameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:nicknameLabel];
    nicknameLabel.sd_layout
    .heightIs(22)
    .topSpaceToView(self, 15)
    .leftSpaceToView(avatarImageView, 20);
    [nicknameLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 30)];
    [nicknameLabel setText:@"学霸啊啊"];
    
    // 3. 简介
    UILabel *briefIntroLabel = [UILabel new];
    briefIntroLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:briefIntroLabel];
    briefIntroLabel.numberOfLines = 0;
    briefIntroLabel.sd_layout
    .topSpaceToView(nicknameLabel, 10)
    .leftEqualToView(nicknameLabel)
    .autoHeightRatio(0);
    // 设置最大宽度
    [briefIntroLabel setSingleLineAutoResizeWithMaxWidth:(kScreenWidth - 50 - 30)];
    // 设置最大行数
    [briefIntroLabel setMaxNumberOfLinesToShow:2];
    [briefIntroLabel setText:@"你就当我是学霸吧哈哈哈或哈哈哈哈或哈哈哈哈或哈哈哈😁啊啊"];
    
    // 4. 分割线
    UIView *bottomSeperateLine = [UIView new];
    [self addSubview:bottomSeperateLine];
    bottomSeperateLine.backgroundColor = [UIColor grayColor];
    bottomSeperateLine.sd_layout
    .widthIs(kScreenWidth)
    .heightIs(0.5)
    .leftEqualToView(self)
    .bottomEqualToView(self);
    
    // 5. 关注/粉丝按钮
    UIButton *followBtn = [UIButton new];
    [self addSubview:followBtn];
    [followBtn setTitle:@"113 关注" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    followBtn.sd_layout
    .bottomEqualToView(self)
    .widthIs(100)
    .heightIs(30)
    .centerXIs(kScreenWidth / 4);
    
    UIButton *fansBtn = [UIButton new];
    [self addSubview:fansBtn];
    [fansBtn setTitle:@"1777 粉丝" forState:UIControlStateNormal];
    [fansBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    fansBtn.sd_layout
    .topEqualToView(followBtn)
    .widthRatioToView(followBtn, 1)
    .heightRatioToView(followBtn, 1)
    .centerXIs(kScreenWidth / 4 * 3);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
